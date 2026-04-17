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
