# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial gem skeleton (Phase 0): gemspec, Bundler, Zeitwerk loader, RSpec,
  RuboCop, SimpleCov, MIT license.
- Core HTTP client (Phase 1): `HighLevel::Configuration` (immutable `Data`),
  `HighLevel::Client` building a Faraday connection, `Authentication` and
  `ErrorHandler` middleware, and a typed exception hierarchy
  (`Error`, `ConfigurationError`, `NetworkError`, `BadRequestError`,
  `UnauthorizedError`, `ForbiddenError`, `NotFoundError`,
  `UnprocessableEntityError`, `RateLimitError`, `ServerError`).
- Token resolver (Phase 2): `HighLevel::TokenResolver` ports
  `getTokenForSecurity` + `extractResourceId` from the official TypeScript
  SDK (vendor/highlevel-api-sdk @ b1a1454). `Middleware::Authentication`
  now consults the resolver per-request when generated code passes a
  security context, falling back to the simple priority chain when none is
  provided. Fixture matrix in `test/fixtures/token_resolution.json` covers
  every priority branch and resource-id extraction case. `script/fetch_ts_sdk.sh`
  pins the TS SDK to a reproducible SHA.
- Session storage (Phase 3): `HighLevel::Storage::Base` defines the
  seven-method backend contract (`init`, `disconnect`, `set_client_id`,
  `set_session`, `get_session`, `get_access_token`, `delete_session`).
  `HighLevel::Storage::Memory` is the default, thread-safe via Monitor,
  application-scoped via the client_id prefix. `HighLevel::Client.new` now
  initializes the configured storage and propagates the client_id when
  OAuth credentials are present. `test/support/session_storage_contract.rb`
  is the shared Minitest module future backends will include.
- OAuth + 401 refresh (Phase 4): `HighLevel::Oauth` implements the four
  OAuth flows directly from the
  [GoHighLevel OAuth docs](https://marketplace.gohighlevel.com/docs/ghl/oauth/) —
  `authorization_url`, `exchange_code`, `refresh_token`,
  `get_location_access_token`. Form-encoded bodies over a dedicated
  Faraday connection. `HighLevel::TokenRefresher` encapsulates the
  recovery policy (direct refresh + location-token-from-company-token
  fallback for behavioral parity with the TS SDK's
  `handleLocationTokenFallback`). `HighLevel::Middleware::RefreshOn401`
  rescues `UnauthorizedError`, asks the refresher for a new token,
  rewrites the Authorization header, and retries once; a context-marked
  retry flag prevents loops. `Configuration` gains a `redirect_uri`
  field. `Client#oauth` is exposed.
- Webhook verification (Phase 5): `HighLevel::Webhooks.verify(payload:,
  signature:, public_key:, scheme:)` supports both `:rsa` (RSA-SHA256,
  arrives on `x-wh-signature`) and `:ed25519` (arrives on
  `x-ghl-signature`). Both schemes use Ruby's stdlib `OpenSSL` — no
  `rbnacl` dep needed in Ruby 3.3+. Raises
  `HighLevel::Webhooks::InvalidSignatureError` on any failure mode
  (tampered body, wrong key, malformed base64, missing inputs).
  `base64` added as an explicit runtime dep (no longer default-gem in
  Ruby 3.4+).
- Spec sync infrastructure (Phase 6): `script/fetch_specs.rb` clones
  `GoHighLevel/highlevel-api-docs` at a pinned SHA into
  `vendor/openapi/` and writes `vendor/openapi/VERSION` (SHA +
  fetched_at + source URL). Idempotent — re-running at the same pin is
  a true no-op (no file writes). `bin/sync-spec` is the thin wrapper.
  `vendor/openapi/` is entirely gitignored; `script/fetch_specs.rb`
  itself is the canonical pin. `CONTRIBUTING.md` documents the sync +
  bump workflow.
- All 41 resources generated + wired (Phase 8): regenerated the full
  resource layer (~1000 generated files) and wired access via a
  generated `HighLevel::RESOURCE_REGISTRY` constant. `Client` uses
  `method_missing` + `respond_to_missing?` to dispatch `client.<app>`
  to the corresponding `Resources::*` class lazily and memoize the
  instance. Three generator bugs surfaced and fixed during the scale-up:
  hyphen-containing app/operation names (snake_case'd at filename and
  identifier level for Zeitwerk), parameter names colliding with Ruby
  keywords (`end` etc., suffixed with `_`), and duplicate path-vs-query
  parameters on the same operation (deduped, path wins). One spec is
  intentionally skipped: `oauth` is hand-written (`HighLevel::Oauth`,
  Phase 4) because the form-encoded transport differs from the
  generator's JSON template; the skip is declared in
  `Generator::SKIP_APPS`. Registry test asserts every spec under
  `vendor/openapi/apps/` (minus skips) has a registry entry, that each
  resource subclasses `Resources::Base`, and that every client accessor
  returns an instance of the correct class.
- Resource generator + first emitted resource (Phase 7):
  `script/generate.rb` (wrapped by `bin/generate` and the `ghl-generate`
  skill) consumes a vendored OpenAPI app spec and emits
  `lib/high_level/resources/<app>.rb` + `lib/high_level/models/<app>/*.rb`.
  Generated method shape: snake_case operation name, required kwargs
  for path params, optional kwargs for query/header params, optional
  `body:` when `requestBody` is declared, `**_opts` catch-all, and a
  delegate to `HighLevel::Resources::Base#request(method:, path:,
  security:, ...)`. The Base runtime sets the request's
  `:high_level_security` context so the existing Authentication
  middleware picks per-op security requirements. Generator runs
  `rubocop -A` as a post-step. First emission: contacts (32 operations,
  61 models). `client.contacts` is the live entry point. Smoke test
  covers method dispatch, path interpolation, query params, body
  encoding, and the operation count vs. spec.
