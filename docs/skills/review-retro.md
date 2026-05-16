---
name: review-retro
description: Turns a secondary AI code review into filtered, grounded learning based on what the user accepted, rejected, and implemented, with compact closeout notes and candidate memory.md entries.
---

# /review-retro

You are closing out a secondary AI code review after the user has already completed their own manual review and assessed the review findings.

Your job is not to review the code again.
Your job is to turn the secondary review output into filtered, useful learning based on what the user actually agreed with and followed through on.

---

## Inputs
You may be given:
- the secondary review output (for example /project-review findings)
- the user’s notes about which findings they accepted, partially accepted, or rejected
- notes on which suggestions were actually implemented
- the current memory.md content or examples of its structure and tone
- paths to implementation / validation / review artefacts; if any path is missing from disk, state that explicitly in **Review retro summary** so downstream `/retro` does not assume a closed loop.
- when validation or implementation snapshots file absence/presence under `docs/`, note that snapshot may be superseded later; downstream `/retro` can use a fresh glob when deciding whether a documented gap still exists—without rewriting validation conclusions retroactively.
- when validation asserts required artefact paths are **missing on disk**, state the verification method (e.g. glob/read) and date (or validated-as-of) in the artefact body so a later revision can mark the claim **superseded** without guesswork when paths land.
- when **implementation defer** names one checks/evals basename and **verification later appears** under another, the review-retro summary should say so explicitly (`phone-intake-checks.md` vs `recording-checks.md`) so `/retro` can mark **snapshot superseded** without rereading code.

---

## Goal
Produce a compact closeout summary that helps the user:
1. understand which review findings were genuinely useful
2. separate good suggestions from overreach or low-value feedback
3. identify patterns worth remembering
4. generate candidate notes that fit directly into memory.md

## Core rule
Only include learning that became a real decision, implementation, or reusable principle.
Prioritize review items that change runtime semantics (e.g. error propagation behavior) over purely stylistic improvements.

---

## What to do
- Read the review findings and the user’s accept/reject decisions together
- Focus on actual value, not just what sounded smart
- Prioritise learning that is reusable in future passes and projects
- Treat security and trust-boundary findings as valid inputs when they produced real decisions, hardening, deployment assumptions, reusable enforcement lessons, or blast-radius lessons
- Distinguish between:
  - accepted and implemented
  - accepted but not implemented
  - rejected
- Distinguish implemented fixes from fixes subsequently verified through checks, evals, or manual smoke testing; call out skipped, stale, or earlier-only verification evidence
  - If implementation closeout states checks/evals were not rerun, do not describe separate check/eval artefacts as verification of that fix unless the artefact run is explicitly tied to the same revision (e.g. SHA or dated note).
  - When external reviews cite line numbers, validation should still trace **named handlers** (`onClose`, `onClick` for **Change**, etc.); stale line refs should not block validation if behaviour matches.
- Look for repeated patterns, not one-off noise
- Filter aggressively — fewer high-quality insights is better than many weak ones
- Avoid repeating the same idea across sections
- Prefer the shortest clear expression of each idea without losing meaning
- Capture deeper implementation insights (e.g. transactional safety, reuse context) over generic best practices
- Align all candidate notes with the user’s existing memory.md structure and tone
- Avoid adding notes that are already clearly present in memory.md unless the new version adds meaningful nuance
- If a candidate memory note restates an existing `memory.md` heading or bullet (e.g. security vs workflow), **merge or cross-reference** instead of appending a second full version of the same rule
- If **Memory outcome** claims **Added** to `memory.md`, a later `/retro` should verify that bullet exists (intent-aligned wording counts); treat outdated “Added” claims as superseded once merged.

---

## What not to do
- Do not perform a fresh code review
- Do not invent new findings
- Do not assume the reviewer was correct
- Do not push every accepted suggestion into memory
- Do not rewrite skills directly
- Do not propose scripts here unless the pattern is extremely obvious
- Do not introduce a new structure that conflicts with memory.md

---

## Output format

### Review retro summary
- 3 to 7 short bullets summarising what actually mattered from the secondary review

### Worth keeping
- Bullet points for patterns that seem reusable and worth considering for memory.md

### Rejected or not useful
- Bullet points for suggestions not followed
- Include short reasoning only if it helps improve future review quality

### Candidate memory notes (append-ready)
- Write these so they fit naturally into the user’s existing memory.md structure
- Match tone, format, and level of detail already used
- Do not introduce new headings unless clearly aligned with existing patterns
- Do not repeat ideas already stated in other sections
- Keep notes concise, high-signal, and directly usable
- Prioritise deeper insights over generic advice
- If the provided `memory.md` already contains the same rule (same idea in an existing section), do not repeat full append-ready bullets. Instead add **Memory alignment**: one line naming the existing heading(s) or bullets, and only append genuinely new nuance.
- Before treating **Candidate memory notes** as append-ready, grep or read `memory.md` for the same heading or distinctive keyword (e.g. **Upload approval authority**) so two retros close together do not restate the same bullet.

### Memory outcome (required)
End every review-retro output with exactly one of:
- **Memory update:** **Added** — new rule(s) appended to `memory.md`; briefly name the section(s) or bullets.
- **Memory update:** **Merged** — name the heading(s) or bullets actually **edited** in `memory.md` during this invocation (e.g. extended or folded candidates into existing text). Use **Merged** only when the file changed; if it did not, use **Deferred**. Do not write "merged into existing rules" (or equivalent) unless `memory.md` was edited in this invocation.
- **Memory update:** **Deferred** — reconcile later in `/retro`; name the section(s) or candidates. Use when `memory.md` was not edited here but nuance should carry forward.

This removes ambiguity for `/retro` and humans; do not leave it implicit whether `memory.md` changed.

**Append-ready vs existing prose:** If candidates were written append-ready but the operator folded the same wording into an existing `memory.md` bullet without net new text, use **Deferred** and point to the existing bullet names—reserve **Added** for revisions where `memory.md` gains genuinely new lines.

**Retro reconciliation:** When `/retro` confirms **Candidate memory notes** matched existing `memory.md` (see **Memory alignment**), amend the review-retro artefact so **Memory outcome** reads **Merged** (rule pre-existed; no duplicate append) rather than **Added**, matching sibling closeout hygiene (`login-mvp-review-retro.md`, `xero-mock-review-retro.md`).

---

## Memory update instruction
- Append the Candidate memory notes to memory.md in the most appropriate existing section, or merge/cross-reference into an existing bullet when the content duplicates a rule already present under a nearby heading
- When an implementation artefact says checks or evals were **not run** for that task but a checks/evals doc later shows **green**, reconcile explicitly in the closeout or retro: either state the log is **not** tied to the implementation revision, or add SHA/date to the artefact so readers do not treat green as proof for an unrelated commit.
- Do not overwrite or restructure existing content
- Maintain consistency with formatting and ordering already present
- If no clear section exists, place notes in the closest relevant section without creating unnecessary new headings
- After updating `memory.md`, if nothing new was added because content folded into existing bullets, report **Merged** (not **Added**) in the **Memory outcome** line so `/retro` and humans do not hunt for duplicate entries.

---

## Workflow (human)
- `/review-retro` may be invoked by chained shortcuts (e.g. `/ai-retro-closing`). Avoid running it twice in the same closeout cycle; duplicate runs inflate artefacts, repeat candidate-memory blocks, and waste follow-up time.
- When the workspace is writable, close the loop in the same session: implementation → validation → review-retro → merge **Candidate memory notes** into `memory.md` (or `/retro`). If `memory.md` cannot be updated here (e.g. read-only environment), record **Memory:** pending (or applied in commit …) on the review-retro artefact so reconciliation is not ambiguous.
- When the implementation summary says checks/evals were not rerun in that task, still record **where** current verification lives (e.g. paths to updated checks/evals logs or “pending”) so `/retro` does not see conflicting snapshots.
- If review-retro claims verification from archived checks/evals while the implementation summary says reruns were skipped, require an explicit reconciliation line (SHA/date tie, or “general regression only / lifecycle uncovered”) so `/retro` does not treat both as true without context.

---

## Quality bar
A strong response should feel like:
- filtered
- grounded in real decisions
- concise and high-signal
- consistent with the user’s memory.md style
- immediately usable without extra prompts

It should help the user learn from the review, not repeat the review.
