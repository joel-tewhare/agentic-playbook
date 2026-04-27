AGENTIC PLAYBOOK — WORKFLOW

This document defines how the system is executed in practice using CLI shortcuts and structured outputs.

It is the operational layer that sits on top of the system-intro.

The workflow follows a consistent pattern:  
feature → plan → build → validate → review → improve

All stages write outputs to versioned docs to maintain traceability.

---

WORKFLOW OVERVIEW

Feature idea  
→ Preplan  
→ Plan  
→ Build (pass-based)  
→ Human review (per pass)  
→ Checks  
→ Evals (if applicable)  
→ External review  
→ Validate findings  
→ Implement fixes  
→ Re-run checks + evals  
→ Review retro  
→ Full retro  
→ Retro implementation  
→ Wire integration (when required)

---

1. ENVIRONMENT SETUP

Goal:  
Ensure a consistent CLI environment where all stages can be executed and outputs are written to the repo.

Requirements:

- Shell configured (Oh My Zsh or equivalent)
- Cursor Agent CLI available (agent)
- Codex CLI available (codex exec)
- PATH includes required binaries

Pattern:

- Non-interactive runs
- File-based outputs
- Feature name used to thread all artifacts

---

1. PREPLAN

Goal:  
Convert a feature idea into a structured product and UX brief.

This step clarifies:

- intent
- flows
- scope
- constraints

Output:  
docs/preplans/.md

Command:  
ai-preplan

---

1. PLAN

Goal:  
Break the feature into clear, pass-based implementation stages.

Defines:

- UI / layout
- data requirements
- logic boundaries
- polish considerations

No code is written here.

Output:  
docs/plans/.md

Command:  
ai-plan

---

1. BUILD (PASS-BASED)

Goal:  
Implement the feature in controlled, isolated passes.

Pass structure:

1. UI / Layout
2. Data Wiring (mock-first by default)
3. Derived Logic
4. Final Polish

Each pass:

- is executed independently
- avoids scope bleed
- writes a summary

Output:  
docs/builds/-pass-.md

Command:  
ai-build-pass

Alternative:  
ai-build-pro  
Used when running multiple passes in sequence

---

1. HUMAN REVIEW (PER PASS)

Goal:  
Pause after each build step to validate before continuing.

Focus:

- alignment with intent
- correctness of behaviour
- clarity of implementation
- unexpected issues

Actions:

- proceed
- adjust implementation
- capture reusable insights in [memory.md](http://memory.md)

This step is mandatory for maintaining control.

---

1. CHECKS (DETERMINISTIC VALIDATION)

Goal:  
Validate baseline correctness of the system.

Includes:

- build
- typecheck
- lint
- tests (if available)

Step A: Create checks script (once per project or when needed)  
Command:  
ai-checks-create

Step B: Run checks and save output  
Output:  
docs/checks/-[checks.md](http://checks.md)

Command:  
ai-checks

---

1. EVALS (MODEL / TOOL BEHAVIOUR)

Goal:  
Validate behaviour that deterministic checks cannot catch.

Used for:

- tool usage
- JSON structure
- response correctness
- edge cases

Step A: Create eval script (when needed)  
Command:  
ai-evals-create

Step B: Run evals  
Output:  
docs/evals/-[evals.md](http://evals.md)

Command:  
ai-evals

Note:  
Evals are optional and used primarily for AI-integrated features.

---

1. EXTERNAL REVIEW

Goal:  
Get an independent review using a separate model.

Inputs:

- current code
- checks output
- eval output (if present)

Focus:

- correctness
- architecture
- data handling
- contract alignment

Output:  
docs/reviews/-[review.md](http://review.md)

Command:  
ai-review

---

1. VALIDATE FINDINGS

Goal:  
Assess external review findings in the context of the actual system.

Each finding is classified as:

- Accept
- Partial
- Reject
- Defer

Only real, relevant issues move forward.

Output:  
docs/review-validations/-[validation.md](http://validation.md)

Command:  
ai-review-validate

---

1. IMPLEMENT FIXES

Goal:  
Apply only the accepted “Fix now” items.

Rules:

- minimal changes
- no unnecessary refactors
- maintain system integrity

Output:  
docs/review-implementations/-[implementation.md](http://implementation.md)

Command:  
ai-review-implement

After implementation:

- checks are re-run
- evals are re-run (if applicable)

---

1. REVIEW RETRO

Goal:  
Extract structured learnings from the review cycle.

Captures:

- what was correct
- what was missed
- recurring patterns

Feeds into [memory.md](http://memory.md).

Output:  
docs/review-retros/-[review-retro.md](http://review-retro.md)

Command:  
ai-review-retro

---

1. FULL RETRO (WORKFLOW IMPROVEMENT)

Goal:  
Refine the system itself.

Updates:

- skill files
- instruction patterns
- workflow structure

No product code changes.

Output:  
docs/review-retros/-[retro.md](http://retro.md)

Command:  
ai-retro-closing

---

1. RETRO IMPLEMENTATION

Goal:  
Apply improvements identified in the retro.

Scope:

- [memory.md](http://memory.md)
- skill files
- workflow docs

Explicitly excludes:

- feature/application code

Output:  
docs/review-retros/-[retro-implementation.md](http://retro-implementation.md)

Command:  
ai-retro-implement

---

1. WIRE INTEGRATION (MOCK → REAL)

Goal:  
Replace mock data with real-world integrations.

Used when:

- feature is stable
- logic and UX are validated

Includes:

- API integration
- authentication
- environment variables
- error handling

Constraints:

- minimal blast radius
- preserve existing UI and logic
- maintain clear boundaries

Command:  
ai-wire-integration

---

WORKFLOW CHARACTERISTICS

- Feature name threads all artifacts across docs
- Each stage produces a persistent output
- Human review gates progression
- External review provides a second perspective
- Fixes are minimal and targeted
- Learning is captured and reused
- Integration is delayed until safe

---

SIMPLE LOOP

Idea  
→ Plan  
→ Build  
→ Review  
→ Validate  
→ Improve  
→ Integrate

Repeat.