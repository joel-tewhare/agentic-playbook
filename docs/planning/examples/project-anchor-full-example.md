# PROJECT ANCHOR DOC - Example

## 1. Project summary

AI-assisted email operations dashboard for reviewing and approving suggested actions before execution.

## 2. Core user outcome

User can review inbox emails, see proposed actions, and approve or edit them before execution.

## 3. Primary users

Single user managing their inbox.

## 4. Core flows

- Load inbox
- Generate proposals
- Review proposals
- Edit proposals
- Approve actions
- Execute actions
- Apply labels/archive

## 5. Scope for v1

IN:

- Inbox reading
- Proposal generation
- Review dashboard
- Approval flow
- Execution of actions

OUT:

- Multi-user support
- Cross-app integrations
- Full automation

## 6. Product rules

- No action without approval
- AI outputs must be structured
- Uncertain emails are skipped

## 7. System boundaries

Frontend:

- Display and edit proposals

Backend:

- Fetch emails
- Generate proposals
- Execute actions

Never on client:

- AI calls
- Gmail execution

Source of truth:

- Backend proposal objects

## 8. Data / domain concepts

- Email
- Proposal
- Category
- SuggestedAction
- ExecutionDecision

## 9. Input / output expectations

Inputs:

- Emails
- User decisions

Outputs:

- Proposals
- Executed actions
- Labels/archive updates

## 10. Constraints

- Structured schemas only
- Backend orchestration
- Safe execution model

## 11. Risks / ambiguity

- Category definitions may evolve
- Action types may expand

## 12. /preplan goal

Break into feature-level chunks without implementation detail.
