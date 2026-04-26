---
name: checks-create
description: Creates or updates a project-level checks.sh file from a validation template. Use when a project has no checks.sh, checks need adapting to the project stack, or the user asks to set up validation checks.
---

# Checks Create (`/checks-create`)

You are setting up deterministic project validation.

## Goal

Create or update a `checks.sh` file that can be run before review, handoff, merge, or release.

This skill defines the checks file. It does not run the checks unless explicitly asked.

## Scope rules

- Inspect the project structure before editing.
- Prefer existing project scripts over invented commands.
- Do not install dependencies.
- Do not modify package scripts unless explicitly asked.
- Do not add slow, flaky, or network-dependent checks by default.
- Keep the file simple, readable, and project-specific.
- If a useful check is missing, add a short comment or note rather than inventing a command.

## Inputs to inspect

- `package.json`
- package manager lockfile, if present
- existing `checks.sh`, `checks-fast.sh`, or scripts folder
- framework indicators, for example Next, Vite, Expo, backend-only, full-stack

## Default output

Create or update:

- `checks.sh` for full pre-review validation

Optionally create:

- `checks-fast.sh` if the project would benefit from fast implementation-time checks

## Checks selection

Use only scripts that exist in `package.json`.

Prefer this order for `checks.sh`:

1. production build
2. lint
3. typecheck
4. tests
5. project-specific deterministic checks
6. short manual reminders

Prefer this order for `checks-fast.sh`:

1. lint
2. typecheck
3. fast tests if available

## Full checks template

Use this as the base for `checks.sh` (align content with the inspected project; this is a default npm-oriented layout):

```bash
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
```

## Fast checks template

Use this as the base for `checks-fast.sh` when useful:

```bash
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
```

## Project-specific adaptation

Adapt the template based on the repo:

- Use the detected package manager if obvious.
- Keep `npm` if no package manager preference is clear.
- Include `npm run build` only if the project has a build script.
- Include lint/typecheck/test only if those scripts exist.
- For monorepos or client/server folders, prefer the existing root scripts if available.
- If checks must run in a subdirectory, make that explicit in the script.
- Keep manual reminders short and relevant to the project.

## Manual reminders

Only include reminders that matter for the project.

Examples:

- auth/header/cookie verification after auth or API client changes
- AI SDK/tool-call behaviour after model or SDK changes
- external API integration checks after provider wiring
- mobile/device testing reminders for Expo/native features

Do not add generic reminders that do not apply.

## Output behaviour

When complete:

1. Create or update the checks file(s).
2. Summarise:
   - files created or changed
   - scripts detected
   - checks included
   - useful checks missing from the project
   - any manual reminders added
3. Do not run the checks unless explicitly asked.

## Verification

Before finishing, ensure:

- `checks.sh` starts with a bash shebang.
- `set -euo pipefail` is present.
- commands are deterministic and local.
- missing scripts are not called.
- comments are concise.
- file is executable if possible (e.g. `chmod +x checks.sh` when creating or updating).

## Style

- Keep changes minimal.
- Preserve existing project conventions.
- Prefer clarity over cleverness.
- Do not over-engineer.
