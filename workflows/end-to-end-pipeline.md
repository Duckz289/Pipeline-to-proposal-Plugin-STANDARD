---
load_when: ["run_pipeline", "full_automation"]
layer: "conditional"
summary: "Authoritative local-first sequence for the Pipeline-to-Proposal workflow."
last_updated: "2026-07"
freshness_warning_days: 90
---

# End-to-End Pipeline Workflow

This is the authoritative sequence for `run-pipeline` and broad automation requests.

## Pre-Flight

Before starting:

1. Load `knowledge/knowledge-index.md`.
2. Extract inputs from the user's request.
3. Load `local-state/product-context.md` if offer context is needed.
4. Load a matching `local-state/deals/[company-slug].md` summary if it exists.
5. Decide whether to ask one quick question before drafting.

## Step 1: Intent Resolution

Resolve:

- `company_name` - required. Ask if missing before doing anything else.
- `requested_outputs` - brief, email, proposal, next step, CRM note.
- `sales_stage` - infer from context if not stated.
- `language` - auto-detect from user's message.
- `write_back_requested` - default false.

If the request is too vague to infer any output, route to `skills/mode-selector/SKILL.md` first.

## Step 2: Quick Intake

Check whether the user's real offer is available from the request, conversation, or local product
context.

If offer is missing and the requested output needs it, ask one short question. Do not ask a long
setup form.

If offer is known, skip this step. If local product context is empty and the user gave enough offer
detail, save a starter product context when possible.

## Step 3: Build Pipeline Context

Build a short working context:

- `company.name` from Step 1.
- `requested_outputs` from Step 1.
- `confidence: "low"` until research/context improves.
- `source_health: []`.
- `not_found: []`.
- `claim_registry: []`.

## Step 4: Fit Check

Score the prospect against the ICP from local product context or the user's answers.

- Strong or Possible: continue normally.
- Weak: run light research only, then ask before long artifacts.
- Unknown: continue if user explicitly named the company; keep confidence modest.

## Step 5: Research

Route to `agents/research-agent.md`.

If public data is weak and the user has not provided industry/persona/context, ask the sparse-data
question before a long output.

Research outputs:

- Company snapshot.
- Local/CRM status and relationship history when available.
- Pain signals with source and confidence.
- Decision makers or target personas.
- Recommended angle.
- Source health for attempted sources.
- `not_found` list for important missing items.

Keep only the useful summary for the next step.

## Step 6: Messaging (if requested)

Route to `agents/messaging-agent.md`.

Prerequisites:

- Prospect brief or enough user context.
- Offer from local product context or user message.
- Recipient name or persona.
- Sales stage.

If offer is missing, ask one short question. Do not invent offer or pricing.

## Step 7: Proposal (if requested)

Route to `agents/proposal-agent.md`.

Prerequisites:

- Company and stakeholder/persona.
- Offer and scope.
- Pricing or budget range for final draft.

If pricing is missing, create a proposal skeleton with `[[EDIT: confirm pricing]]` markers.

## Step 8: Next Step (if requested)

Route to `agents/deal-coach-agent.md`.

Use local deal memory first. If no local timeline exists, extract timing from the user's message or
ask one question only when timing matters.

## Step 9: CRM Note Draft (if requested)

Draft a CRM note and follow-up task for copy-paste. Do not claim CRM was updated.

## Step 10: Review

Route to `agents/reviewer-agent.md`.

Reviewer checks:

- Critical data present for requested artifacts.
- No invented facts in buyer-facing content.
- Risky claims classified in `claim_registry`.
- Unsupported buyer-facing claims removed or output downgraded.

## Step 11: Verification Checkpoint

Run `workflows/verification-checkpoint.md`.

Determines `completion_level`: full / draft / skeleton.

This step is mandatory for every buyer-facing artifact.

## Step 12: Output

Return compact plain-language output following `policies/output-anatomy-policy.md`.

Include one best next command.

After output, update local memory when possible:

- create/update `local-state/deals/[company-slug].md`
- append `local-state/follow-ups.md` when there is a next action
- append a pending feedback line to `local-state/feedback.md` after buyer-facing drafts

If file writing is unavailable, show only a short fallback:

```markdown
### Để lưu lại
- [ ] YYYY-MM-DD - [Company] - [Action] - [Context]
```

## Fallback Rules at Any Step

If a required source is missing or a tool fails:

1. Track the issue internally.
2. Continue to the next available source.
3. Use cautious wording only where the missing data matters.
4. Produce the best available artifact tier.

See `workflows/data-fallback-matrix.md` for source-specific fallback rules.

## Minimum Output Guarantee

| Data available | Minimum artifact level |
|---|---|
| Local/user + public/CRM + offer + pricing | Usable draft |
| Partial data + offer | Short draft |
| Company name + offer only | Short draft or skeleton |
| Company name only | Ask for offer before drafting |
