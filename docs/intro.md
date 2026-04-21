# Agentic Playbook

This repo documents my workflow for agentic coding.

The goal is to maintain control, clarity, and learning while leveraging AI for speed.

CHUNKED INSTRUCTION SYSTEM (FULL STACK)

Purpose:
Provide a structured, repeatable agentic workflow for building real-world applications with strong human control, clear decomposition, and continuous improvement loops.

This system supports both:

- Full project builds
- Feature-level development

---

FLOW (FULL PROJECT):

1. Project Anchor Doc
   - Human-defined product intent
   - Defines purpose, users, flows, scope, rules, boundaries, and constraints
   - Anchors truth before any AI involvement

2. /preplan
   - Translates anchor doc into structured understanding
   - Clarifies flows and system shape
   - Prepares clean input for planning stage

3. /plan
   - Defines build-ready scope for a feature or chunk
   - Surfaces assumptions locally
   - Produces clear implementation target (without coding yet)

4. /build-pass (pass-based)
   - Implements in controlled passes:
     1. UI/Layout
     2. Data Wiring (supports mock-first mode)
     3. Derived Logic
     4. Final Polish
   - Stops after each pass for review
   - Maintains strict scope discipline per pass

5. /build-pro (alternative)
   - Executes multiple remaining passes in sequence
   - Used when confidence is high or for smaller features
   - Returns a consolidated result instead of stopping per pass

6. Human Review (inline)
   - Review after each pass or build step
   - Validate correctness, clarity, and alignment with intent
   - Decide whether to proceed or adjust
   - Capture notable findings in `memory.md` if they represent reusable patterns or future skill improvements

7. checks.sh (validation step)
   - Run project checks before deeper review:
     - typecheck
     - lint
     - build
     - tests (if available)
   - Ensures baseline correctness before deeper review
   - Helps separate mechanical issues from architectural issues

8. /project-review (Codex)
   - External AI review using a separate model
   - Focuses on:
     - correctness
     - architecture
     - data integrity
     - contract alignment
   - Uses severity calibration (High / Medium / Low)

9. Decision + Evaluation + Implementation
   - External review findings are evaluated using Cursor (project-aware AI)
   - Cursor is used to:
     - interpret findings in the context of actual codebase
     - validate whether issues are real, relevant, or already handled
     - assess impact on architecture and existing patterns
   - Human then:
     - Accept / partially accept / reject findings
     - Apply minimal, targeted fixes
   - Capture reusable insights in `memory.md` where appropriate

10. Security pass (post-build hardening)
   - /security-audit
     - Code-grounded audit of:
       - untrusted input
       - trust boundaries
       - model-to-action paths
       - blast radius
       - secrets and environment usage
     - Identifies highest-risk issues only

   - /security-fix
     - Applies minimal, targeted fixes
     - Prioritises:
       - auth + route protection
       - server-side enforcement over client trust
       - reduced blast radius
     - Avoids broad refactors

11. /review-retro

- Structured reflection on review findings
- Categorises:
  - accepted
  - rejected
  - partially accepted
  - implemented
- Identifies patterns in issues
- Feeds candidate improvements into `memory.md`

12. /retro

- Broader workflow reflection
- Updates:
  - skills
  - instruction patterns
  - personal system improvements
- Uses `memory.md` as input for refining future behaviour

13. /wire-integration (when required)

- Replaces mock-first wiring with real integrations
- Preserves UI and derived logic where possible
- Introduces:
  - real APIs / providers
  - auth + env handling
  - validation and failure states
- Enforces:
  - narrow integration boundaries
  - minimal blast radius
  - least-privilege permission posture

---

FLOW (FEATURE / SMALL SCOPE):

Feature Anchor Doc (optional)
→ /plan
→ /build-pass or /build-pro
→ Human Review (update memory.md if needed)
→ checks.sh
→ /project-review (optional)
→ Decision + Evaluation (Cursor)
→ /security-audit (optional but recommended for integration features)
→ /security-fix (if needed)
→ /review-retro
→ /retro
→ /wire-integration (when moving from mock → real systems)

---

CORE PRINCIPLES:

1. Human-led intent
   - AI does not decide product direction
   - Human defines system truth upfront

2. Chunked execution
   - Work is broken into manageable units
   - Avoid full-system builds in one pass

3. Pass isolation
   - Each build pass has a clear purpose
   - Prevents mixed concerns and messy output

4. Localised decision-making
   - Assumptions resolved at feature level, not globally
   - Reduces cascading rework

5. External validation
   - Secondary AI (Codex) used for unbiased review
   - Cursor used for project-aware validation of findings

6. Feedback loops + memory
   - Review → memory.md → retro → system improvement
   - memory.md stores:
     - recurring issues
     - useful patterns
     - potential skill updates
   - Enables continuous refinement of workflow

7. Controlled autonomy
   - AI is used for speed, not authority
   - Human remains decision-maker

8. Simplicity over automation
   - Manual steps are kept where they improve understanding
   - Avoid unnecessary orchestration complexity

9. Mock-first → real integration
   - Features are built using mock data first
   - Logic and UX are stabilised before real wiring
   - Real integrations are introduced deliberately, not prematurely

10. Security through constraint
   - Do not rely on prompts for safety
   - Limit what can happen if the system is manipulated
   - Prefer:
     - server-side enforcement
     - constrained actions
     - minimal blast radius

11. Permission awareness (least privilege)
   - Start with minimal capability
   - Expand permissions only when required
   - Separate:
     - low-risk tasks (UI, formatting, local logic)
     - high-risk tasks (APIs, auth, external systems)
   - Maintain control even when tooling is coarse-grained

---

SYSTEM CHARACTERISTICS:

- Scales from feature → full product
- Maintains clarity at every stage
- Minimises rework through structured planning
- Encourages learning through review + retro loops
- Balances efficiency with control
- Tool-agnostic (Cursor for build/evaluation, Codex for external review)
- Supports secure integration workflows without forcing early complexity
- Integrates lightweight automation via checks.sh without losing control

---

MENTAL MODEL:

Project Anchor Doc → defines truth  
/preplan → shapes understanding  
/plan → defines one piece  
/build → constructs the piece  
checks.sh → validates baseline  
/project-review → challenges the piece  
Cursor → evaluates findings in context  
/security-audit → identifies risk  
/security-fix → reduces risk  
memory.md → captures lessons  
/review-retro → structures learning  
/retro → improves the system  
/wire-integration → connects to the real world

Repeat.