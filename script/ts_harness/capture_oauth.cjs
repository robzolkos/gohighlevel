#!/usr/bin/env node
// Capture TS SDK OAuth request shapes. Swaps the axios adapter on the
// SDK's internal http client so requests never leave the process; the
// captured `config` (method, URL, headers, data) is what WebMock matchers
// in the Ruby suite consume.
//
// Usage:
//   node capture_oauth.cjs > ../../test/fixtures/oauth_flows.json
//
// The output is a single JSON document with one entry per captured flow.

"use strict";

const { HighLevel } = require("@gohighlevel/api-client");
const path = require("path");

const VENDOR_SDK_PATH = path.resolve(__dirname, "../../vendor/highlevel-api-sdk");

function captureWith(adapterResponse, work, sdkOverrides = {}) {
  const captured = [];

  const sdk = new HighLevel({
    clientId: "test-client-id",
    clientSecret: "test-client-secret",
    redirectUri: "https://example.com/oauth/callback",
    ...sdkOverrides,
  });

  // The OAuth class owns its own axios instance, separate from the main
  // SDK httpClient — swap the adapter on both so we catch every request.
  const httpClients = [sdk.httpClient, sdk.oauth.client].filter(Boolean);
  for (const client of httpClients) {
    client.defaults.adapter = (config) =>
      Promise.resolve().then(() => {
        captured.push({
          method: (config.method || "get").toUpperCase(),
          url: (config.baseURL || "") + (config.url || ""),
          headers: stripDynamicHeaders(config.headers || {}),
          body: config.data ?? null,
          params: config.params || null,
        });
        return {
          status: 200,
          statusText: "OK",
          data: adapterResponse,
          headers: { "content-type": "application/json" },
          config,
        };
      });
  }

  return work(sdk).then(() => captured);
}

function stripDynamicHeaders(headers) {
  // Axios produces AxiosHeaders objects whose enumerable keys include some
  // internals like "User-Agent" and "Accept" that we don't want to assert
  // against in Ruby (they're axios-version-specific). Keep only the
  // semantically meaningful ones.
  const keep = ["Content-Type", "Authorization", "Version", "Accept"];
  const out = {};
  for (const [k, v] of Object.entries(
    typeof headers.toJSON === "function" ? headers.toJSON() : headers
  )) {
    const canonical = keep.find((known) => known.toLowerCase() === k.toLowerCase());
    if (canonical) out[canonical] = String(v);
  }
  return out;
}

async function main() {
  const flows = [];

  flows.push({
    name: "refresh_token_for_location_user",
    description: "POST /oauth/token with grant_type=refresh_token for a location user",
    request: (await captureWith(
      { access_token: "new-loc-token", refresh_token: "new-ref" },
      (sdk) =>
        sdk.oauth.refreshToken(
          "the-refresh-token",
          "test-client-id",
          "test-client-secret",
          "refresh_token",
          "Location"
        )
    ))[0],
  });

  flows.push({
    name: "refresh_token_for_company_user",
    description: "POST /oauth/token with grant_type=refresh_token for a company user",
    request: (await captureWith(
      { access_token: "new-co-token", refresh_token: "new-ref" },
      (sdk) =>
        sdk.oauth.refreshToken(
          "the-refresh-token",
          "test-client-id",
          "test-client-secret",
          "refresh_token",
          "Company"
        )
    ))[0],
  });

  flows.push({
    name: "exchange_authorization_code",
    description: "POST /oauth/token with grant_type=authorization_code (initial token exchange)",
    request: (await captureWith(
      { access_token: "fresh-token", refresh_token: "fresh-ref" },
      (sdk) =>
        sdk.oauth.getAccessToken({
          client_id: "test-client-id",
          client_secret: "test-client-secret",
          grant_type: "authorization_code",
          code: "auth-code-123",
          user_type: "Location",
          redirect_uri: "https://example.com/oauth/callback",
        })
    ))[0],
  });

  flows.push({
    name: "get_location_access_token",
    description: "POST /oauth/locationToken — derive a location token from an agency token",
    request: (await captureWith(
      { access_token: "derived-loc-token" },
      (sdk) =>
        sdk.oauth.getLocationAccessToken({
          companyId: "co-1",
          locationId: "loc-1",
        }),
      { agencyAccessToken: "ag-test-token" }
    ))[0],
  });

  flows.push({
    name: "authorization_url_construction",
    description: "Pure URL-construction helper; no HTTP. Captured as a literal string.",
    url: new (class {
      constructor() {
        const sdk = new HighLevel({
          clientId: "test-client-id",
          clientSecret: "test-client-secret",
          redirectUri: "https://example.com/oauth/callback",
        });
        this.value = sdk.oauth.getAuthorizationUrl(
          "test-client-id",
          "https://example.com/oauth/callback",
          "contacts.readonly contacts.write"
        );
      }
    })().value,
  });

  const output = {
    source: `vendor/highlevel-api-sdk @ ${vendorSha()}`,
    captured_at: new Date().toISOString(),
    flows,
  };

  process.stdout.write(JSON.stringify(output, null, 2) + "\n");
}

function vendorSha() {
  try {
    const { execSync } = require("child_process");
    return execSync("git rev-parse HEAD", { cwd: VENDOR_SDK_PATH }).toString().trim();
  } catch (_e) {
    return "unknown";
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
