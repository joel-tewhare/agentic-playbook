---
name: observe-plan
description: Plans project-agnostic AI observability setup by inspecting the repo for AI calls, traces, routing, guards, evals, CLI entries, and runtime evidence surfaces. Use before wiring Langfuse/OpenTelemetry or before creating an observability review flow.
disable-model-invocation: true
---

# Observe Plan (`/observe-plan`)

You are planning observability for an AI-enabled project.

Your job is to inspect the repo and produce a grounded observability setup plan.

Do **not** implement code changes.
Do **not** install packages.
Do **not** edit env files.
Do **not** assume Langfuse, OpenTelemetry, Vercel AI SDK, routing, guards, or evals already exist.

---

## Purpose

Create a project-agnostic plan for capturing useful runtime evidence from AI systems.

The plan should help the user understand:

- what AI/runtime surfaces exist
- what is already observable
- what is currently invisible
- what should be instrumented first
- what tooling fits the current project
- what traces or metrics should appear after setup
- what can safely defer

This skill prepares the ground for later implementation, such as `/observe-wire`.

---

## When to use

Use this when:

- the user asks to set up Langfuse, tracing, telemetry, or AI observability
- the project has AI calls, agents, tools, evals, guards, routing, or model-generated outputs
- the user wants a plan before instrumentation
- the user wants to understand where observability fits in a project
- a project is becoming complex enough that stdout/debug logs are no longer enough

---

## When not to use

Do not use this for:

- implementing tracing directly
- replacing code review, security review, or evals
- generic logging advice without repo inspection
- production monitoring design unrelated to AI/runtime behaviour
- adding dashboards before useful evidence surfaces exist

If the repo has no AI/runtime observability surface, say so clearly and stop with a light recommendation.

---

## Core principle

Observability is runtime evidence.

Code review asks:

> What does the code appear designed to do?

Security review asks:

> What trust boundaries and abuse paths exist?

Observability asks:

> What actually happened when the system ran?

This skill should treat traces, spans, logs, evals, guard events, routing decisions, tool calls, and model responses as evidence sources that can later feed review-style workflows.

---

## Project-stage awareness

Infer the current stage and state assumptions clearly.

Possible stages:

- **No AI surface yet**
  - No LLM calls, agents, evals, guards, or model outputs found.
  - Recommend no heavy observability setup unless planned work requires it.

- **Early AI / mock-first**
  - AI calls may be local, mocked, deterministic, or limited.
  - Focus on simple trace visibility and keeping setup easy to understand.

- **Integrated AI**
  - Real provider calls, prompts, evals, generated outputs, or runtime model behaviour exist.
  - Focus on tracing model calls, inputs, outputs, latency, failures, and costs.

- **Agentic / tool-using**
  - Routing, guards, tools, actions, evals, or multi-step workflows exist.
  - Focus on route decisions, guard decisions, tool inputs/outputs, retries, and failure points.

---

## What to inspect

Inspect the actual repo before planning.

Look for:

### AI calls

- `generateText`
- `streamText`
- `generateObject`
- OpenAI SDK calls
- Anthropic SDK calls
- Google / Gemini SDK calls
- direct model REST calls
- image generation calls
- embedding calls
- reranking calls

### Runtime entry points

- Next.js API routes
- server actions
- Express routes
- CLI scripts
- eval scripts
- cron/jobs
- webhook handlers
- background workers

### Observability setup

- `instrumentation.ts`
- OpenTelemetry setup
- Langfuse setup
- LangSmith / Helicone / other observability tools
- structured logs
- trace IDs
- function IDs
- metadata / session IDs
- flush/shutdown handling for CLI scripts

### Routing

- router prompts
- classifier calls
- intent detection
- confidence scores
- fallback/refusal paths
- route-specific handlers

### Guards

- moderation
- input guards
- output guards
- prompt-injection checks
- PII redaction
- length caps
- approval gates
- action guards

### Tools / actions

- tool definitions
- MCP calls
- shell/file/network access
- email/database writes
- external API calls
- user approval checkpoints
- side-effecting mutations

### Evals

- eval scripts
- Promptfoo
- custom eval runners
- grounding/evaluation calls
- red-team tests
- LLM graders
- pass/fail logs
- saved eval artefacts

### Existing evidence

- `docs/checks`
- `docs/evals`
- `docs/reviews`
- `docs/security-*`
- `docs/observability`
- `memory.md`
- `README.dev.md`
- design docs mentioning AI behaviour, trust, approval, or runtime expectations

---

## Capability status labels

For each observability area, assign one status:

- **Active** — implemented and usable now
- **Partial** — some evidence exists, but gaps remain
- **Not present** — no matching system exists in this project
- **Planned / implied** — docs suggest it is coming later
- **Not enough evidence** — unclear from available files

Missing areas are not failures. They should be documented as current system shape.

Example:

```text
Routing: Not present
Reason: No router, intent classifier, or confidence score found.
Recommendation: No routing observability needed until multiple paths or agents exist.
```

---

## Planning rules

Keep the plan grounded in actual files.
Prefer minimal, understandable instrumentation first.
Do not recommend large observability systems before basic traces work.
Separate app/server runtime from CLI/eval runtime.
Separate AI SDK telemetry from manual spans for direct REST calls.
Do not assume Vercel AI SDK is present.

If the project uses a direct provider SDK, explain whether to:

- migrate calls to AI SDK
- add manual spans
- or defer tracing for that path

If CLI scripts exist, consider flush/shutdown needs.

If serverless or route handlers are involved, consider export flushing.

If trace data may include sensitive prompts, note privacy implications.

If public/env keys are involved, distinguish observability keys from model provider secrets.

Prefer one working trace before complex metadata, dashboards, or eval scoring.

---

## Output format

Use this exact structure.

### Observe Plan Summary

3–6 bullets describing the current observability state.

State whether AI/runtime observability is currently useful for this project.

State the recommended first milestone.

---

### Current Runtime Evidence Map

For each area:

**AI model calls**

- Status:
- Evidence:
- Notes:

**Trace / telemetry setup**

- Status:
- Evidence:
- Notes:

**Routing**

- Status:
- Evidence:
- Notes:

**Guards**

- Status:
- Evidence:
- Notes:

**Tools / actions**

- Status:
- Evidence:
- Notes:

**Evals / red-team**

- Status:
- Evidence:
- Notes:

**CLI / scripts**

- Status:
- Evidence:
- Notes:

---

### AI Call Inventory

List each discovered AI call.

For each:

- File:
- Function / route / script:
- Provider / SDK:
- Model if visible:
- Input type:
- Output type:
- Current observability:
- Recommended instrumentation:
- Priority: High / Medium / Low

If no AI calls are found, say so clearly.

---

### Recommended Observability Setup

Split into phases.

#### Phase 1 — Minimal useful tracing

What should be wired first to prove the observability loop works?

Include:

- required packages if applicable
- required env vars
- entry files
- first AI call to instrument
- expected trace/function name
- verification steps

#### Phase 2 — Runtime clarity improvements

Examples:

- stable function IDs
- metadata
- session IDs
- user IDs where appropriate
- trace grouping
- prompt/input/output visibility
- error/failure visibility

#### Phase 3 — Advanced observability

Only include if relevant.

Examples:

- routing spans
- guard spans
- tool-call spans
- eval scores attached to traces
- red-team trace grouping
- prompt versioning
- manual spans for direct REST/image calls

---

### Suggested Files to Change Later

Do not edit them now.

List likely future implementation files, grouped by purpose.

Example:

Telemetry bootstrap:

- instrumentation.ts
- lib/telemetry.ts

AI SDK calls:

- lib/example/generate.ts

CLI flush:

- scripts/example-eval.ts

---

### Verification Plan

Describe how the user will know setup works.

Include:

- one runtime action to trigger
- expected trace name/functionId
- expected observation data
- what to check if traces are empty
- whether CLI scripts need flush/shutdown

---

### Risks / Privacy Notes

Mention only relevant risks.

Examples:

- prompts may contain user data
- traces may include model outputs
- public browser env vars are visible
- model provider keys must remain server-only
- observability should not log secrets

---

### Defer

List observability work that should wait.

Examples:

- full dashboards
- eval scoring inside Langfuse
- prompt management
- routing review
- guard review
- manual spans for non-AI-SDK REST calls

---

### Recommended Next Step

End with one clear next action.

Example:

Recommended next step:

Run `/observe-wire` for Phase 1 only, aiming for one visible trace from the highest-value AI call.

---

## Quality bar

A strong observe-plan should:

- make the current AI/runtime system easier to understand
- avoid tool-specific assumptions unless grounded in repo files
- separate planning from implementation
- identify missing surfaces without treating them as failures
- recommend the smallest useful observability milestone
- produce a document the user can review before wiring
- support later ai-observe review flows

---

## Final check

Before finishing, confirm:

- Did you inspect actual files?
- Did you avoid implementing changes?
- Did you distinguish active, partial, and not-present observability areas?
- Did you identify the first useful trace target?
- Did you avoid overbuilding?
- Did you explain what evidence the user should expect to see?
