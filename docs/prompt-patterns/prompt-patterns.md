# Prompt Patterns

Reusable prompt patterns for planning, building, evaluating, and maintaining agentic workflows.

---

## Pattern: Brainstorm → Feature Doc + design.md

### Purpose

Convert a raw brainstorm into two aligned outputs:
- Feature / Project Planning Doc (functionality)
- design.md (experience and behaviour)

---

### Prompt

Take the following brainstorm and map it into two outputs:

#### 1. Feature / Project Planning Doc

Focus on:
- functionality
- user outcomes
- scope (in / out)
- data and dependencies
- rules and constraints
- edge cases and boundaries

Capture:
- what the system should do

Do not include:
- visual design
- tone or stylistic preferences  
(unless they directly affect behaviour)

---

#### 2. design.md

Use a structured design.md format.

Focus on:
- UX and interaction patterns
- layout and hierarchy
- visual direction (high-level)
- tone and communication style
- accessibility and usability constraints

Capture:
- how the product should feel and behave

Do not:
- restate feature logic  
(unless it directly affects experience)

---

### Output Requirements

Both outputs must be:

- aligned (no contradictions)
- non-duplicative
- implementation-aware
- suitable for use in:
  - `/preplan`
  - `/plan`
  - `/build-pass`
  - `/build-pro`

If information is missing:
- include assumptions
- include open questions

---

### Input

[Paste brainstorm here]

---

## Pattern: /build-pass Add-ons

### Purpose

Provide situational constraints when invoking `/build-pass` to maintain strict pass discipline.

Use only when needed. These are not always required.

---

### Pass 1 – UI / Layout

- Do not implement data, derived logic, or future-pass behaviour
- Focus only on structure and layout
- Apply high-level design direction without over-polishing

---

### Pass 2 – Data Wiring

- Wire only required data for the current feature scope
- Prefer simple, single-path implementations (happy path)
- Do not introduce advanced branching or optional flows yet
- Avoid adding derived logic

---

### Pass 3 – Derived Logic

- Implement only logic required for correct behaviour
- Avoid premature optimisation or abstraction
- Do not introduce polish or UX enhancements beyond correctness

---

### Pass 4 – Polish

- Apply only refinements and improvements
- Incorporate accepted review findings
- Do not introduce new features or expand scope
- Avoid broad refactors

---

## Pattern: Skill Update (Post-Retro)

### Purpose

Apply small, targeted improvements to reusable skill files after a `/review-retro` + `/retro` cycle.

---

### Prompt

Update my skill files based on the following retro improvements.

---

### Files

- <path-to-skill-file-1>
- <path-to-skill-file-2>

---

### Changes to implement

1. In `<skill-file-1>`:

- Under "<section name>", add:
  "<new rule or checkpoint>"

- Under "<section name>", add:
  "<new rule or checkpoint>"

2. In `<skill-file-2>`:

- Under "<section name>", add:
  "<new rule or checkpoint>"

---

### Constraints

- Keep changes minimal and append-only where possible
- Do not restructure the files
- Do not modify unrelated content
- Maintain existing tone and formatting

---

### Output

- Apply updates directly to the files
- Then provide a brief summary:
  - what was added
  - where it was added

---

### Notes

- Use only for small, high-confidence improvements
- Base changes on real retro findings (not hypothetical ideas)
- Always manually review the diff after applying

---

## Pattern: Output Evaluation Design

### Purpose

Define simple, testable evaluation checks for LLM outputs that can be implemented in code.

---

### Prompt

You are helping design evaluation checks for a project that uses LLM output.

---

### Context

Project summary:
<Project summary here>

Feature or output being evaluated:
<Describe the output, e.g. chatbot response, email summary, OCR result>

---

### Instructions

1. Define **3 evaluation checks** that are:

- simple
- testable in code
- useful for catching real issues
- aligned to the feature’s purpose

---

2. For each check, provide:

- Name  
- What it verifies  
- How it would be implemented (simple terms)  
- Pass/fail rule (clear and deterministic where possible)  
- Example of pass  
- Example of fail  

---

3. Prioritise checks that are:

- deterministic (preferred)
- low-judgment
- easy to run repeatedly

---

4. If a check is not fully deterministic:
- suggest a simple heuristic version suitable for scripting

---

5. Avoid:

- complex scoring systems
- vague or subjective criteria without clear rules
- anything requiring UI or manual review

---

### Output

Return a clean, structured list of 3 evaluation checks that can be directly translated into code.