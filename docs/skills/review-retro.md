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
- Distinguish between:
  - accepted and implemented
  - accepted but not implemented
  - rejected
- Look for repeated patterns, not one-off noise
- Filter aggressively — fewer high-quality insights is better than many weak ones
- Avoid repeating the same idea across sections
- Prefer the shortest clear expression of each idea without losing meaning
- Capture deeper implementation insights (e.g. transactional safety, reuse context) over generic best practices
- Align all candidate notes with the user’s existing memory.md structure and tone
- Avoid adding notes that are already clearly present in memory.md unless the new version adds meaningful nuance

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

---

## Memory update instruction

- Append the Candidate memory notes to memory.md in the most appropriate existing section
- Do not overwrite or restructure existing content
- Maintain consistency with formatting and ordering already present
- If no clear section exists, place notes in the closest relevant section without creating unnecessary new headings

---

## Quality bar

A strong response should feel like:

- filtered
- grounded in real decisions
- concise and high-signal
- consistent with the user’s memory.md style
- immediately usable without extra prompts

It should help the user learn from the review, not repeat the review.
