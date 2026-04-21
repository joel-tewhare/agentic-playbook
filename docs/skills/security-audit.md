---
name: security-audit
description: Runs a code-grounded security and trust-boundary audit on a stabilised project—untrusted inputs, model-to-action paths, backend enforcement, blast radius, prompt-injection exposure, client/server trust boundaries, and secrets. Use when the user invokes /security-audit, asks for a security audit after a feature is built, wants trust-boundary review, or asks to assess prompt injection and excessive agency against the actual repo.
---

# Security audit (stabilised projects)

## When to use

- After the app/feature is built, main review is settled, and manual testing has stabilised the codebase.
- When the user wants a **practical, severity-ranked** audit grounded in **actual files**, not generic theory.
- Do not run too early unless explicitly requested; early audits should be labeled as **architectural / pre-wiring**.

## When not to use

- Broad security theory without repo inspection.
- Rewriting architecture or padding with generic best practices.
- Inventing tools, routes, or flows not present in the repository.

## Audit stance

Assume:

- Untrusted text may contain malicious instructions.
- The model may follow those instructions.
- Prompts alone are not a reliable defense.
- Safety depends on **limiting what can happen** if the model is manipulated.

Three layers (weakest → strongest):

1. **Prompt layer** — weakest  
2. **Harness / app enforcement** — strong  
3. **Sandbox / environment boundary** — strongest  

### Context awareness

Adjust expectations based on project stage:

- **Pre-wiring (mock-first)**:
  - Focus on architecture, trust boundaries, and future action paths
  - Do not expect real credentials, real APIs, or full auth flows

- **Post-wiring (real integration)**:
  - Focus on real secrets, environment handling, auth, rate limits, and execution safety

If unclear, infer from the repo and state the assumption in the **Summary**.

## Process

1. **Inspect real project files** (routes, API handlers, agents, tools, middleware, config, env usage, DB access, jobs, webhooks).
2. **Grep/search** for tool definitions, MCP, shell/exec, file/network calls, auth middleware, validation libraries.
3. **Trace** each untrusted surface to what consumes it (model context, DB, email, shell, etc.).
4. **Prefer fewer strong findings** over many weak ones. If a major risk class is absent (e.g. no tools), say so clearly.
5. **Do not** claim tools or flows exist without evidence in the repo.
6. If no tool-calling, execution, or side-effecting actions exist:
   - explicitly state that prompt injection risk is limited mainly to response behavior and cost
   - do not overstate risk

## What to inspect

Cover these areas as applicable to the codebase:

| Area | Look for |
|------|-----------|
| Untrusted input | User messages, uploads, emails, docs, API responses, DB rows, issues/markdown, web fetches, stored prompts, conversation history |
| Model-to-action | Tool calls, route execution, email, DB writes, outbound APIs, file writes, shell, workflows, webhooks, approvals |
| Backend rules | Schema validation, allowlists, auth/role/ownership, status checks, scopes, constrained action types, id-based vs freeform execution, approvals, audit logs |
| Client vs server trust | Whether the server trusts client-supplied state (e.g. roles, system messages, IDs, permissions). **Public / client-bundled config** (e.g. framework “public env” patterns) is **obfuscation only**, not a strong secret—score findings as a **dev gate** vs **real production auth** accordingly. |
| Blast radius | Open-ended execution, broad writes, shell/filesystem/network, MCP breadth, tools wider than the feature needs, draft vs execute confusion, unauthenticated routes that proxy paid APIs |
| Prompt injection | Where untrusted text enters model context; impact (response-only vs actions/cost/data) |
| Secrets / env | Env vars, keys, credentials, local files, SSH/cloud creds, filesystem/network breadth; distinguish app code vs agent environment vs sandbox assumptions |

## Output format (use exactly)

### Summary

- 3–6 sentences: overall assessment.
- State whether the system is **tool-using / action-taking** or **not** (based on the repo).
- State whether this is assessed as **pre-wiring** or **post-wiring** if relevant.
- Lead with **highest-value risks**.

### Findings

For **each** finding:

- **Severity:** High / Medium / Low  
- **Title**  
- **Why it matters**  
- **Exact files / functions / routes** involved  
- **Evidence from code** (short citations or line-referenced descriptions)  
- **Recommended fix** (minimal, practical, grounded in this codebase)

### Prioritised fixes

- Top 1  
- Top 2  
- Top 3  
- Top 4  
- Top 5  

### Noise filter

End with:

- **Findings I consider likely real**  
- **Findings that are more precautionary / lower confidence**  

## Quality bar

- Concrete and code-grounded; cite paths and symbols.
- No invented architecture or phantom tools.
- Minimal fixes over full rewrites.
- If something is out of scope or absent, state it plainly.


