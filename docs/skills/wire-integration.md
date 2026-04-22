---
name: wire-integration
description: Replaces mock-first or placeholder data wiring with a real integration in a controlled, minimal way—preserving existing UI and derived logic, tightening boundaries, and avoiding broad rewrites. Use after a mock-first feature is stabilised, reviewed, and ready to connect to a real API, AI provider, or external system.
---

# Wire integration (`/wire-integration`)

## Purpose

Connect a stabilised mock-first feature to a **real integration** with the **smallest clean change** possible.

**In scope**

- Replacing mock providers, fixtures, or placeholder wiring with real implementations
- Preserving existing UI, state flow, and derived logic where possible
- Adding real request wiring, auth/env handling, validation, and integration-safe boundaries
- Tightening trust boundaries as real data and real actions are introduced

**Out of scope**

- Rebuilding the feature from scratch
- Refactoring unrelated areas
- Redesigning the UI because real wiring is inconvenient
- Adding new product scope not present in the approved plan or existing mock-first implementation

---

## When to use

Use this after:

- The feature was built in **mock-first** mode or with placeholder wiring
- The product flow is already working and stabilised
- Manual testing and normal review have already happened
- The user wants to connect a **real API, AI provider, or external system**

This skill is especially appropriate when moving from:

- mock data → real API
- mock provider → real provider
- local fixtures → authenticated external service
- fake AI output → real model/provider output

---

## Environment expectation

Prefer running this skill in a **restricted terminal-based agent environment** when the work involves:

- real credentials
- real inboxes/documents/customer data
- real side effects
- real external integrations
- sensitive provider wiring

Use a sandboxed / least-privilege setup where possible.

This skill is **model-agnostic**:

- it should work with any coding agent
- do not assume a specific tool brand
- focus on the security posture, not the worker name

---

## Permission posture

Use the **narrowest practical permission level** for the task.

### Low-risk integration tasks

Examples:

- read-only provider wiring review
- replacing local fixtures with a read-only API
- adding typed response mapping
- wiring non-sensitive display data

Preferred posture:

- normal workspace access is acceptable
- avoid unnecessary command execution
- no network unless the task clearly requires it

### Higher-risk integration tasks

Examples:

- real credentials
- authenticated providers
- inboxes, documents, or customer/user data
- action-taking systems
- auth/env wiring
- sensitive external integrations

Preferred posture:

- use a restricted environment where possible
- start with the lowest practical permissions
- expand only when the task proves it is necessary
- prefer approval-first behavior where available

### Permission layering

Escalate in this order:

1. **Read only**
   - inspect code and understand current behavior

2. **Workspace write**
   - modify only files needed for the task

3. **Command execution**
   - only if required for build, typecheck, tests, or verification

4. **Network access**
   - only if required by the task

5. **Broader filesystem / external access**
   - only if clearly necessary and explicitly justified

### Environment-aware rules

- If the environment supports **fine-grained permission controls**, begin with the most restrictive practical option and expand only when necessary.
- If the environment is **coarse-grained**, simulate least privilege through task constraints and manual approval discipline.
- If local file inspection depends on shell access in the current environment, allow **narrow shell usage for local file inspection only** rather than broad command freedom.
- Do not allow network, installs, or unrelated commands unless the task clearly requires them.
- Do not widen access silently.
- If a task can be completed without shell, network, or broader access, keep those capabilities unused.

---

## Core objective

The goal is to:

1. Keep the **existing product flow**
2. Replace only the **integration boundary**
3. Preserve as much UI and derived logic as possible
4. Introduce real wiring carefully and explicitly
5. Avoid broad changes unless the current mock-first boundary is genuinely insufficient

---

## Integration stance

Assume:

- mock-first architecture should be preserved unless it blocks correct real wiring
- real integrations introduce new risks: auth, secrets, rate limits, request failures, malformed data, permission issues, and side effects
- prompt-only safety is weak; prefer backend enforcement and capability limits
- the safest integration is the one with the **narrowest possible blast radius**

---

## What to inspect first

Before editing, inspect:

- the current mock provider / fixture / placeholder wiring
- the current UI/data flow
- derived logic that depends on the current data shape
- shared types/models/contracts
- env usage and secrets handling
- route/service boundaries
- auth/validation/error handling patterns already present in the repo

Identify:

- what should stay unchanged
- what must be swapped
- whether the integration belongs:
  - in the client
  - in the server
  - in a service/provider layer
  - in config/environment only

---

## Execution rules

1. Preserve the **existing architecture and product behavior** where possible
2. Replace only the **minimum integration boundary** needed
3. Prefer provider-style or service-layer swaps over UI rewrites
4. Keep real credentials and privileged calls out of the client whenever possible
5. Add validation and rule enforcement in the **most authoritative layer**
6. Keep data contracts stable unless reality forces a change
7. If the real provider shape differs, adapt at the boundary rather than leaking provider quirks across the app
8. Keep changes easy to review and easy to back out
9. If the integration introduces real actions, tighten trust boundaries before exposing broad capability
10. Do not silently widen permissions, network access, filesystem access, or env exposure

---

## Preferred implementation pattern

When possible, preserve a structure like:

- shared contract / type
- mock implementation
- real implementation
- narrow selection point / provider swap point

Prefer:

- `MockXProvider` → `RealXProvider`
- `getMockData()` → real service call behind same contract
- adapter/mapper at the boundary
- route/service/provider separation

Avoid:

- scattering provider-specific response shape across UI files
- direct client-side secret usage
- bypassing existing service boundaries just because the mock was simpler

---

## Wiring priorities

Prefer this order:

1. Replace provider or service implementation
2. Add env/config handling
3. Add request validation / response mapping
4. Add failure-state handling
5. Add auth / permission / ownership checks as needed
6. Tighten security around real actions
7. Only then adjust UI if a genuine contract change is unavoidable

---

## Pre-change check

Before implementing, briefly state:

- what mock boundary or placeholder is being replaced
- what real integration is being introduced
- which files are likely to change
- what should remain unchanged
- whether the integration is read-only or action-taking
- any security-sensitive aspects (real secrets, real side effects, real customer/user data)
- what permission posture is being used:
  - read-only
  - workspace write
  - command execution
  - network access
  - broader external access
- whether the environment is being treated as:
  - fine-grained permission-controlled
  - coarse-grained with manual constraints
- why that permission level is justified for this task

Then implement.

---

## What good looks like

A successful run should:

- keep the feature recognizable
- preserve existing UI and pass-3 derived logic where possible
- swap the data source or provider cleanly
- introduce realistic loading/error/auth states where needed
- avoid broad rewrites
- leave the codebase more integration-ready, not more coupled

---

## Special considerations

### Real AI providers

When wiring real AI:

- keep provider calls behind a server boundary when possible
- do not expose secrets client-side
- validate inputs and constrain provider/model selection if relevant
- distinguish clearly between model output and executable actions

### Read-only integrations

If the integration is read-only:

- keep the blast radius narrow
- do not overbuild approval logic that is only needed for action-taking systems

### Action-taking integrations

If the integration can trigger real actions:

- prefer draft/proposal paths before execution
- add approval/status checks where appropriate
- constrain recipient/target/action scope
- avoid freeform execution paths

### Real-world mismatch

If real provider data does not perfectly match the mock contract:

- prefer boundary adapters/mappers
- only change shared contracts if truly necessary
- report the mismatch clearly in the summary

---

## Verification before finishing

Confirm:

- the real integration is correctly wired
- existing product flow still works
- mock-only assumptions are removed where needed
- UI and derived logic were preserved unless change was necessary
- request failures are handled safely
- auth/env handling follows repo patterns
- secrets are not exposed client-side
- blast radius did not widen unnecessarily
- if the integration is action-taking, trust boundaries were tightened appropriately
- the permission posture used was no broader than the task required

---

## Output format

Use this exact structure:

<!-- ADD MARKDOWN CODE BLOCK HERE -->
Wire Complete

Integration introduced:
- [real provider / API / system added]

Permission posture used:
- [read-only / workspace write / command execution / network / broader external access]
- [why it was necessary]
- [fine-grained controls or coarse-grained constraints]

Implemented:
- [summary of changes]

Files changed:
- [list of files]

Preserved:
- [what stayed unchanged intentionally]

Changed at the boundary:
- [provider/service/route/config updates]

Security notes:
- [auth, env, approval, scope, or blast-radius notes]

Review points:
- [what to verify manually]

Deviations:
- [none or explanation]

Blockers:
- [none or explanation]
<!-- END MARKDOWN CODE BLOCK -->

If blocked or only partially completed, use:

<!-- ADD MARKDOWN CODE BLOCK HERE -->
Wire Partial

Integration introduced:
- [attempted provider / API / system]

Permission posture used:
- [read-only / workspace write / command execution / network / broader external access]
- [why it was necessary]
- [fine-grained controls or coarse-grained constraints]

Implemented:
- [what was completed]

Files changed:
- [list of files]

Preserved:
- [what stayed unchanged intentionally]

Changed at the boundary:
- [provider/service/route/config updates]

Security notes:
- [auth, env, approval, scope, or blast-radius notes]

Review points:
- [what to verify manually]

Deviations:
- [none or explanation]

Blockers:
- [what prevented safe completion]
<!-- END MARKDOWN CODE BLOCK -->

---

## Guardrails

- Do not turn this into a general refactor pass
- Do not rewrite the UI just because real data is messier
- Do not leak provider-specific quirks deep into the app without need
- Do not expose secrets in the client
- Do not silently introduce action-taking capability without tightening controls
- Do not use broader permissions than the task requires
- If real integration reveals a contract mismatch, adapt minimally and explain clearly
- If safe real wiring cannot be completed without a broader redesign, stop and report the smallest safe partial progress

---

## Related

- Use **build-pass** or **build-pro** first to create and stabilise the feature in standard or mock-first mode
- Use **security-audit** before and/or after wiring when trust boundaries matter
- Use **security-fix** to implement targeted hardening after the integration is in place