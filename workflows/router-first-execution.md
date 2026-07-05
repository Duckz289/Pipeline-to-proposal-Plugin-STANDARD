---
load_when: ["always"]
layer: "required"
summary: "Router-first execution model that avoids loading every agent and policy into one context."
last_updated: "2026-07"
freshness_warning_days: 90
---

# Router-First Execution

The plugin must not load every agent, workflow, policy, and template for every request.

## Principle

The orchestrator acts as a lightweight router:

1. Classify intent.
2. Load local memory that is directly relevant.
3. Load only the minimum policy set needed for safety.
4. Select one next worker step.
5. Summarize state after the step.
6. Package output or checkpoint before another step.

This reduces latency, cost, and long scroll-heavy responses.

## Always-Load Set

Load at pipeline start:

- `agents/orchestrator-agent.md`
- `knowledge/knowledge-index.md`
- `workflows/router-first-execution.md`
- `policies/context-budget-policy.md`
- `policies/checkpoint-policy.md`
- `policies/hallucination-prevention-policy.md`

Do not exceed the always-load set unless a concrete next step requires it.

## Conditional Worker Loading

Load workers only when their step is active:

| Intent / Step | Load |
|---|---|
| research or qualification | `agents/research-agent.md` |
| outreach, LinkedIn, call opener | `agents/messaging-agent.md` |
| proposal or executive summary | `agents/proposal-agent.md` |
| next best action | `agents/deal-coach-agent.md` |
| buyer-facing artifact review | `agents/reviewer-agent.md` + `workflows/verification-checkpoint.md` |

For each worker step, load at most one worker agent and three supporting files.

## Full Pipeline Behavior

Even for "full pipeline", do not load all worker agents at once.

Run as staged execution:

1. Resolve intent and offer context.
2. Load local memory.
3. Research + qualification.
4. Draft requested buyer-facing artifact.
5. Independent review.
6. Verification checkpoint.
7. Package output, local memory block, and next command.

If the user did not explicitly ask for email/proposal after research, stop and offer the best next
command.

After every checkpoint, carry forward only unresolved risks, source labels, claim registry, next
action, and a compact summary.

## Context Manifest

Record only useful context:

- files loaded
- local memory used or missing
- optional public/CRM tools attempted
- worker step run
- local memory block produced or saved

Use `context_loaded` and `state.persistence_status` in `schemas/pipeline-context.schema.json` when
helpful, but do not show them by default.
