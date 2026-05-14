# gohighlevel

A Ruby SDK for the [HighLevel](https://highlevel.com) (GoHighLevel) API.

- Resource methods generated from the official OpenAPI spec — 40 apps, 700+ endpoints.
- Runtime behaviour (auth resolution, OAuth refresh, webhook verification) hand-written and tested against the canonical docs.
- Faraday 2 transport, Zeitwerk loader, immutable per-client configuration — no global mutable state.
- Ruby 3.3+.

## Installation

```ruby
# Gemfile
gem "gohighlevel"
```

```sh
bundle add gohighlevel
```

The storage-backend gems (`redis`, `activerecord`, `mongo`) are **not** runtime dependencies — add whichever you need to your own `Gemfile`. The default in-memory store needs nothing.

## Quickstart

```ruby
require "gohighlevel"

client = HighLevel::Client.new(private_integration_token: "pit-xxxxxxxx")

# Every app is a resource on the client.
contacts = client.contacts.search_contacts_advanced(
  body: { locationId: "loc-123", pageLimit: 20 }
)

tasks = client.contacts.get_all_tasks(contact_id: "contact-456")
```

Resource method names are the spec's `operationId` in snake_case. Path parameters are required keyword arguments; query parameters are optional keyword arguments; a request body (when the endpoint declares one) is the `body:` keyword argument.

## Authentication

`HighLevel::Client.new` accepts one of four credential modes. Configuration is immutable and per-instance.

```ruby
# 1. Private Integration Token — simplest, always wins when present.
HighLevel::Client.new(private_integration_token: "pit-xxxx")

# 2. Agency access token.
HighLevel::Client.new(agency_access_token: "agency-xxxx")

# 3. Location access token.
HighLevel::Client.new(location_access_token: "loc-xxxx")

# 4. OAuth app credentials — required for the OAuth flows + 401 refresh.
HighLevel::Client.new(client_id: "xxxx", client_secret: "xxxx")
```

You can also pass a prebuilt `HighLevel::Configuration`:

```ruby
config = HighLevel::Configuration.new(
  private_integration_token: "pit-xxxx",
  api_version: "2021-07-28",
  session_storage: HighLevel::Storage::Memory.new,
  instrumenter: ActiveSupport::Notifications
)
HighLevel::Client.new(config)
```

For OAuth-secured endpoints, the SDK resolves the right token per request from the operation's declared security requirements (`Agency-Access`, `Location-Access`, `bearer`, ...), falling back to session storage when no direct token is configured.

### OAuth flows

```ruby
client = HighLevel::Client.new(
  client_id: "xxxx",
  client_secret: "xxxx",
  redirect_uri: "https://your.app/oauth/callback"
)

# 1. Send the user here to authorize.
url = client.oauth.authorization_url(scope: "contacts.readonly contacts.write")

# 2. Exchange the code that comes back on your callback.
tokens = client.oauth.exchange_code(code: params[:code], user_type: "Location")

# 3. Refresh later.
tokens = client.oauth.refresh_token(refresh_token: stored_refresh, user_type: "Location")

# 4. Derive a location token from an agency token.
tokens = client.oauth.get_location_access_token(company_id: "co-1", location_id: "loc-1")
```

When a request returns `401`, the SDK transparently attempts a refresh (using the session in storage), retries once, and — for location tokens — falls back to re-deriving from the company token. A second `401` is propagated, not looped.

## Storage backends

Session storage holds OAuth tokens keyed by resource (company/location) id. `HighLevel::Storage::Memory` is the default and needs no configuration.

| Backend | When to use | Extra gem |
|---|---|---|
| `Storage::Memory` | Tests, single-process apps | — (default) |
| `Storage::ActiveRecord` | Rails apps with an existing database | `activerecord` |
| `Storage::Redis` | Multi-process workers sharing tokens | `redis` |
| `Storage::Mongo` | Parity with TS SDK consumers sharing a Mongo store | `mongo` |

```ruby
# Redis
store = HighLevel::Storage::Redis.new(url: "redis://localhost:6379/0")
HighLevel::Client.new(client_id: "x", client_secret: "y", session_storage: store)

# ActiveRecord — once, in a migration:
HighLevel::Storage::ActiveRecord::Migration.create_table!(connection)
store = HighLevel::Storage::ActiveRecord.new
```

All backends satisfy the same contract (`test/support/session_storage_contract.rb`). Writing your own: subclass `HighLevel::Storage::Base` and implement the seven methods.

## Webhook verification

HighLevel signs webhooks with its private key and publishes the public key — verification is asymmetric, not HMAC. Two schemes are supported: `:rsa` (signature on the `x-wh-signature` header) and `:ed25519` (`x-ghl-signature`).

```ruby
# Sinatra
post "/webhooks/highlevel" do
  body = request.body.read
  HighLevel::Webhooks.verify(
    payload: body,
    signature: request.env["HTTP_X_WH_SIGNATURE"],
    public_key: ENV.fetch("HIGHLEVEL_WEBHOOK_PUBLIC_KEY"),
    scheme: :rsa
  )
  # raises HighLevel::Webhooks::InvalidSignatureError if it doesn't verify
  process(JSON.parse(body))
  status 200
rescue HighLevel::Webhooks::InvalidSignatureError
  halt 401
end
```

```ruby
# Rails controller
def highlevel
  HighLevel::Webhooks.verify(
    payload: request.raw_post,
    signature: request.headers["X-Wh-Signature"],
    public_key: Rails.application.credentials.highlevel_webhook_public_key
  )
  ProcessWebhookJob.perform_later(request.raw_post)
  head :ok
rescue HighLevel::Webhooks::InvalidSignatureError
  head :unauthorized
end
```

Pass the **raw request body bytes** — re-serializing a parsed JSON object changes the canonical form and breaks verification.

## Pagination

The HighLevel API has no uniform pagination convention, so nothing is auto-paginated. `HighLevel::Pagination` is opt-in.

```ruby
# A proc that routes pagination params wherever the endpoint wants them.
fetch = ->(**page) do
  client.contacts.search_contacts_advanced(body: { locationId: "loc-1" }.merge(page))
end

# Each page (raw response):
HighLevel::Pagination.each_page(fetch, cursor_field: :skip, items_field: "contacts") do |page|
  puts page["contacts"].size
end

# Each item, flattened across pages:
HighLevel::Pagination.each_item(fetch, cursor_field: :skip, items_field: "contacts") do |contact|
  puts contact["id"]
end

# Without a block, you get an Enumerator:
enum = HighLevel::Pagination.each_item(fetch, cursor_field: :skip, items_field: "contacts")
enum.lazy.select { |c| c["type"] == "lead" }.first(10)
```

`cursor_field` is the parameter the endpoint advances on (`:offset`, `:skip`, ...). `limit_field` defaults to `:limit`; `page_size` defaults to `100`.

## Error handling

Every non-2xx response raises a typed exception carrying `#status`, `#response_body`, and `#request_id`.

```ruby
begin
  client.contacts.get_all_tasks(contact_id: "missing")
rescue HighLevel::NotFoundError => e
  e.status        # => 404
  e.response_body # => parsed JSON body
  e.request_id    # => the x-request-id header, if present
end
```

| Exception | Trigger |
|---|---|
| `HighLevel::BadRequestError` | 400 |
| `HighLevel::UnauthorizedError` | 401 |
| `HighLevel::ForbiddenError` | 403 |
| `HighLevel::NotFoundError` | 404 |
| `HighLevel::UnprocessableEntityError` | 422 |
| `HighLevel::RateLimitError` | 429 |
| `HighLevel::ServerError` | 5xx |
| `HighLevel::Error` | other non-2xx |
| `HighLevel::ConfigurationError` | bad/missing credentials |
| `HighLevel::NetworkError` | transport-level failure |

All inherit from `HighLevel::Error`, so `rescue HighLevel::Error` catches everything.

## Instrumentation

The SDK emits no logs. Pass any object responding to `#instrument(name, payload, &block)` — `ActiveSupport::Notifications` is the obvious one — as `instrumenter:` and subscribe to the `request.high_level` event.

```ruby
client = HighLevel::Client.new(
  private_integration_token: "pit-xxxx",
  instrumenter: ActiveSupport::Notifications
)

ActiveSupport::Notifications.subscribe("request.high_level") do |*, payload|
  Rails.logger.info("HighLevel #{payload[:method].upcase} #{payload[:url]} → #{payload[:status]}")
end
```

With no `instrumenter` configured, the instrumentation middleware is a transparent pass-through.

## Differences from the official TypeScript SDK

- **Naming** — methods are snake_case; arguments are keyword arguments.
- **No global state** — every collaborator is injected through `HighLevel::Configuration`; there is no global mutable config. Thread-safe by construction.
- **Webhook verification raises** — `HighLevel::Webhooks.verify` returns `true` or raises `InvalidSignatureError`, rather than returning a boolean.
- **Pagination is explicit** — `HighLevel::Pagination` is opt-in; resource methods never auto-paginate.
- **Storage gems are optional** — `redis`/`activerecord`/`mongo` are lazy-required, not runtime dependencies.
- **Generated code is committed** — `bundle add gohighlevel` gives you a working library; there is no install-time codegen.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for the spec-sync, regeneration, and drift-check workflows.

## License

MIT — see [LICENSE.txt](LICENSE.txt).
