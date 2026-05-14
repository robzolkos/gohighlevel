# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-05-14

First public release. Built against the HighLevel OpenAPI spec pinned at
`192cd68b065a7423c543d82721eb8644cdc883c7` and the official TypeScript SDK
pinned at `b1a1454b8b7e355037abf57161cd80cedfc8b3cc`.

### Added

- **Core client.** `HighLevel::Client` builds a Faraday connection with a
  full middleware stack; `HighLevel::Configuration` is an immutable `Data`
  carrying every collaborator (no global mutable state). Non-2xx responses
  raise a typed exception hierarchy (`Error` and its subclasses
  `ConfigurationError`, `NetworkError`, `BadRequestError`,
  `UnauthorizedError`, `ForbiddenError`, `NotFoundError`,
  `UnprocessableEntityError`, `RateLimitError`, `ServerError`) carrying
  `#status`, `#response_body`, and `#request_id`.
- **Authentication.** Four credential modes — private integration token,
  agency token, location token, and OAuth client credentials.
  `HighLevel::TokenResolver` resolves the right bearer token per request
  from the operation's OpenAPI security requirements, falling back to a
  simple credential-priority chain.
- **OAuth flows + 401 refresh.** `HighLevel::Oauth` implements
  `authorization_url`, `exchange_code`, `refresh_token`, and
  `get_location_access_token` (form-encoded, on a dedicated connection).
  `HighLevel::Middleware::RefreshOn401` transparently refreshes and
  retries once on a 401, including the location-token-from-company-token
  fallback, with a retry guard so a second 401 can't loop.
- **Session storage.** `HighLevel::Storage::Memory` (the thread-safe
  default), plus `Redis`, `ActiveRecord`, and `Mongo` backends — each
  lazy-requires its gem dependency, so none are runtime dependencies of
  the SDK. All implement the `HighLevel::Storage::Base` seven-method
  contract.
- **Webhook verification.** `HighLevel::Webhooks.verify` supports `:rsa`
  (RSA-SHA256, `x-wh-signature`) and `:ed25519` (`x-ghl-signature`)
  schemes using stdlib `OpenSSL`. Returns `true` or raises
  `HighLevel::Webhooks::InvalidSignatureError`.
- **Pagination.** `HighLevel::Pagination.each_page` / `each_item` — opt-in
  helpers (the API has no uniform pagination convention), handling both
  the limit/offset and limit/skip styles, returning an `Enumerator` when
  called without a block.
- **Generated resource layer.** 40 resource classes covering 700+
  endpoints, generated from the official OpenAPI spec and committed to
  the repo. Each `client.<app>` accessor (`client.contacts`,
  `client.calendars`, ...) is wired through `HighLevel::RESOURCE_REGISTRY`.
- **Instrumentation.** `Configuration#instrumenter` (e.g.
  `ActiveSupport::Notifications`) receives a `request.high_level` event
  around every request; a transparent pass-through when unset.
- **Tooling.** `bin/sync-spec` (pin + vendor the OpenAPI spec),
  `bin/generate` (regenerate the resource layer), `bin/console` (IRB with
  the gem loaded). `script/drift_check.rb` and a weekly GitHub Actions
  cron catch upstream API drift. CI runs the suite on Ruby 3.3 and 3.4.
