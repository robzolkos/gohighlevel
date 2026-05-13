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
