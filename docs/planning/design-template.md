# design.md

## Overview

Brief description of the product or feature.

- What it is
- Who it’s for
- What core experience it should deliver

---

## Design Principles

Core ideas that guide all design decisions.

- <Principle 1>
- <Principle 2>
- <Principle 3>

Examples:
- Clarity over complexity
- User remains in control
- Prioritise readability over density

---

## Style Tokens

Concrete visual values used consistently across the UI.

### Colours

- Primary: <hex>
- Background: <hex>
- Text: <hex>
- Muted: <hex>
- Accent (optional): <hex>

---

### Spacing

- Base unit: <e.g. 4px>
- Small: <value>
- Medium: <value>
- Large: <value>

---

### Typography

- Font family: <name>
- Primary text: <size / weight>
- Secondary text: <size / weight>
- Heading scale: <rules>

---

### Radius

- Small: <value>
- Medium: <value>
- Large: <value>

---

### Shadows (optional)

- Light: <description>
- Medium: <description>
- Heavy: <description>

---

## Components

Define how key UI elements should look and behave.

### <Component Name>

- Purpose: <what it represents>
- Structure: <what it contains>
- Behaviour: <how it behaves>
- Visual rules: <styling constraints>

Repeat for:
- Cards
- Buttons
- Inputs
- Lists
- Navigation

---

## Layout Rules

How content is arranged on screen.

- Page structure (e.g. vertical stacking, grid, cards)
- Density (spacious vs compact)
- Alignment rules
- Section hierarchy

Examples:
- Use vertical stacking for readability
- Avoid dense table layouts for primary workflows
- Keep primary content above secondary metadata

---

## Interaction Patterns

How users interact with the system.

- Default interaction flow
- Edit vs confirm behaviour
- State transitions (loading, success, error)
- Action grouping

Examples:
- All generated outputs must be editable before confirmation
- Group actions by intent (primary vs secondary)
- Do not imply actions have executed before confirmation

---

## Content & Tone

How text should be written.

- Tone (e.g. neutral, friendly, formal)
- Sentence style (short, scannable, etc.)
- What to prioritise (actions, dates, outcomes)

Examples:
- Clear and concise language
- Avoid overly formal phrasing
- Prioritise action items and key information

---

## Accessibility & Constraints

Rules the UI must respect.

- Contrast requirements
- Interaction clarity
- Non-reliance on colour alone
- Keyboard / screen reader considerations

Examples:
- Ensure sufficient contrast for all text
- Avoid using colour as the only indicator of meaning
- Ensure all actions are clearly labelled

---

## Behavioural Constraints

High-level product behaviour rules that affect UX.

- <Constraint 1>
- <Constraint 2>

Examples:
- No actions execute without explicit user approval
- Always show system state clearly (loading, error, success)

---

## Notes (Optional)

- Assumptions
- Open questions
- Future considerations