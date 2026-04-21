---
name: security-fix
description: Implements minimal, targeted security fixes from a completed audit—reducing blast radius, tightening trust boundaries, and improving enforcement without broad refactors. Use after /security-audit when the project is stabilised, top risks are known, and the user wants concrete fixes (not another audit).
---

# Security fix (`/security-fix`)

## Purpose

Apply **minimal, targeted** fixes based on a completed security audit.

**In scope**

- Highest-value security improvements
- Reducing blast radius
- Tightening trust boundaries
- Improving rule enforcement
- Preserving the existing architecture

**Out of scope**

- Broad refactors or opportunistic cleanup
- Redesigning the whole app
- Mixing security fixes with unrelated polish

## When to use

Use this **after**:

- `/security-audit` has been completed
- The project is already stabilised
- Top risks are understood
- The user wants **concrete fixes**, not another audit

This skill can be used in either:

- **Pre-wiring / mock-first stage**
  - focus on architecture, trust boundaries, future action paths, and safe swap boundaries
  - do not force real integration concerns if the repo is intentionally still mocked

- **Post-wiring / real integration stage**
  - focus on real auth, validation, route protection, environment handling, permissions, and execution safety

If unclear, infer the stage from the repo and state the assumption before making changes.

## Fix strategy

1. Reduce capability before adding prompt guidance
2. Prefer backend enforcement over frontend trust
3. Prefer constrained execution over freeform execution
4. Prefer allowlists over broad access
5. Prefer minimal changes with clear impact

## Execution rules

1. Select only the **top 1–2** highest-value findings unless the user explicitly asks for more
2. Implement the **smallest effective** fix
3. Do **not** refactor unrelated code
4. Preserve the current architecture unless the finding cannot be fixed safely otherwise
5. If a fix changes behavior, keep the change **narrow** and explain it
6. Add validation/checks in the **most authoritative layer** available
7. If environment or agent security is the issue, **update config files** rather than only changing prompts
8. If the repo is pre-wiring, prefer fixes that improve future safety without prematurely introducing real integration complexity

## Fix priorities (order)

1. Open access to paid or privileged routes
2. Client-controlled trusted roles/state
3. Missing backend/schema validation
4. Missing approval/ownership/scope checks
5. Excessive tool/MCP/network/filesystem access
6. Prompt-layer improvements **only after** stronger controls are addressed

## What to inspect before editing

- The completed security audit (findings and severity)
- Affected routes, services, schemas, and config files
- Whether a **project or agent config file** is the right fix location
- Classify the issue:
  - app-code
  - agent-permissions
  - sandbox/environment
  - prompt-only

## Workflow

### Before changes

Briefly state:

- Which finding(s) you are fixing
- Why these were chosen (value vs effort, severity)
- Which files are likely to change
- Whether this is being treated as **pre-wiring** or **post-wiring**

Then implement.

### After changes

Use this **exact** structure:

```markdown
### Implemented fixes
- Fix 1
- Fix 2

### Files changed
- path/to/file
- path/to/file

### Why these changes reduce risk
- short explanation per fix

### Follow-up still worth doing
- only if truly important
- max 3 items
```

If a full fix is not appropriate or cannot be completed safely, use:

```markdown
### Implemented fixes
- Partial improvement only: [brief explanation]

### Files changed
- path/to/file

### Why these changes reduce risk
- short explanation

### Follow-up still worth doing
- [next safest step]
```

## Guardrails

- Do not mix unrelated cleanup into this pass
- Do not rename or restructure broadly unless required
- Do not add abstractions “for future flexibility”
- Do not silently weaken developer workflow without noting it
- After changing **API route auth** or **authenticated chat clients**, run a **production build** and confirm request auth attaches via the library’s **current** per-request options (not deprecated hook-level fields).
- If a fix cannot be implemented safely, explain why and stop at a **minimal partial** improvement if any
- If no meaningful security improvement can be made without broad redesign, say so clearly rather than forcing low-value changes

## Example valid fixes

- Strip client-supplied `system` messages server-side
- Add route auth for privileged or paid endpoints
- Add schema validation (e.g. zod) for request bodies
- Cap message length or payload size
- Restrict allowed tool names
- Add explicit approval/status checks before execution
- Narrow MCP, sandbox, or network access in config
- Reduce filesystem/network permissions

## Example invalid scope creep

- Refactoring the whole chat architecture
- Converting the app to a different framework
- Rewriting unrelated UI while touching a route

## Related

- For audit methodology and findings structure, use the **security-audit** skill when the user invokes `/security-audit`.


