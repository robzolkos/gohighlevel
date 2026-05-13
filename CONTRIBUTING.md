# Contributing

## Working with the vendored OpenAPI spec

The Ruby resource layer (Phases 7-8 of `PLAN.md`) is generated from the
official HighLevel OpenAPI spec at
[`GoHighLevel/highlevel-api-docs`](https://github.com/GoHighLevel/highlevel-api-docs).
That repo is **pinned to a SHA** in `script/fetch_specs.rb` and fetched
on demand into `vendor/openapi/`.

### Initial sync

A fresh checkout has no `vendor/openapi/` — the directory is gitignored
and lazily populated by the fetch script. Run:

```bash
bin/sync-spec
```

The script creates the directory, clones the upstream repo into it, and
writes `vendor/openapi/VERSION` with the active SHA + a timestamp.
Re-running with the same SHA is a no-op (no file writes).

### Bumping the pin

1. Find the new target SHA — usually `git ls-remote
   https://github.com/GoHighLevel/highlevel-api-docs.git HEAD`.
2. Edit `PIN_SHA` in `script/fetch_specs.rb`.
3. Run `bin/sync-spec`. The vendored copy advances to the new SHA and
   `vendor/openapi/VERSION` is rewritten.
4. Regenerate the resource layer (Phase 7+):
   ```bash
   bin/generate    # added in Phase 7
   ```
5. Run the full suite — `bundle exec rake`.
6. Commit `script/fetch_specs.rb` + `vendor/openapi/VERSION` + any
   regenerated `lib/high_level/resources/**` and
   `lib/high_level/models/**` changes in one commit. The diff against
   master is the reviewable contract.

### Reference TS SDK pin

`vendor/highlevel-api-sdk/` (pinned via `script/fetch_ts_sdk.sh`) is a
**tiebreaker reference**, not a primary source of truth. Bump it the
same way — edit the SHA in `script/fetch_ts_sdk.sh`, re-run, commit.

## Running the tests

```bash
bundle exec rake             # full suite + rubocop
bundle exec rake test        # just tests
bundle exec ruby -Ilib -Itest test/path/to/some_test.rb   # one file
```

Rubocop is intentionally limited in scope — run it only on changed
`.rb` files. See `AGENTS.md`.
