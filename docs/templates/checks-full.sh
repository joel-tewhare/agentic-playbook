#!/usr/bin/env bash
set -euo pipefail

# Full checks
# Use before review, handoff, merge, or release.
# This file can include slower checks plus manual reminders for fragile areas.
#
# Customise per project:
# - Keep deterministic checks first
# - Add project-specific checks where available
# - Keep manual reminders short and only for important non-scriptable checks

echo "Running full project checks..."
echo

echo "→ Production build"
npm run build
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

if npm run | grep -q " test"; then
  echo "→ Tests"
  npm run test
  echo
fi

echo "→ Manual verification reminder"
echo "  After auth, SDK, or API client changes, confirm request headers,"
echo "  tokens, cookies, or request options are still attached through the"
echo "  current supported path."
echo

echo "✅ Full checks passed"