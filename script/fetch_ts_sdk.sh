#!/usr/bin/env bash
# Fetch the official HighLevel TypeScript SDK into vendor/ at a pinned SHA.
# Used as the runtime-behavior source of truth for token resolution, OAuth,
# and webhook verification.
set -euo pipefail

REPO="https://github.com/GoHighLevel/highlevel-api-sdk.git"
SHA="b1a1454b8b7e355037abf57161cd80cedfc8b3cc"
DEST="vendor/highlevel-api-sdk"

if [ -d "$DEST/.git" ]; then
  cd "$DEST"
  current=$(git rev-parse HEAD)
  if [ "$current" = "$SHA" ]; then
    echo "TS SDK already at $SHA — nothing to do."
    exit 0
  fi
  git fetch --depth 1 origin "$SHA"
  git checkout -q "$SHA"
else
  mkdir -p "$(dirname "$DEST")"
  git clone --filter=blob:none "$REPO" "$DEST"
  cd "$DEST"
  git checkout -q "$SHA"
fi
echo "TS SDK pinned at $SHA"
