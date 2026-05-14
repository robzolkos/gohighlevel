---
name: ghl-drift-check
description: Verify that the committed Ruby resource layer matches what the generator would emit. Two modes — local (regenerate against the currently-pinned OpenAPI SHA) and `--upstream` (compare against upstream HEAD, used by the weekly CI cron). Use after editing the generator templates, after bumping the OpenAPI pin, or any time you want a fast "is everything in sync" check.
---

# ghl-drift-check

Wraps `script/drift_check.rb`. The working tree is always restored to its pre-run state, regardless of whether drift is found — safe to run repeatedly.

## Modes

| Invocation | Question answered |
|---|---|
| `ruby script/drift_check.rb` | "Does committed code match what the generator would emit against the currently-pinned OpenAPI SHA?" Catches forgotten regenerations after template or pin edits. Fast, no network. |
| `ruby script/drift_check.rb --upstream` | "Does committed code match what the generator would emit against upstream HEAD?" Catches API changes we haven't bumped to yet. Used by the weekly CI cron. Needs network. |

## When to run

- **Local mode**: after editing `script/generate.rb`, after running `bin/sync-spec` to bump the pin, or before opening a PR that touches generated code. Also runnable as a sanity check any time.
- **Upstream mode**: the GitHub Actions cron runs this weekly. Locally only when you want to know "do I need to bump the pin?"

## Exit codes

- `0` — no drift.
- `1` — drift detected. The output lists the differing files. To resolve:
  - Local mode: run `bin/generate` and commit the diff.
  - Upstream mode: bump `PIN_SHA` in `script/fetch_specs.rb`, run `bin/sync-spec && bin/generate`, commit the regenerated diff.

## How it works

1. Snapshots `lib/high_level/resources/`, `lib/high_level/models/`, and `lib/high_level/resource_registry.rb` to a tmp dir.
2. (Upstream mode only) Temporarily checks out `vendor/openapi/` at upstream HEAD; restored on exit.
3. Runs `bin/generate`.
4. Diffs the snapshot against the freshly-generated tree.
5. Restores the snapshot so the working tree is byte-identical to its pre-run state.

If you had uncommitted local changes in the watched paths, the script preserves them — the snapshot is taken before the generator runs and restored after.

## Failure modes

- **"vendor/openapi/ is not populated"** — run `bin/sync-spec` first.
- **Drift in upstream mode** — usually intentional (upstream did release something new). Time to bump.
- **Drift in local mode after editing the generator** — expected; run `bin/generate` to roll the templates' output forward.
