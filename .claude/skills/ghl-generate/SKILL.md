---
name: ghl-generate
description: Regenerate the gem's resource and model layer (`lib/high_level/resources/*` and `lib/high_level/models/**/*`) from the pinned HighLevel OpenAPI spec at `vendor/openapi/`. Use after bumping the OpenAPI SHA (see `bin/sync-spec`), after editing the generator templates in `script/generate.rb`, or when verifying that the committed generated code is up to date.
---

# ghl-generate

Wraps `script/generate.rb`. Idempotent: regenerating against the same spec SHA produces byte-identical output, which is the contract the drift check (Phase 9) relies on.

## When to run

- After `bin/sync-spec` advances the pinned OpenAPI SHA.
- After editing `script/generate.rb` (templates, method shapes, etc.).
- As a sanity check before opening a PR that touches the generator.

## Prerequisites

- `vendor/openapi/` is populated (run `bin/sync-spec` first if not).
- `bundle install` has been run (the post-step shells out to rubocop autocorrect).

## How to run

```bash
bin/generate                   # every app under vendor/openapi/apps/
bin/generate contacts          # one app
bin/generate contacts blogs    # several
bundle exec rake               # always finish with a green test + lint run
```

## What gets emitted

For each `vendor/openapi/apps/<app>.json`:

| Output | Shape |
|---|---|
| `lib/high_level/resources/<app>.rb` | `HighLevel::Resources::<Pascal> < Resources::Base` — one snake_case method per operation. |
| `lib/high_level/models/<app>/<schema_snake>.rb` | `HighLevel::Models::<Pascal>::<Schema> = Data.define(...)` — one file per schema with object-shape. |

Every emitted file carries the header:

```
# GENERATED FROM vendor/openapi/apps/<app>.json @ <sha>
# DO NOT EDIT — regenerate via bin/generate.
```

## Conventions the generator applies

- `operationId` (kebab-case) → method name (snake_case). `search-contacts-advanced` → `search_contacts_advanced`.
- Path parameters (`{contactId}`) → required kwargs (`contact_id:`) + Ruby interpolation in the path string (`"/contacts/#{contact_id}"`).
- Query parameters → optional kwargs (default `nil`), gathered into a `.compact`-ed `params:` hash with original (camelCase) keys.
- Header parameters → optional kwargs, gathered into a `headers:` hash with original key casing. `Version` is skipped (the Authentication middleware injects it).
- `requestBody` present → required `body:` kwarg.
- `security` declarations → string array passed to `Resources::Base#request(security:)`, which the Authentication middleware reads via the request's `:high_level_security` context.
- `**_opts` catch-all on every method so callers can forward Faraday options without the resource layer rejecting them.

## Idempotency

Running the generator twice against the same `vendor/openapi/VERSION` produces no file changes. The drift-check skill (Phase 9) will rely on this.

## Failure modes

- **"no spec for app: X"** — the spec file isn't in `vendor/openapi/apps/`. Run `bin/sync-spec` or check the app name.
- **rubocop autocorrect failed** — the generator still wrote the files; review them and fix the template if a class of operations produces non-idiomatic Ruby.
- **Generated file looks malformed** — usually a template bug in `script/generate.rb`; fix the template and re-run.
