---
name: evals-create
description: Creates or updates a project-level evals.mjs file for testing model/tool behaviour. Use when a project has no evals, eval coverage needs adapting to a feature, or the user asks to set up AI behaviour validation.
---

# Evals Create (`/evals-create`)

You are setting up lightweight AI behaviour evaluation.

## Goal

Create or update an `evals.mjs` file that validates important model/tool behaviour before external review, handoff, merge, or release.

This skill defines eval coverage. It does not run evals unless explicitly asked.

## Scope rules

- Inspect the project before editing.
- Prefer existing project conventions over inventing a new framework.
- Do not install dependencies.
- Do not modify app behaviour.
- Do not add network-dependent evals unless the project already uses provider-backed evals.
- Prefer mock/local eval mode when available.
- Keep evals small, readable, and high-signal.
- If evals are not useful for the current feature, say so instead of creating unnecessary files.

## Existing file behaviour (high priority)

If an `evals.mjs` file already exists:

- Treat the existing file as the source of truth.
- Do NOT replace the file with a new template.
- Preserve:
  - existing test cases
  - existing helper functions
  - existing output format
  - existing mock/provider modes
  - existing pass/fail aggregation
- Only make minimal, justified improvements, such as:
  - adding feature-specific cases
  - tightening weak checks
  - adding missing aggregate failure handling
  - improving labels or output clarity

Do NOT:

- delete existing eval cases
- remove mock mode
- remove provider-backed mode
- simplify the file to a base template
- rewrite the whole file unless explicitly asked

If unsure, leave the file unchanged and summarise suggested eval additions instead of applying them.

## Inputs to inspect

- `package.json`
- existing `evals.mjs`
- existing eval scripts in `package.json`
- relevant API routes or tool definitions
- feature/preplan/plan docs if available
- README or course deliverable notes, if relevant

## When evals are useful

Create or update evals when the feature depends on model/tool behaviour, such as:

- tool routing
- tool result interpretation
- JSON-only response contracts
- summarisation or classification
- safety/refusal behaviour
- concise answer constraints
- file reading / URL fetching / external data use
- multi-provider comparison

Do not create evals for simple layout-only or styling-only changes unless there is a meaningful behaviour contract to test.

## Default output

Create or update:

- `evals.mjs`

Optionally update:

- `package.json` scripts only if an eval script is clearly missing and the user asked for executable evals.

Preferred script names:

- `eval:run`
- `eval:mock` if the project supports mock-only mode

Do not add package scripts if the project has an existing convention. Follow the project convention instead.

## Eval design principles

Each eval case should define:

- id
- prompt/input
- expected behaviour
- checks to run
- clear pass/fail output

Prefer checks that are:

- deterministic where possible
- easy to scan in terminal output
- specific enough to catch regressions
- not overly brittle to harmless wording differences

## Common checks

Use only checks that fit the feature.

Examples:

- onTopic
- validJson
- requiredFields
- concise
- usedTool
- didNotUseTool
- errorHandled
- blockedPath
- contentGroundedInFile
- noRawSystemLeak
- noMarkdownFenceWhenJsonOnly

## Failure handling

Eval scripts should:

- print readable results per case
- track aggregate failure state
- exit with non-zero status when any required check fails
- clearly distinguish optional observations from required failures

Do not only print failed booleans while exiting successfully.

## Mock vs provider mode

Prefer mock/local mode when testing script structure or deterministic helper logic.

A mock-first **application** may still use an internal backend with seeded data; eval policy here is unchanged—keep evals deterministic and avoid network/provider calls unless the user intentionally runs provider-backed mode.

Provider-backed mode may be used when testing model behaviour, but:

- make required env vars explicit
- fail clearly if required keys are missing
- avoid hiding missing-key errors as passing evals
- do not call external providers unless the user intentionally runs that mode

If both modes exist, preserve both.

## Tool eval guidance

For tool-based features:

- Test successful tool use.
- Test failure handling.
- Test when the tool should not be used.
- Test important boundary cases.
- Keep mock tool outputs shaped like real tool outputs.
- Avoid duplicating app logic unless necessary for the tutorial/project. If duplication exists, note that the contract must stay in sync.

## Feature-specific examples

For a readFile-style tool, useful evals may include:

- valid file path → grounded answer using file content
- missing file → clear not-found explanation
- blocked path → access denied explanation
- empty file → treated as successful but empty
- unrelated question → tool not required

For a calculator-style tool, useful evals may include:

- natural-language math → correct numeric result
- invalid expression → clear error
- non-math question → tool not used or refusal, depending on product intent

## Output behaviour

When complete:

1. Create or update eval files/scripts.
2. Summarise:
   - files created or changed
   - eval cases added or preserved
   - checks included
   - mock/provider modes
   - any useful evals not added and why
3. If the repo keeps feature-scoped check/eval logs under `docs/checks/*` or `docs/evals/*` (project convention), note in the summary whether those paths should be updated in the **same change batch** as new eval cases; do **not** create those documentation files unless the user asked.
4. Do not run evals unless explicitly asked.

## Verification

Before finishing, ensure:

- existing evals were preserved unless explicitly changed
- required checks can fail the process
- output is readable in terminal
- package scripts match the project convention
- network/provider requirements are explicit
- no secrets are hardcoded
- eval cases are relevant to the feature

## Style

- Keep changes minimal.
- Prefer clarity over cleverness.
- Avoid overfitting to one model’s exact wording.
- Preserve existing project conventions.
- Do not over-engineer.
