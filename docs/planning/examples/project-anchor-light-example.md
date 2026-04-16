# PROJECT ANCHOR DOC (LIGHT) - EXAMPLE

## Product

AI dashboard to review and approve email actions before execution.

## User outcome

User reviews and controls inbox actions instead of manually handling everything.

## Users

Single inbox owner.

## Core flows

- Load inbox
- Generate proposals
- Review/edit proposals
- Approve + execute

## v1 scope

IN:

- Proposal system
- Review UI
- Execution flow

OUT:

- Teams
- Automation
- External integrations

## Rules

- No auto execution
- Editable proposals
- Skip uncertain emails

## Boundaries

Frontend:

- Review UI

Backend:

- AI + execution

Never on client:

- AI calls
- Gmail actions

Source of truth:

- Backend proposals

## Domain concepts

- Email
- Proposal
- Action

## Constraints

- Structured outputs
- Human-in-loop

## Known unknowns

- Categories
- Action expansion

## /preplan goal

Break into buildable feature chunks.
