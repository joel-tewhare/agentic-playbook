## Checks pattern

Use two check levels:

- `checks-fast.sh` for quick local confidence during implementation

- `checks-full.sh` before review, merge, or release

Guideline:

- Fast checks should stay short and high-signal

- Full checks should include all deterministic checks available

- Manual reminders are allowed only for fragile integration points that are important but not easily scriptable