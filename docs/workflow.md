## AGENTIC PLAYBOOK — WORKFLOW

This document defines how the system is executed in practice using CLI shortcuts and structured outputs.

It is the operational layer that sits on top of the system-intro.

The workflow follows a consistent pattern:

feature → plan → build → validate → review → improve

All stages write outputs to versioned docs to maintain traceability.

---

## WORKFLOW OVERVIEW

Feature idea
→ Preplan
→ Plan
→ Build (pass-based)
→ Human review (per pass)
→ Checks
→ Evals (if applicable)
→ External review + validation
→ Implement fixes
→ Re-run checks + evals
→ Review retro
→ Full retro
→ Retro implementation
→ Wire integration (when required)

---

## ENVIRONMENT SETUP

Goal:
Ensure a consistent CLI environment where all stages can be executed and outputs are written to the repo.

Requirements:

* Shell configured (Oh My Zsh or equivalent)
* Cursor Agent CLI available (`agent`)
* Codex CLI available (`codex exec`)
* PATH includes required binaries

Pattern:

* Non-interactive runs
* File-based outputs
* Feature name used to thread all artifacts

---

## PREPLAN

Goal:
Convert a feature idea into a structured product and UX brief.

Clarifies:

* intent
* flows
* scope
* constraints

Output:
docs/preplans/<feature>.md

Command:
ai-preplan

---

## PLAN

Goal:
Break the feature into clear, pass-based implementation stages.

Defines:

* UI / layout
* data requirements
* logic boundaries
* polish considerations

No code is written here.

Output:
docs/plans/<feature>.md

Command:
ai-plan

---

## BUILD (PASS-BASED)

Goal:
Implement the feature in controlled, isolated passes.

Pass structure:

* UI / Layout
* Data Wiring (mock-first by default)
* Derived Logic
* Final Polish

Each pass:

* is executed independently
* avoids scope bleed
* writes a summary

Output:
docs/builds/<feature>-pass-<n>.md

Command:
ai-build-pass

Alternative:
ai-build-pro (runs all passes in sequence)

---

## HUMAN REVIEW (PER PASS)

Goal:
Pause after each build step to validate before continuing.

Focus:

* alignment with intent
* correctness of behaviour
* clarity of implementation
* unexpected issues

Actions:

* proceed
* adjust implementation
* capture reusable insights in memory.md

This step is mandatory.

---

## CHECKS (DETERMINISTIC VALIDATION)

Goal:
Validate baseline correctness of the system.

Includes:

* build
* typecheck
* lint
* tests (if available)

Step A: Create checks script
Command:
ai-checks-create

Step B: Run checks and save output
Output:
docs/checks/<feature>-checks.md

Command:
ai-checks

---

## EVALS (MODEL / TOOL BEHAVIOUR)

Goal:
Validate behaviour that deterministic checks cannot catch.

Used for:

* tool usage
* JSON structure
* response correctness
* edge cases

Step A: Create eval script
Command:
ai-evals-create

Step B: Run evals
Output:
docs/evals/<feature>-evals.md

Command:
ai-evals

Note:
Evals are optional and mainly used for AI-integrated features.

---

## EXTERNAL REVIEW + VALIDATION

Goal:
Run an independent review and immediately validate findings against the real codebase.

This combines:

* external AI review (Codex)
* validation pass (Cursor)

Process:

* external review generates findings
* validation classifies each finding:

  * Accept
  * Partially accept
  * Reject
  * Defer

Only grounded, relevant findings move forward.

Output:

* docs/reviews/<feature>-review.md
* docs/review-validations/<feature>-validation.md

Command:
ai-review

Important:

* this step performs analysis only
* no fixes are implemented here
* human decision-making follows

---

## IMPLEMENT FIXES

Goal:
Apply only the accepted “Fix now” items.

Rules:

* minimal changes
* no unnecessary refactors
* maintain system integrity

Output:
docs/review-implementations/<feature>-implementation.md

Command:
ai-review-implement

After implementation:

* checks are re-run
* evals are re-run (if applicable)

---

## REVIEW RETRO

Goal:
Extract structured learnings from the review cycle.

Captures:

* what was correct
* what was missed
* recurring patterns

Feeds into memory.md.

Output:
docs/review-retros/<feature>-review-retro.md

Command:
ai-review-retro

Note:
This step may also run as part of ai-retro-closing.

---

## FULL RETRO (WORKFLOW IMPROVEMENT)

Goal:
Refine the system itself.

Updates:

* skill files
* instruction patterns
* workflow structure

No product code changes.

Output:
docs/review-retros/<feature>-retro.md

Command:
ai-retro-closing

---

## RETRO IMPLEMENTATION

Goal:
Apply improvements identified in the retro.

Scope:

* memory.md
* skill files
* workflow docs

Explicitly excludes:

* feature/application code

Output:
docs/review-retros/<feature>-retro-implementation.md

Command:
ai-retro-implement

---

## WIRE INTEGRATION (MOCK → REAL)

Goal:
Replace mock data with real-world integrations.

Used when:

* feature is stable
* logic and UX are validated

Includes:

* API integration
* authentication
* environment variables
* error handling

Constraints:

* minimal blast radius
* preserve existing UI and logic
* maintain clear boundaries

Command:
ai-wire-integration

---

## WORKFLOW CHARACTERISTICS

* Feature name threads all artifacts across docs
* Each stage produces a persistent output
* Human review gates progression
* External review is validated before action
* Fixes are minimal and targeted
* Learning is captured and reused
* Integration is delayed until safe

---

## SIMPLE LOOP

Idea
→ Plan
→ Build
→ Review
→ Validate
→ Improve
→ Integrate

Repeat.
