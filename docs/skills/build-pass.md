---
name: build-pass
description: Executes an approved /plan output one pass at a time with strict pass isolation (structure, data, logic, polish), stops after each pass for human review, and does not plan or redesign. Use when the user invokes /build, pastes an approved plan to implement, or asks to implement a pass-based plan with review between passes.
---

# Controlled implementation (`/build-pass`)

## Role

You are **not** the planner. You do **not** redesign the feature. You implement the **approved /plan** output as the contract, **one pass per run**, then stop.

Companion: pass-based plans come from the [plan](../plan/SKILL.md) skill—treat the pasted plan as authoritative.

---

## Core purpose

On each run:

1. Identify the **next incomplete** pass (1→2→3→4).
2. Execute **only** that pass.
3. Stop at the end of the pass—**do not** continue to later passes.
4. Return the **structured summary** below for human review.

If parts of a pass already exist:
- continue from the next meaningful incomplete part of that pass
- do not skip ahead to a later pass

---

## Mode (NEW)

This skill supports two execution modes:

### Standard mode (default)
- Connect to real or existing data sources as defined in the plan

### Mock-first mode
- Used when the feature depends on external APIs, AI, or integrations not yet wired
- Data should be implemented using **mock providers or realistic mock data**
- Real APIs, credentials, and external calls must not be introduced

Use mock-first mode when:
- explicitly requested by the user, OR
- the plan clearly depends on integrations not yet available in the repo

If uncertain:
- prefer mock-first mode and note the assumption in **Notes**

---

## Pass model

| Pass | Focus |
|------|--------|
| **1** | Shell / structure (UI layout) |
| **2** | Connect inputs (**data** wiring) |
| **3** | Decisions (**logic** derived from data) |
| **4** | Refine and prove correctness (**polish**) |

**Data** = what already exists. **Logic** = what is derived from it. Keep them conceptually separate.

---

## Which plan sections to use (by pass)

Interpret the plan using **only** sections relevant to the current pass. Treat later-pass work as **deferred**—do not implement it early unless unavoidable repo reality requires it (then report the deviation).

| Pass | Use these plan sections |
|------|-------------------------|
| **1** | Context, Scope, Layout, Reuse, Constraints, Implementation order, Verification |
| **2** | Context, Scope, **Data**, Behaviour, Constraints, Edge cases, Reuse, Implementation order, Verification |
| **3** | Context, Scope, Data, **Logic**, Behaviour, Constraints, Edge cases, Reuse, Implementation order, Verification |
| **4** | Context, Scope, Behaviour, Constraints, Edge cases, Reuse, Verification |

---

## Execution rules

**Always**

- Follow the approved plan as source of truth.
- Respect pass boundaries strictly.
- Follow **implementation order** when the plan provides it.
- Prefer existing repo patterns over new ones.
- Make the **smallest clean change** that satisfies the pass.
- Keep code readable and easy to review.
- Treat anything outside the current pass as intentionally incomplete, not missing.
- Prefer editor/search tools for code search; do not assume shell utilities (e.g. rg) are available.

**Never**

- Combine passes.
- Add features not in the plan.
- Implement logic before data is wired (when the plan sequences them that way).
- Implement data before structure exists (when the plan sequences them that way).
- Refactor unrelated areas.
- Abstract prematurely.

---

## Repo-aware implementation

Before coding:

- Inspect existing files and patterns.
- Align naming, structure, hooks, and data flow with the codebase.

Prefer extending existing components, reusing utilities, and matching nearby patterns.

If repo reality conflicts with the plan:
- adapt **minimally**
- preserve **intent**
- report the deviation clearly in **Notes**

---

## Pass behaviour

**Pass 1 — UI / layout**

- Visual structure only; placeholders OK.
- No real data wiring; no derived logic.

---

**Pass 2 — Data wiring**

### Standard mode
- Connect real sources; replace placeholders.

### Mock-first mode

- Implement data using **mock data or provider-style abstractions**
- Mirror expected real data shapes as closely as possible
- Avoid direct API calls or credentials
- Prefer patterns that allow later swap to real integration

Examples of acceptable patterns:
- mock data modules
- provider interfaces with mock implementations
- helper functions returning structured data

### Constraints

- Do not introduce real external integrations
- Do not tightly couple UI to mock structure
- Avoid shortcuts that would break when real data is introduced

**Important:**
- Do not add heavy derived logic in this pass (same as standard mode)

---

**Pass 3 — Derived logic**

- Add computed values and interactions on top of wired data.
- Logic must be independent of data source (mock or real).

---

**Pass 4 — Polish**

- Simplify and refine; improve clarity and consistency.
- Do not introduce new feature scope.
- Only refine and simplify what already exists.

---

## Special considerations

- Simplify defensive checks where backend contracts are trusted.
- Extract helpers only when readability improves.
- Avoid abstraction for one-off logic.
- Prefer clarity over cleverness.

---

## Verification before finishing the pass

Verification should confirm correctness, not just visual output.

**Pass 1:** Layout matches intent; reuse correct; not overbuilt.  

**Pass 2:**  
- Data shape matches expected real structure  
- UI renders correctly with wired data  
- Mock data (if used) is realistic and varied  
- No unintended coupling to mock-only patterns  

**Pass 3:** Logic correct and readable; results match expectations; edge cases safe.  

**Pass 4:** Feature cohesive; no unnecessary complexity; matches app patterns.  

---

## Completion rule

After **one** pass is complete: **stop**. Do not start the next pass in the same run.

---

## Input expectation

The user pastes an **approved /plan** output. Do not ask for more context to begin; start from the plan and current repo state.

---

## Output format (required)

Use this structure verbatim:

```markdown
Pass Complete: [Pass number and name]

Implemented:
- [summary of changes]

Files changed:
- [list of files]

Human review:
- [what to verify]

Notes:
- [assumptions or small deviations]

Blockers:
- [none or explanation]

Next:
- [next pass to execute]