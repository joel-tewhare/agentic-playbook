# Agentic Playbook — System Intro

This repo documents my system for agentic coding.

The goal is to maintain control, clarity, and learning while leveraging AI for speed.

---

## PURPOSE

Provide a structured, repeatable system for building real-world applications using AI, while keeping the human in control of:

- product intent
- system design
- decision-making
- quality standards

This system supports both:

- full project builds
- feature-level development

---

## SYSTEM OVERVIEW

This is a human-led, AI-assisted workflow built on:

- clear upfront intent
- structured decomposition
- controlled implementation
- deliberate human review
- external validation
- continuous improvement

It is designed to:

- reduce rework
- prevent scope drift
- surface issues early
- improve over time through feedback loops

---

## CORE FLOW (CONCEPTUAL)

Project Anchor → Understanding → Planning → Controlled Build → Human Review → Validation → External Review → Evaluation → Security → Learning → System Improvement → Integration

Each stage has a specific role:

---

### 1. Project Anchor (Human-defined truth)

Defines:

- purpose
- users
- flows
- scope
- constraints
- boundaries

This is the source of truth before any AI involvement.

---

### 2. Understanding

Translates intent into structured system understanding.

Clarifies:

- flows
- entities
- interactions
- system shape

Prepares clean input for planning.

---

### 3. Planning

Defines a build-ready slice of the system.

- scoped to a feature or chunk
- resolves assumptions locally
- avoids premature global decisions

No implementation yet, only structure.

---

### 4. Controlled Build (Pass-based)

Implementation is broken into isolated passes:

1. UI / Layout
2. Data Wiring (supports mock-first approach)
3. Derived Logic
4. Final Polish

Each pass has:

- a single responsibility
- strict scope boundaries

This prevents mixed concerns and reduces complexity.

---

### 5. Human Review

A deliberate pause to assess the current state before continuing.

Focus areas:

- alignment with intent
- clarity of implementation
- correctness of behaviour
- unexpected issues or edge cases

The human decides whether to:

- proceed
- adjust
- capture learnings

This maintains control and reinforces understanding.

---

### 6. Validation (Baseline correctness)

Ensures the system works at a mechanical level:

- build correctness
- type safety
- linting
- tests (if applicable)

Separates mechanical issues from architectural issues.

---

### 7. External Review (Second perspective)

A separate AI reviews the system for:

- correctness
- architecture
- data integrity
- contract alignment

Provides an unbiased perspective.

---

### 8. Evaluation (Grounded decision-making)

Review findings are:

- interpreted in context of the actual system
- assessed for real impact

Each finding is:

- accepted
- partially accepted
- rejected
- deferred

Fixes are:

- minimal
- targeted
- intentional

---

### 9. Security (Post-build hardening)

Focuses on:

- untrusted input
- trust boundaries
- model-to-action paths
- blast radius
- secret handling

Prioritises:

- server-side enforcement
- constrained actions
- least privilege

---

### 10. Learning (Structured reflection)

Captures:

- recurring issues
- useful patterns
- system improvements

Stored in `memory.md` to influence future work.

---

### 11. System Improvement

Refines:

- skills
- instruction patterns
- workflow structure

Improves how future work is performed, not just the current feature.

---

### 12. Integration (Mock → Real systems)

Moves from safe, local development to real-world systems.

- replaces mock data with real integrations
- introduces APIs, auth, and external dependencies
- preserves stable UI and logic where possible

This is done deliberately, not during initial build.

---

## CORE PRINCIPLES

### 1. Human-led intent

AI does not decide product direction.  
The human defines system truth.

---

### 2. Chunked execution

Work is broken into manageable units.  
Avoid full-system builds in one pass.

---

### 3. Pass isolation

Each build pass has a clear purpose.  
Prevents mixed concerns and messy output.

---

### 4. Localised decision-making

Assumptions are resolved at the feature level.  
Reduces cascading rework.

---

### 5. External validation

A second system is used to challenge assumptions.  
Prevents tunnel vision.

---

### 6. Feedback loops + memory

Work improves over time through:

Review → Memory → Reflection → System updates

---

### 7. Controlled autonomy

AI is used for speed, not authority.  
The human remains the decision-maker.

---

### 8. Simplicity over automation

Manual steps are kept where they improve understanding.  
Avoid unnecessary orchestration.

---

### 9. Mock-first → real integration

Features are built safely first, then connected to real systems later.

- stabilise UX and logic first
- introduce risk only when necessary

---

### 10. Security through constraint

Do not rely on prompts for safety.

Instead:

- limit capabilities
- reduce blast radius
- enforce rules server-side

---

### 11. Permission awareness (least privilege)

Start with minimal access.

Expand only when required, especially for:

- APIs
- external systems
- sensitive data

---

## SYSTEM CHARACTERISTICS

- Scales from feature → full product
- Maintains clarity at every stage
- Minimises rework through structured planning
- Encourages learning through review and reflection
- Balances speed with control
- Supports safe integration of real systems
- Tool-agnostic at the conceptual level

---

## MENTAL MODEL

Project Anchor → defines truth  
Understanding → shapes the system  
Planning → defines a slice  
Build → constructs the slice  
Human Review → validates intent  
Validation → ensures it works  
Review → challenges it  
Evaluation → decides what matters  
Security → reduces risk  
Memory → captures learning  
Reflection → improves the system  
Integration → connects to reality  

Repeat.