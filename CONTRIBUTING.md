# Contributing

## Working with the vendored OpenAPI spec

The Ruby resource layer (`lib/high_level/resources/` and
`lib/high_level/models/`) is generated from the official HighLevel
OpenAPI spec at
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
4. Regenerate the resource layer:
   ```bash
   bin/generate
   ```
5. Run the full suite — `bundle exec rake`.
6. Commit `script/fetch_specs.rb` + `vendor/openapi/VERSION` + any
   regenerated `lib/high_level/resources/**` and
   `lib/high_level/models/**` changes in one commit. The diff against
   master is the reviewable contract.

### Drift check

```bash
ruby script/drift_check.rb            # is committed code in sync with the pinned spec?
ruby script/drift_check.rb --upstream # does upstream HEAD have changes we should bump to?
```

The check is always **safe to re-run**: it snapshots the watched paths, regenerates, diffs, then restores the working tree to its pre-run state. Exit 1 means drift; the output lists differing files. Resolution:

- Local mode drift → `bin/generate` and commit the regenerated diff.
- Upstream mode drift → bump `PIN_SHA` (see above) and regenerate.

A weekly GitHub Actions cron runs the upstream check and opens an `upstream-drift` issue if it finds changes.

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

## Releasing

Releases go out via OIDC trusted publishing — GitHub Actions publishes
the gem; no API key is stored anywhere. There is no `CHANGELOG.md`; the
release notes on each [GitHub Release](https://github.com/robzolkos/gohighlevel/releases)
are the changelog.

**One-time setup:** on rubygems.org, add `robzolkos/gohighlevel` as a
trusted publisher for the `release.yml` workflow. RubyGems supports a
"pending" publisher, so this can be done before the first release.

**Each release** is one command:

```bash
bin/release
```

It shows the current version, lets you pick `patch` / `minor` / `major`
(or release the current version as-is), drafts notes from the commit
log for you to accept or edit, then commits the version bump, pushes,
and creates the GitHub Release. Publishing the gem to RubyGems happens
automatically from there — `release.yml` fires on the published release.
