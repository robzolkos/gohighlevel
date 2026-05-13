# AGENTS.md

## Testing

- Minitest is used for testing.
- `bundle exec rake test` runs the full suite.
- `bundle exec ruby -Ilib -Itest test/path/to/some_test.rb` runs a single file.

## Linting

- `bundle exec rubocop -a` to autocorrect.
- Run rubocop only on changed Ruby `.rb` files.

## Source-of-truth references

- API surface: `vendor/openapi/` (HighLevel OpenAPI repo, pinned via `script/fetch_specs.rb`).
- Runtime behavior (auth, OAuth, webhooks): `vendor/highlevel-api-sdk/` (official TypeScript SDK, pinned via `script/fetch_ts_sdk.sh`).
