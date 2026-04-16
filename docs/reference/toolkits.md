## Toolkits

Short notes on higher-level libraries/SDKs and what problems they solve.

### Vercel AI SDK

- Purpose: Simplifies working with AI models (streaming, message formatting, multi-provider support)
- Replaces: manual API calls + streaming logic
- Mental model: App → SDK → Model

### useChat

- Purpose: Manages chat state + API communication + streaming in React
- Replaces: manual state + fetch + streaming logic
- Mental model: UI talks to useChat, not directly to the API
