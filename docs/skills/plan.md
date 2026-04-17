---
name: plan
description: Generates a structured, pass-based implementation plan from a feature brief with strict separation between UI, data wiring, derived logic, and polish—no code. Use when the user asks for a build plan, implementation plan, /plan, pass-based planning, or wants to break a feature into staged passes before coding.
---

# Pass-Based Build Plan (`/plan`)

When invoked, produce **only** the plan—**no code**. Follow the rules and output shape below.

---

## Core Rules

- Do **not** write code
- Do **not** skip steps
- Do **not** combine passes

Break the feature into **4 distinct passes**:

1. UI / Layout
2. Data Wiring
3. Derived Logic
4. Final Polish

Each pass must be **independent** and **build on the previous one**.

### Pass Isolation Rules

- Do **not** include data in Pass 1
- Do **not** include derived logic in Pass 2
- Do **not** introduce new behaviour in Pass 4
- Do **not** move work between passes

If unsure, **defer to a later pass**.

---

## Planning Discipline

- Keep the plan at the level of **implementation guidance**, not implementation detail
- Do **not** choose specific technical solutions unless essential
- Avoid low-level UI mechanics or exact implementation choices
- Avoid referencing specific layout techniques or implementation patterns unless essential to correctness
- Prefer describing **what must be true**, not exactly how it must be coded
- Keep each section **concise**
- Do **not** explore multiple implementation options
- State the intended outcome, not alternative approaches

---

## Repo Awareness Rules

- Do **not** inspect or depend on specific repository implementation details
- Plans must be **implementation-agnostic**
- Only reference reuse at a **conceptual level**
- Do **not** name specific files, hooks, or internal structures

---

## Pass 1 — UI / Layout

**Context**

- Where this feature sits in the app
- What screen, route, or component this belongs to

**Scope**

- What UI elements are included in this pass
- What is explicitly **not** included yet (no data, no logic)

**Layout**

- Structure and hierarchy of components
- Key sections and grouping

**Reuse**

- Existing components, styles, or layout patterns to use

**Constraints**

- No real data
- No derived logic
- No new abstractions unless required for layout

**Implementation order**

1.
2.
3.

**Verification**

- Layout matches intended structure
- Components are clean and reusable
- No unnecessary complexity

---

## Pass 2 — Data Wiring

**Context**

- What data is required and where it comes from

**Scope**

- What data is connected in this pass
- What is **not** included (no derived logic)

**Data**

- Source of truth (API, props, state)
- How data flows into components

**Behaviour**

- Loading states
- Empty states
- Basic rendering of values

**Reuse**

- Existing queries, hooks, or API helpers at a conceptual level

**Constraints**

- Do **not** add derived or computed logic
- Do **not** duplicate backend logic
- Do **not** refactor unrelated structures
- Do **not** introduce sorting or filtering beyond direct display of returned data

**Edge cases**

- Undefined or null data
- Empty lists
- Loading states

**Implementation order**

1.
2.
3.

**Verification**

- Correct data appears in UI
- No placeholder values remain
- Safe handling of loading and empty states

---

## Pass 3 — Derived Logic

**Context**

- What needs to be calculated or decided

**Scope**

- What logic is introduced in this pass

**Data**

- What existing data is used

**Logic**

- Calculations, comparisons, filtering, grouping, or ordering

**Behaviour**

- How UI changes based on logic

**Constraints**

- Do **not** refetch or restructure data
- Do **not** introduce unnecessary abstraction
- Keep logic readable and local where possible
- Do **not** introduce new data sources

**Edge cases**

- Zero values
- Missing fields
- Boundary conditions

**Implementation order**

1.
2.
3.

**Verification**

- Logic produces correct outputs
- Results match expectations
- No duplication of logic

---

## Pass 4 — Final Polish

**Context**

- Final refinement of the feature

**Scope**

- UI cleanup and consistency
- Small UX improvements
- Code simplification

**Behaviour**

- Final interaction behaviour
- Confirm feature completeness

**Reuse**

- Align with existing app patterns

**Constraints**

- Do **not** introduce new features
- Do **not** significantly restructure
- Only refine and simplify

**Edge cases**

- Any remaining inconsistencies
- Minor UX issues

**Verification**

- Feature feels cohesive
- Code is clean and readable
- Matches app patterns
- Works end-to-end

---

## Output Requirements

- Return **all 4 passes**
- Each pass must be **clearly separated**
- Fill each section **where relevant**
- Keep instructions **concise and actionable**
- Focus on **clarity over completeness**
- Avoid over-engineering
- Avoid premature technical detail

If required information is unclear, state **assumptions briefly** instead of guessing.
