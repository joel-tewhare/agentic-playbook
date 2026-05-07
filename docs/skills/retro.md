---
name: retro
description: Improves the user’s agentic coding workflow after a completed implementation and review cycle by synthesizing learnings into small, grounded updates to skills, process steps, and (optionally) memory.md. Use when the user says /retro, asks for a workflow retro, wants to refine skills/process, or after finishing an implementation+review loop.
---

# Workflow Retro (`/retro`)

You are improving the system that guides future AI-assisted work.

## Scope rules (hard)

- Do **not** review product code.
- Do **not** implement features.
- Do **not** propose large rewrites unless strongly justified by repeated evidence.
- Prefer the **smallest** change that would have prevented the issue.
- Treat `memory.md` as **grounded evidence**, not theory.

## Inputs to check (in order)

1. `memory.md` (prioritise newest additions)
2. Retro artifacts (review-retro output, secondary review findings, notes). Paths such as `docs/review-retros/...-review-retro.md` may hold **candidate memory notes** that never reached `memory.md`.
3. Relevant skill files (only if a change is clearly warranted)

Reconcile those candidates in `/retro`: extend existing bullets, add minimal new bullets where needed, or **skip** each with a brief rationale so guidance does not drift between artefact and `memory.md`.

When both artefact and post-implementation `memory.md` exist, **deduplicate** against `memory.md` before suggesting new bullets; **prefer extending** an existing entry when the concept is already there.

Implementation summaries sometimes record “checks/evals not run for this pass”; treat that as a signal for how strong automated evidence is, not as a product defect.

Distinguish between earlier green artefacts, post-fix verification evidence, manual smoke validation, and implementation claims that were not re-verified after changes. Treat verification timing as workflow evidence, not merely pass/fail state.

If an implementation artefact disclaims reruns while review-retro cites passing runs, treat as **reconciliation**: confirm both refer to the same revision or label one artefact as authoritative.

If an input is missing, continue with what you have.

If memory.md has no timestamps:
- Treat bottom-most additions as most recent
- Do not over-index on recency if signal is weak

## What to look for

- **Repeated friction**: unclear steps, repeated manual fixes, recurring confusion
- **Over-defensiveness vs contract alignment**: safety that adds noise vs real protection
- **Responsibility boundaries**: data correctness vs UI display logic
- **Async lifecycle issues**: “data not loaded yet” patterns
- **Naming drift**: variables no longer matching real data shape
- **Workflow drag**: unnecessary refactors, recovery patterns, missing checkpoints
- **Missed invariants**: rules that should be enforced across multiple paths but weren’t
- **Design drift**: repeated inconsistencies between intended UX (from design.md) and implemented UI, layout, or interaction patterns
- **UX confusion**: patterns where users or reviewers misinterpret behaviour due to unclear hierarchy, interaction flow, or state feedback

## Priority rule (critical)

Prioritise improvements that:
1. Prevent correctness issues
2. Strengthen domain invariants or cross-path guarantees
3. Improve build/plan/review behaviour
4. Prevent repeated UX or design inconsistencies when they affect usability, clarity, or user trust

Only then consider:
- wording clarity
- memory.md structure

Avoid suggesting improvements to memory.md formatting unless it is clearly blocking useful retros.

## Classification rules

For each candidate change, classify as one of:

- **Keep**: consistently working; do not change
- **Adjust**: small wording/placement tweak to reduce friction
- **Remove or simplify**: redundant or low-value instruction
- **Script candidate (light)**: repeated deterministic action worth automating later (do not implement scripts here)

Only suggest changes when:
- supported by actual evidence (memory.md or artifacts)
- clearly beneficial
- not already embedded elsewhere

Avoid repeating previous retro suggestions unless they are still unresolved.

- When design.md exists, use it as a reference point for identifying repeated UX or interaction issues
- Do not suggest new design directions unless supported by repeated evidence across builds

## Output format (required)

### Keep
- ...

### Adjust
- ...

### Remove or simplify
- ...

### Script candidates (light)
- ...

### Recommended skill updates

Provide **concrete, minimal wording updates**.

Guidelines:
- Do not rewrite entire files
- Focus on small, high-leverage edits
- Quote exact wording to add/change
- Include design-related updates only when:
  - issues are repeated across builds or reviews
  - they can be resolved with small, clear constraints (e.g. layout rules, interaction patterns)
  - they improve clarity, usability, or consistency

For each suggestion include:

- **File**: path
- **Change**: minimal snippet or bullet

## Final check (before output)

- Are suggestions grounded in actual recent patterns?
- Are changes small and actionable?
- Are we improving behaviour (not just wording)?
- Are we avoiding duplication of existing rules?
- Are we prioritising invariants and correctness over structure?
- Are any design-related suggestions grounded in repeated evidence rather than one-off preference?
- Are we avoiding turning retro into general design critique?

If unsure:
→ default to **Keep**