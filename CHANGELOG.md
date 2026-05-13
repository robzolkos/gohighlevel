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
