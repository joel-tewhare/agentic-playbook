---
name: build-pro
description: Executes an approved /plan output across all remaining passes in one continuous run with strict internal pass isolation (structure, data, logic, polish), self-checks after each pass, and a single pass-by-pass summary—no redesign. Use when the user invokes /build-pro, asks for a full-run implementation from an approved plan, or wants all plan passes completed without stopping between passes for review.
---

# Full-run implementation (`/build-pro`)

## Role

You are **not** the planner. You do **not** redesign the feature. You implement the **approved /plan** output as the contract, **all remaining passes in order** in this run, while preserving **pass discipline internally**.

Companion: pass-based plans come from the [plan](../plan/SKILL.md) skill—treat the pasted plan as authoritative. Behaviour matches [build](../build/SKILL.md) except execution is **continuous** (no stop between passes for human review).

---

## Core purpose

On each run:

1. Identify the **earliest incomplete** pass (1→2→3→4).
2. Execute **every remaining pass** in order in this same run.
3. After **each** pass, run **internal pass checks** (below). If blocked, **stop immediately** and return a **partial** summary.
4. If not blocked, continue to the next pass automatically.
5. Return the **full pass-by-pass summary** (output format below).

If parts of a pass already exist:
- continue from the next meaningful incomplete part of that pass
- do not skip ahead to a later pass until the current pass is complete

---

## Mode

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
- prefer mock-first mode and report the assumption under **Deviations**

---

## Pass model

| Pass | Focus |
|------|--------|
| **1** | Shell / structure (UI layout) |
| **2** | Connect inputs (**data** wiring) |
| **3** | Decisions (**logic** derived from data) |
| **4** | Refine and prove correctness (**polish**) |

**Data** = what already exists. **Logic** = what is derived from it.

Maintain separation between structure, data, logic, and polish—even during continuous execution.

---

## Which plan sections to use (by pass)

Interpret the plan using **pass-specific** sections. Treat later-pass work as **deferred** until that pass—do not pull Pass 3–4 logic into Pass 1–2 unless unavoidable repo reality requires it (then report under **Deviations**).

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
- Execute passes **in order**; complete each pass before starting the next.
- Follow **implementation order** when the plan provides it.
- Prefer existing repo patterns; keep changes **minimal and readable**.
- Maintain **internal** pass boundaries (same responsibilities as `/build`).
- Treat anything outside the current pass as intentionally incomplete, not missing.

**Never**

- Add unplanned features or scope.
- Collapse all work into one undifferentiated step.
- Introduce responsibilities of later passes before completing the current pass.
- Refactor unrelated areas.
- Introduce unnecessary abstraction or abstraction creep.

---

## Repo-aware implementation

Before and during coding:

- Inspect existing files and patterns first.
- Align naming, structure, hooks, and data flow with the codebase.
- Extend existing components and reuse utilities where they fit.

If repo reality conflicts with the plan:
- adapt **minimally**
- preserve **intent**
- report under **Deviations**

---

## Pass behaviour (same as `/build`)

**Pass 1 — UI / layout**

- Visual structure; placeholders OK.
- No real data wiring; no derived logic.

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

- Do not add heavy derived logic.

**Pass 3 — Derived logic**

- Computed values and interactions on wired data.
- Logic must remain independent of data source (mock or real).

**Pass 4 — Polish**

- Refine, simplify, prove correctness.
- Do not introduce new feature scope.
- Only refine and simplify what already exists.

---

## Internal pass checks (after each pass)

Verification should confirm correctness, not just visual output.

Before continuing to the next pass, confirm:

- Pass goal is **complete**
- Later-pass logic was not introduced early (unless deviation noted)
- Repo alignment maintained
- Results match expected behaviour for this pass
- After wiring async user actions, ensure promise rejections are either handled at the call site or not thrown if errors are already represented via UI state. Avoid unhandled promises (e.g. `void fn()` with rethrow).
- Safe to proceed

Additional pass-specific checks:

**After Pass 2**
- Data shape matches expected real structure
- UI renders correctly with wired data
- Mock data (if used) is realistic enough to support the intended feature
- No unintended coupling to mock-only patterns

If blocked:
- stop immediately
- return **Build Partial**

---

## Special considerations

- Simplify defensive checks when safe (trusted contracts)
- Extract helpers only when readability improves
- Avoid abstraction creep
- Keep implementation easy to review
- Expo projects: if a dependency requires native code not available in Expo Go, use a dev build or implement a minimal temporary stub for the affected step. Always record the deviation clearly in the build summary rather than silently relying on Expo Go limitations.

---

## Final verification (end of run)

Confirm:

- Passes completed **in order**
- No scope creep
- Logic is correct and results match expected behaviour
- Implementation is clean and consistent with project patterns
- If mock-first mode was used, the feature remains structurally ready for later real integration without broad UI rewrites

---

## Input expectation

User pastes an **approved /plan** output.

Do not ask for additional instructions. Start from plan + repo state.

---

## Output format (required)

```markdown
Build Complete

Pass 1 — UI / Layout
- summary
Files:
- list

Pass 2 — Data Wiring
- summary
Files:
- list

Pass 3 — Derived Logic
- summary
Files:
- list

Pass 4 — Final Polish
- summary
Files:
- list

Review points:
- what to check

Deviations:
- none or explanation

Blockers:
- none or explanation
```

**Partial runs:** 
- Use `Build Partial` instead of `Build Complete`
- Mark unfinished passes as: (not started — blocked)

**Title:** Use `Build Complete` when all four passes finished; if blocked mid-run, use `Build Partial` as the first line instead of `Build Complete`, then the same sections.

---

## Distinction from `/build`

|                 | `/build`        | `/build-pro`      |
| --------------- | --------------- | ----------------- |
| Passes per run  | One             | All remaining     |
| Human review    | After each pass | After full run    |
| Execution style | Controlled      | Continuous        |
| Output          | Single pass     | Full pass summary |
