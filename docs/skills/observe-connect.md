---
name: observe-connect
description: Connects already-wired AI telemetry to an observability backend (typically Langfuse) via minimal OpenTelemetry bootstrap, exporters, and env documentation without new spans or capture surface. Use after observe-plan and observe-wire when Vercel AI SDK experimental_telemetry exists, privacy settings are safe, keys will be added manually, and the next goal is proving traces reach Langfuse.
disable-model-invocation: true
---

# Observe Connect (`/observe-connect`)

## Purpose

Connect already-wired AI telemetry signals to an observability backend, usually Langfuse, without expanding the telemetry surface area.

Use this after `observe-plan` and `observe-wire`.

This skill is for the delivery layer:

- telemetry bootstrap
- OpenTelemetry provider/exporter setup
- Langfuse connection
- environment documentation
- local verification instructions

It is not for adding new spans, new AI behaviour, prompt capture, eval tracing, dashboards, or scoring.

Vercel AI SDK `experimental_telemetry` remains experimental in current docs; treat integration APIs and package names as version-sensitive and confirm against official documentation for the installed stack.

---

## Mental model

`observe-wire` creates the signal.

`observe-connect` delivers the signal.

`observe-review` inspects the signal.

Example:

```txt
AI SDK experimental_telemetry
→ OpenTelemetry runtime/bootstrap
→ Langfuse exporter/span processor
→ Langfuse trace UI
```

---

## When to use

Use this skill when:

- AI SDK telemetry has already been added to one or more AI calls.
- The app has safe telemetry metadata and privacy settings.
- Langfuse keys or OpenTelemetry env vars are ready to be added manually by the user.
- The next goal is proving that traces appear in Langfuse.

Do not use this skill before `observe-wire`.

---

## Inputs

Expected context:

- existing observe plan, usually `docs/observability/<feature>-observe-plan.md`
- existing observe wire output, usually `docs/observability/<feature>-observe-wire.md`
- current repo files
- package manager and framework conventions
- any existing instrumentation or observability setup

If relevant files are missing, infer from the repo and document the gap.

---

## Scope

**IN**

- Add the smallest runtime bootstrap needed for OpenTelemetry.
- Add Langfuse/OpenTelemetry exporter or span processor packages if needed.
- Add or update framework-specific instrumentation entry files, for example `instrumentation.ts` in Next.js.
- Wire traces to Langfuse or the selected OpenTelemetry backend.
- Preserve existing telemetry privacy settings.
- Add required env var names to `.env.example`.
- Document local setup and manual verification steps.
- Document what was not verified if manual Langfuse testing is still required.

**OUT**

- Do not add new AI spans beyond what `observe-wire` already created.
- Do not add manual tool spans.
- Do not enable raw prompt capture.
- Do not enable raw output capture.
- Do not add Langfuse prompt management.
- Do not add Langfuse scores.
- Do not add datasets.
- Do not add eval ingestion.
- Do not add dashboards.
- Do not add production sampling policy unless explicitly requested.
- Do not change model selection, tools, prompts, auth, routing, or product behaviour.

---

## Privacy rules

Default to privacy-preserving telemetry.

Do not capture:

- raw user prompts
- assistant responses
- file contents
- fetched page contents
- tool inputs
- tool outputs
- bearer tokens
- provider API keys
- Langfuse secret keys
- `CHAT_API_SECRET`
- `NEXT_PUBLIC_CHAT_API_SECRET`

If the existing telemetry uses `recordInputs: false` and `recordOutputs: false`, preserve that setting.

If documentation suggests enabling full prompt/output capture, do not enable it unless the user explicitly asks.

---

## Human-managed secrets boundary

- The user is responsible for creating Langfuse projects, generating keys, and adding secrets to local or hosted environments.
- This skill may document env var names, but must not generate, rotate, overwrite, print, or commit secrets.
- Secret values must not be copied into `docs/observability/` artefacts.

---

## Implementation guidance

Prefer the official current integration path for the project stack.

For Vercel AI SDK + Langfuse, the expected shape is usually:

AI SDK `experimental_telemetry` → OpenTelemetry → Langfuse span processor/exporter → Langfuse.

The AI SDK telemetry feature emits OpenTelemetry spans when enabled, and Langfuse's Vercel AI SDK integration receives those spans through OpenTelemetry. Check current official docs before choosing exact package names or APIs.

Do not hard-code outdated package names if the installed versions or current docs suggest a different integration path.

**Avoid dual tracing systems:** Do not introduce multiple competing telemetry paths unless explicitly required. Prefer one clear OpenTelemetry export path instead of parallel custom logging, duplicate tracing SDKs, or mixed observability ownership.

---

## Process

### 1. Inspect current state

Check:

- where AI calls are made
- whether `experimental_telemetry` already exists
- whether an instrumentation/bootstrap file already exists
- whether OpenTelemetry packages already exist
- whether Langfuse packages already exist
- whether `.env.example` already documents telemetry variables
- whether existing docs mention the intended backend

### 2. Choose the smallest connection path

Prefer the least invasive setup that proves one visible trace.

For Next.js, this may mean:

- adding `instrumentation.ts`
- registering OpenTelemetry only on the server/runtime side
- adding Langfuse/OpenTelemetry packages
- documenting required env vars

Avoid broad auto-instrumentation unless necessary.

**Prove trace before abstraction:** Prove one visible trace end-to-end before introducing helper wrappers, shared telemetry abstractions, custom observability layers, reusable tracing utilities, or broad auto-instrumentation.

### 3. Preserve app behaviour

Do not change:

- route semantics
- auth guards
- model allowlists
- tool definitions
- prompt text
- eval logic
- response streaming
- UI behaviour

### 4. Add documentation

Create or update:

`docs/observability/<feature>-observe-connect.md`

Include:

- what was connected
- files changed
- packages added
- env vars required
- manual setup steps
- verification steps
- expected trace names
- expected metadata
- privacy notes
- env var names only in observability docs—no secret values in `docs/observability/` artefacts
- what remains deferred

If updating an existing observe-wire doc, keep connect work clearly separated.

### 5. Verification

Run the smallest relevant checks available.

Prefer:

- `npm run build`

or the repo's existing lightweight verification script.

Do not run full evals unless the change touched AI behaviour, prompts, tools, or eval logic.

Manual verification should be documented separately:

1. Add Langfuse keys to `.env.local`.
2. Set `AI_TELEMETRY_ENABLED=true`.
3. Restart dev server.
4. Send an authenticated chat request.
5. Search Langfuse for the expected `functionId`.
6. Confirm prompts and outputs are absent.
7. Confirm safe metadata appears.

---

## Success criteria

This pass is successful when:

- the repo has a clear OpenTelemetry/Langfuse connection path
- env vars are documented but secrets are not committed
- existing AI SDK telemetry can be exported
- app behaviour is unchanged
- one manual test can prove whether traces reach Langfuse

This pass is not responsible for proving tool-level observability, eval correlation, dashboards, prompt management, or scoring.

---

## Completion response

At the end of an `observe-connect` run, respond with:

```markdown
# Observe-connect complete

## Summary

-

## Files changed

-

## Packages added

-

## Env vars documented

-

## Verification run

-

## Manual verification still required

-

## Expected Langfuse trace search

-

## Deferred

-
```
