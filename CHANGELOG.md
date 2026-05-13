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
  provided. Fixture matrix in `spec/fixtures/token_resolution.json` covers
  every priority branch and resource-id extraction case. `script/fetch_ts_sdk.sh`
  pins the TS SDK to a reproducible SHA.
