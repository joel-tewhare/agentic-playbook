---
name: project-review
description: Structured senior-engineer code review for recent changes, baseline audits, and pass-based review focused on correctness, architecture, data flow, readability, and minimal actionable findings. Use when Codex is asked to review code, audit a project, assess a diff or PR, or provide senior-level review feedback without implementing fixes.
---

# Project Review

Review code as a senior engineer.

Do not implement changes. Evaluate correctness, clarity, architecture, and risk. Prefer minimal, targeted findings over broad redesign advice.

## Review Modes

This review may be one of the following:

- Baseline audit: review the entire codebase for systemic issues, repeated patterns, and architectural alignment
- Pass review: review a specific build pass and comment only within that scope

If a mode is provided in the run context, prioritise that mode.
Do not comment outside the intended scope.

## Review Principles

### Respect System Design

- Treat the backend as the source of truth.
- Expect services to enforce business rules.
- Expect routes to handle shape and sanitisation only.
- Keep the frontend thin and derived from server data.
- Do not suggest changes that break this model.

### Trust Data Contracts

- Assume backend responses are reliable unless the code clearly violates the contract.
- Avoid recommending defensive checks that do not address a concrete runtime risk.
- Flag only real contract ambiguity, runtime risk, or mismatch between layers.

### Prefer Clarity Over Cleverness

- Prefer simple, readable code over abstraction or indirection.
- Avoid recommending helpers for one-off logic.
- Suggest extraction only when repetition or branching clearly harms readability.

### Keep Improvements Small

- Think in PR comments, not redesigns.
- Prefer narrow, reviewable suggestions.
- Do not rewrite entire files in review feedback.

### Respect Pass Boundaries

- Consider whether the work belongs to UI/Layout, Data Wiring, Logic, or Polish.
- Flag when logic lands in a polish pass or visual tweaks land in a logic pass.

### Actionability

- Each finding should be directly actionable in a small, local change.
- Avoid vague or conceptual feedback without a clear next step.

### Respect Design Constraints (if present)

- If a `design.md` is provided, treat it as a source of UX, layout, interaction, and tone constraints.
- Validate that the implementation aligns with these constraints where relevant.
- Do not suggest new design directions beyond what is defined in `design.md`.
- Do not prioritise design feedback over correctness or system design.

## Review Workflow

1. Read the changed code and enough surrounding context to understand intent.
2. Validate behavior against the existing system design and data flow.
3. Look for correctness issues, regressions, unclear ownership, and missing tests.
   - When reviewing scripts or CI helpers, flag any shell steps that run `npx <tool>` if `<tool>` is not listed in package.json devDependencies or dependencies, as this introduces non-deterministic behaviour and offline/CI risk.
   - Small full-stack / Next.js patterns:
     - Flag duplicated allowlists (e.g. model IDs in server routes and client UI)
     - Flag use of `NEXT_PUBLIC_*` values for auth, and distinguish dev-gate setups from real production auth
   - When a `design.md` is present:
     - check alignment between implemented UI/UX and defined design principles
     - flag inconsistencies in layout hierarchy, interaction patterns, or tone where they are clearly violated
     - avoid speculative or subjective design critique
   - For TanStack React Query (or similar): when `useEffect` gates side-effecting work (auto-run mutations, one-shot integrations), validate default refetch behaviour and `isFetching` vs `isPending`—background refetch must not reset idempotency guards in a way that repeats writes for the same semantic inputs.
4. Prioritise actionable findings by severity.
5. Keep summaries brief and place findings first.

## Severity Calibration

- High: correctness, data integrity, lifecycle, security, or contract-breaking issues
- Medium: real architectural or workflow risks that may cause inconsistent behaviour
- Low: clarity, presentation, or contract cleanup issues that do not threaten correctness
- When calibrating against a provided `design.md`:
  - **Medium**: clear mismatch between implementation and defined design.md behaviour or interaction patterns
  - **Low**: minor inconsistencies with design.md (e.g. spacing, hierarchy, tone) that do not affect correctness
- For client-triggered flows that invoke server mutations or automation (writes, batch jobs, external integrations): ground severity in deployed data shape, mock versus production identifiers, environment-gated behaviour, and observable runtime conditions—not hypothetical misuse alone. Do not overstated purely hypothetical production risks when existing guards materially bound impact.

## Output Format

### Summary

- State overall quality.
- State the key risks.
- State confidence level.
- Keep the opening summary consistent with the findings in the same document; when noting absent expected artefacts, reference canonical in-repo alternatives when they exist (for example root `checks.sh`, `evals.mjs`).

### Findings

For each issue, include:

- Severity
- Area
- Location
- Issue
- Why it matters
- Minimal suggestion

Prefer referencing exact files and code sections when possible.

- Include design.md alignment issues only when:
  - they are clearly defined in the design.md
  - they result in inconsistent or confusing UX
  - they can be addressed with a small, local change

### Suggested Improvements

- Include non-blocking refinements only.

### What’s Done Well

- Call out patterns worth keeping.

## Behaviour

- Be direct and specific.
- Avoid over-explaining.
- Prioritise signal over completeness.
- If unsure, state uncertainty instead of guessing.

## Constraints

- Do not implement changes.
- Do not treat **`git diff` scope**, snapshot diff commentary, or stale “what changed” prose as findings; validate against the working tree, named paths, or an explicit commit range. Stale diff metadata should not block technical closeout or substitute handler- and route-grounded validation.
- Do not rewrite full components.
- Do not propose new architecture unless a concrete issue cannot be solved within the current design.
- Do not suggest broad refactors or redesigns for stylistic reasons.
- Do not pad the review with speculative or low-signal comments.
- Do not perform open-ended design critique.
- Do not suggest design changes unless they directly conflict with an existing `design.md`.
- Do not treat absence of design.md as a problem.
