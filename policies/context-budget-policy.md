---
load_when: ["always"]
layer: "required"
summary: "Hard limits for context loading, worker handoff, and output length."
last_updated: "2026-07"
freshness_warning_days: 90
---

# Context Budget Policy

The default mode is compact. Load, keep, and output the smallest useful context.

## Hard Budget

- Always-load set: maximum 6 files.
- Active worker set: maximum 1 worker agent and 3 supporting files.
- Keep at most 6 source snippets in the active prompt.
- Keep source snippets to 1-3 relevant sentences each.
- Keep `context_loaded` to file names and reasons only.
- Keep checkpoint summaries under 150 words.
- Keep local memory update blocks under 220 words.

## Eviction Rule

After each worker step:

1. Produce a compact step summary.
2. Prepare a local memory update block when useful.
3. Drop detailed snippets, raw timelines, raw search results, and draft variants from the active prompt.
4. Carry forward only source labels, unresolved risks, claim registry, next action, and the compact summary.

## Output Budget

Default output is compact unless the user asks for a full artifact.

- Prospect brief: 150-300 words.
- Outreach email: follow the email skill word count.
- Proposal skeleton: 350-700 words.
- Full proposal: only generate when explicitly requested.
- Full pipeline response: include a brief plus one requested buyer-facing artifact, then one next command.

## Retrieval Rule

Before loading a long file or old context, ask:

- Is it needed for this exact artifact?
- Can the same decision be made from local memory summary?
- Can the same decision be made from the knowledge index summary?

If yes to either summary question, do not load the long source.
