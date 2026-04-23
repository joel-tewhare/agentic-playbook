## Common /build-pass prompt add-ons

These prompt points are often needed when calling /build at different stages. They are situational add-ons but this guide shows what to focus on.

### Pass 1

- Do not implement data, derived logic, or future-pass behaviour.
- Use this palette / styling direction only for UI structure.

### Pass 2

- Wire only the single-provider happy path.
- Do not connect model switching yet.

### Pass 3

- Implement provider selection only.
- Do not add polish/error UX beyond what is required for correctness.

### Pass 4

- Incorporate accepted review findings only.
- Do not introduce new features or broad refactors.

---

## Skill Update Prompt Template (Post-Retro)

Use this template to apply small, targeted improvements to your reusable skill files after a `/review-retro` + `/retro` cycle.

---

### Prompt

Update my skill files based on the following retro improvements.

**Files:**

- <path-to-skill-file-1>
- <path-to-skill-file-2>

**Changes to implement:**

1. In `<skill-file-1>`:

- Under "<section name>", add:
  "<new rule or checkpoint>"

- Under "<section name>", add:
  "<new rule or checkpoint>"

2. In `<skill-file-2>`:

- Under "<section name>", add:
  "<new rule or checkpoint>"

---

**Constraints:**

- Keep changes minimal and append-only where possible
- Do not restructure the files
- Do not modify unrelated content
- Maintain existing tone and formatting

---

**Output:**

- Apply the updates directly to the files
- Then briefly summarize:
  - what was added
  - where it was added

---

### Notes

- Use this only for **small, high-confidence improvements** (not large rewrites)
- Derived from real retro findings (not hypothetical ideas)
- Always manually review the diff after applying

## OUTPUT EVAL DESIGN PROMPT

You are helping design evaluation checks for a project that uses LLM output.

Goal:
Define 3 simple, testable evaluation checks that can be implemented in a runnable script and used to assess output quality.

Context:
<Project summary here>

Feature / Output being evaluated:
<Describe the specific feature or output, e.g. chatbot response, email summary, OCR validation result, etc.>

Instructions:

1. Define 3 evaluation checks that are:

- simple
- testable in code
- useful for catching real issues
- aligned to the feature’s purpose

2. For each check, provide:

- Name
- What it verifies
- How it would be implemented (in simple terms)
- Pass/fail rule (clear and deterministic where possible)
- Example of pass
- Example of fail

3. Prioritise checks that are:

- deterministic (preferred)
- low-judgment
- easy to run repeatedly in a script

4. If a check is not fully deterministic (e.g. “on-topic”), suggest a simple heuristic version suitable for a script.

5. Avoid:

- complex scoring systems
- vague or subjective criteria without a clear rule
- anything requiring a UI or manual review loop

Output format:

Return a clean structured list of 3 checks that can be directly translated into code.