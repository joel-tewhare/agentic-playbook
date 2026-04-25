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

# External Review Findings Validation Prompt

Review the external AI findings against the actual codebase.

Goal:
Validate whether each finding is accurate, relevant, and worth acting on in this repo.

Context:
- This review follows an external AI review.
- Treat the external review as a signal, not truth.
- Ground every judgement in the actual project files.
- Prefer the smallest practical fix.
- Do not implement changes yet unless explicitly asked.

Instructions:
For each finding:
1. Confirm whether it is accurate in this codebase.
2. Explain the real impact in this implementation.
3. Classify it as:
   - Accept
   - Partially accept
   - Reject
   - Defer
4. Suggest the smallest practical change if accepted or partially accepted.
5. Note if the finding is theoretical, out-of-scope, duplicated, or already handled.

Project context:
[Paste brief project/module context here]

Review scope:
[Paste files, feature, branch, or implementation area here]

External review findings:
```text

[Paste findings here]

```

Output format:

## Findings Validation

### Finding 1: [short title]
Status: Accept / Partially accept / Reject / Defer

Accuracy:
[Is it true in this repo? Reference files/functions.]

Impact:
[What could actually happen here? Keep it grounded.]

Smallest practical change:
[Minimal fix, or "No change recommended".]

Notes:
[Any scope/context/security/workflow notes.]

---

### Finding 2: [short title]
Status: Accept / Partially accept / Reject / Defer

Accuracy:
[Is it true in this repo? Reference files/functions.]

Impact:
[What could actually happen here? Keep it grounded.]

Smallest practical change:
[Minimal fix, or "No change recommended".]

Notes:
[Any scope/context/security/workflow notes.]

---

## Recommended Action Plan

### Fix now
- [Only items worth implementing immediately]

### Defer
- [Valid findings that should wait]

### No action
- [Rejected or intentionally accepted risks]

## Review-Retro Notes

Summarise what should be carried into `/review-retro`:
- Accepted findings
- Deferred findings
- Rejected findings
- Any reusable workflow lessons

# Implement Selected Findings Prompt Template

Goal:
Implement a small set of validated review findings with minimal, targeted changes.

Scope:
- Only modify the relevant files for this change.
- Do not expand scope beyond what is listed.
- Do not refactor unrelated code.
- Do not introduce new behaviour unless explicitly required.

Context:
- Changes are based on validated findings from external review + repo-aware validation.
- Prefer smallest practical implementation.
- Preserve existing behaviour unless the finding requires a change.

Changes to implement:
- [Finding / change 1]
  - [Concrete action]
- [Finding / change 2]
  - [Concrete action]
- [Finding / change 3]
  - [Concrete action]

Implementation rules:
- Keep changes minimal and localised.
- Do not duplicate logic unless intentional.
- Do not remove existing functionality.
- Maintain current patterns and style of the codebase.

Constraints:
- Keep existing:
  - prompts
  - tool behaviour
  - APIs
  - wiring
- Only touch what is necessary to satisfy the listed changes.

Output:
- Apply the changes directly in the code.
- Do not explain unless necessary.
- Do not re-review or suggest additional improvements outside scope.

Optional notes:
- Add lightweight comments if needed to document intentional tradeoffs or maintenance considerations.