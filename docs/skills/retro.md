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
2. Retro artifacts (review-retro output, secondary review findings, notes). Paths such as `docs/review-retros/...-review-retro.md` may hold **candidate memory notes** that never reached `memory.md`. When referenced implementation or validation files are missing, note **artefact gap** in the retro output and prefer extending existing **Checks/evals vs revision** guidance in `memory.md` rather than inventing product lessons. Reconcile timestamps and explicit “missing file” snapshots in validation docs (e.g. `recording-validation.md`) against the current repo; when those files exist now, document **superseded** in the retro output instead of treating the oldest snapshot as authoritative. When validation predates optional `docs/checks/*` / `docs/evals/*` paths that land later (Finding 4 pattern), prefer a validation **scope/header refresh** classifying stale missing-path claims as **superseded** so closeout does not re-litigate artefact gaps against the current tree.
3. Relevant skill files (only if a change is clearly warranted)
4. When **security-validation** or secondary audits quote **feature-validation** excerpts, confirm whether implementation superseded the quoted snapshot; classify stale validation narrative as **superseded** rather than debating pass/fail across artefacts.

Reconcile those candidates in `/retro`: extend existing bullets, add minimal new bullets where needed, or **skip** each with a brief rationale so guidance does not drift between artefact and `memory.md`.

When both artefact and post-implementation `memory.md` exist, **deduplicate** against `memory.md` before suggesting new bullets; **prefer extending** an existing entry when the concept is already there.

When **review-retro** lists **Candidate memory notes (append-ready)**, compare verbatim or near-verbatim text against existing `memory.md` bullets first; in `/retro` output classify matches as **already merged** rather than recommending a duplicate append. When the same closeout cycle edits the review-retro artefact, align **Memory outcome** with that (**Merged** or **Deferred**, not **Added**) if `memory.md` already carries the same rule—**append-ready** describes draft usability, not a guarantee the file differs from `memory.md`.

Implementation summaries sometimes record “checks/evals not run for this pass”; treat that as a signal for how strong automated evidence is, not as a product defect.

Distinguish between earlier green artefacts, post-fix verification evidence, manual smoke validation, and implementation claims that were not re-verified after changes. Treat verification timing as workflow evidence, not merely pass/fail state.

If an implementation artefact disclaims reruns while review-retro cites passing runs, treat as **reconciliation**: confirm both refer to the same revision or label one artefact as authoritative. When they disagree on whether passing checks/evals **prove a specific fix**, use **Checks/evals vs revision** in `memory.md` to label whether archived logs bind to that revision or are general regression-only evidence. Do not frame the same situation as conflicting pass/fail across artefacts—classify it as **revision binding**, **Checks/evals vs revision**, and **closeout rerun disclosure** (what was rerun or skipped), including when an implementation summary lists checks/evals as **not rerun** for a landed fix while archived **`docs/checks/*`** output elsewhere still shows green.

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
- **Stale review line pointers vs traced handlers**: reconcile validation notes with implementation when artefacts disagree on line numbers but agree on behaviour

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

- When **`docs/review-retros/*-review-retro.md`** records **Memory update: Added**, still open `memory.md` and compare append-ready wording; if verbatim or near-verbatim text already exists there, classify **Memory outcome** as **Merged** in `/retro` output (and reconcile the review-retro line when touched in-cycle), not **Added**—so no second append is implied.

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