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
- If a `design.md` file is provided:
  - treat it as a source of UX and design constraints
  - do not restate or duplicate it in the plan
  - use it to guide layout, behaviour, and interaction decisions where relevant

### SUPPORTING CONTEXT RULES

- If supporting context files are provided or referenced (e.g. `mocks.md`, wireframes, `docs/features/support-docs/` or another path your project documents for planning assets), review them **before** generating the plan.
- Supporting context may include:
  - mock data definitions (e.g. ToolResult, ProposedAction)
  - wireframes or layout images
  - PDFs or templates (e.g. packing slip examples)
  - support-docs bundles when the project defines them (e.g. `docs/features/support-docs/` with `mocks.md`, wireframes, template images)
- Treat these as sources of:
  - data contracts
  - UI structure
  - grouping logic
  - interaction expectations

**Constraints**

- Do **not** inspect implementation code or repository internals
- Do **not** infer file names, hooks, or architecture
- Do **not** plan API wiring or external integrations
- Use supporting context only to guide:
  - UI layout (Pass 1)
  - data shape (Pass 2)
  - grouping/logic expectations (Pass 3)

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
- If the UX depends on a user selection from data that can refresh (sync/cache), the plan must define how that selection is revalidated, updated, or cleared when the source data changes.
- When design.md is present:
  - align plan decisions with its principles and constraints
  - reflect interaction patterns and layout intent where they affect structure
  - do not invent new design directions beyond what is defined
  - do not treat design.md as implementation detail

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
- Ensure layout structure aligns with any provided design.md guidance (e.g. hierarchy, density, grouping)
- If wireframes are present, align layout structure to them; do not restate them, but reflect their hierarchy and grouping

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
- If `mocks.md` or mock data exists, treat it as the source of truth for data shape; ensure the plan aligns with ToolResult → ProposedAction → Section grouping

**Behaviour**

- Loading states
- Empty states
- Basic rendering of values
- Ensure loading, empty, and basic rendering states align with design.md interaction patterns if defined

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
- Use any business rules from supporting docs (e.g. inclusion/exclusion rules); do not invent new logic outside provided context

**Behaviour**

- How UI changes based on logic
- Ensure logic-driven UI changes follow design.md interaction rules (e.g. visibility, prioritisation)

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
- Ensure refinements align with design.md without introducing new design decisions

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

- If supporting context was used, include a short note at the top: `Supporting context reviewed: [list]`
- Return **all 4 passes**
- Each pass must be **clearly separated**
- Fill each section **where relevant**
- Keep instructions **concise and actionable**
- Focus on **clarity over completeness**
- Avoid over-engineering
- Avoid premature technical detail

If required information is unclear, state **assumptions briefly** instead of guessing.