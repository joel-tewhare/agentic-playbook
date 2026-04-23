#!/usr/bin/env bash
set -euo pipefail

# Fast checks
# Use during active implementation for quick feedback.
# Keep this focused on the highest-signal checks with low runtime cost.

echo "Running fast project checks..."
echo

if npm run | grep -q " lint"; then
  echo "→ Lint"
  npm run lint
  echo
fi

if npm run | grep -q " typecheck"; then
  echo "→ Typecheck"
  npm run typecheck
  echo
fi

echo "✅ Fast checks passed"