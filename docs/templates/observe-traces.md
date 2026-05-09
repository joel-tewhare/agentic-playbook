# OBSERVE TRACES TEMPLATE

# Feature

* Feature name:
* Trace capture date:
* Observability phase:

  * observe-wire
  * observe-connect
  * observe-review
  * observe-fix
  * observe-retro

---

# Trace Entry

Create one section per manually reviewed trace.

---

## Trace category

Examples:

* normal prompt
* tool prompt
* blocked / guard prompt
* error / failure prompt
* retry path
* long generation
* streaming response

## Prompt purpose

Describe intent only.
Do not paste sensitive prompts unless explicitly required.

Examples:

* greeting request
* math tool invocation
* blocked localhost fetch attempt
* readFile guard validation

---

## Trace observations

List only important observations from the trace UI.

Examples:

* `chat.post.streamText` span visible
* nested `ai.streamText.doStream` span observed
* `calculate` tool span appeared correctly
* trace completed successfully
* retry span observed
* blocked tool request still completed parent trace
* duplicate spans observed
* no tool span emitted

---

## Runtime metrics

Capture only meaningful operational metrics visible in the trace.

### Timing

* latency:
* time to first token:
* completion duration:

### Usage

* input tokens:
* output tokens:
* total tokens:

### Cost

* estimated cost:

### Model

* provider:
* model:
* finish reason:

---

## Privacy observations

Record only what was confirmed manually from the trace UI.

* raw prompt visible: yes/no
* raw assistant output visible: yes/no
* tool inputs visible: yes/no
* tool outputs visible: yes/no
* secrets visible: yes/no

### Notes

Examples:

* Input correctly appears as undefined/null
* Outputs suppressed correctly
* Tool payloads visible unexpectedly
* Metadata appears privacy-safe

---

## Operational metadata summary

Extract only useful operational metadata from the metadata JSON.

* feature:
* route:
* selectedModel:
* toolCount:
* functionId:
* operationId:
* provider:
* model:
* input tokens:
* output tokens:
* total tokens:
* latency:
* TTFT:

---

## Raw metadata

Paste the metadata JSON shared during trace review.

```json id="7z6azw"
{}
```

---

## Guard / failure observations

Only complete if applicable.

### Guard behaviour

* request blocked safely: yes/no
* denial visible in trace: yes/no
* trace still completed: yes/no

### Error behaviour

* provider error visible: yes/no
* retry behaviour visible: yes/no
* crash observed: yes/no

### Notes

Examples:

* localhost fetch correctly blocked
* readFile denial avoided path leakage
* failure path lacked useful metadata

---

# Trace Review Notes

Only record lightweight operational notes here.
Do not make fix decisions yet.

Examples:

* tool span visibility working correctly
* TTFT visibility useful
* duplicate provider spans may need future review
* metadata naming appears stable
* privacy posture preserved

---

# Review readiness

This trace file should now contain enough structured operational evidence for a later:

* observe-review
* observe-validation
* observe-implementation
* observe-retro

pass without needing screenshots committed into the repository.
