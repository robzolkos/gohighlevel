---
name: ghl-port-oauth
description: Regenerate the OAuth request-shape fixture (`test/fixtures/oauth_flows.json`) from the vendored HighLevel TypeScript SDK. Use whenever the TS SDK pin in `script/fetch_ts_sdk.sh` is bumped, when adding a new OAuth flow to capture, or when the Ruby OAuth tests need updated WebMock stubs.
---

# ghl-port-oauth

Captures the real wire-shape (method, URL, headers, body) of every OAuth call the official `@gohighlevel/api-client` makes, by swapping a capturing adapter onto the SDK's axios instances. The resulting JSON drives WebMock-style stubs in the Ruby OAuth tests.

This skill replaces "human reads `vendor/highlevel-api-sdk/lib/code/oauth/oauth.ts` and writes Ruby fixtures by hand."

## When to run

- After bumping the TS SDK pin in `script/fetch_ts_sdk.sh`.
- After adding a new flow to `script/ts_harness/capture_oauth.cjs`.
- When `test/fixtures/oauth_flows.json` is stale and a Ruby OAuth test fails because of a request-shape mismatch.

## Prerequisites

- Node 18+ on PATH.
- The vendored TS SDK is present (`script/fetch_ts_sdk.sh` has been run) and built.

## How to run

```bash
# One-time setup: fetch + build the vendored SDK.
script/fetch_ts_sdk.sh
(cd vendor/highlevel-api-sdk && npm install --silent && npm run build)

# Install harness deps (npm link to the built SDK).
(cd script/ts_harness && npm install --silent)

# Capture flows and overwrite the fixture.
node script/ts_harness/capture_oauth.cjs > test/fixtures/oauth_flows.json
```

The harness writes a single JSON document to stdout with one entry per flow. The `source` field records the TS SDK SHA so reviewers can match the fixture to the source.

## What gets captured

The harness covers every OAuth path the Ruby SDK needs to replicate:

| Flow | TS method | Endpoint |
|---|---|---|
| `refresh_token_for_location_user` | `Oauth.refreshToken(..., "Location")` | `POST /oauth/token` |
| `refresh_token_for_company_user` | `Oauth.refreshToken(..., "Company")` | `POST /oauth/token` |
| `exchange_authorization_code` | `Oauth.getAccessToken({ grant_type: "authorization_code", ... })` | `POST /oauth/token` |
| `get_location_access_token` | `Oauth.getLocationAccessToken(...)` | `POST /oauth/locationToken` |
| `authorization_url_construction` | `Oauth.getAuthorizationUrl(...)` (no HTTP) | (URL only) |

Each HTTP entry has `method`, `url`, `headers` (semantic ones only — see `stripDynamicHeaders` in the harness), `body` (URL-encoded form string), and `params`.

## Idempotency

Running the skill twice against the same TS SDK SHA produces a byte-identical fixture (modulo the `captured_at` timestamp). The Ruby tests should compare on `request.method/url/body/headers` only — not on `captured_at` or `source`.

## Updating the harness

To add a new flow, edit `script/ts_harness/capture_oauth.cjs` and push another `flows.push({...})` block, then re-run the skill. The harness file is intentionally small (~150 lines) — keep it that way.

## Failure modes

- **"Cannot find module '@gohighlevel/api-client'"**: vendored SDK isn't built. Run `npm run build` in `vendor/highlevel-api-sdk/`.
- **"GHLError: Agency Access Token required..."**: a flow's `captureWith(...)` call needs a `sdkOverrides` argument supplying the right precondition token. See the `get_location_access_token` entry as a template.
- **Headers in capture differ from previous run**: axios bumped a default. Update `stripDynamicHeaders` to keep only headers the Ruby tests need to assert on.
