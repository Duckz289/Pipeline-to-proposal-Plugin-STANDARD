---
load_when: ["always"]
layer: "required"
summary: "Index of plugin knowledge and reference files with conditional loading guidance."
last_updated: "2026-07"
freshness_warning_days: 90
---

# Knowledge Index

Use this file before loading detailed knowledge. Load only the files needed for the requested
artifact, language, and sales stage.

Default to the shortest useful representation. Prefer local memory summaries over long reference
files.

| File | Load when | Priority | Last updated |
|---|---|---|---|
| `local-state/product-context.md` | offer/pricing/ICP needed | required | user-maintained |
| `local-state/deals/[company].md` | matching company/deal may exist | conditional | user-maintained |
| `local-state/follow-ups.md` | follow-up or next-step planning | conditional | user-maintained |
| `local-state/feedback.md` | feedback, win/loss, objection, user edit | conditional | user-maintained |
| `knowledge/product-context-template.md` quick summary | local product context empty | fallback | user-maintained |
| `knowledge/vietnamese-sales-language.md` | language=vietnamese OR Vietnamese copy | conditional | 2026-07 |
| `knowledge/automation-operating-model.md` | automation mode, approval, local CRM note | conditional | 2026-07 |
| `skills/research-prospect/references/icp-profiles.md` | qualification OR research OR scoring | conditional | 2026-07 |
| `skills/research-prospect/references/pain-signal-patterns.md` | research OR recommended angle OR email personalization | conditional | 2026-07 |
| `skills/research-prospect/references/vietnam-business-sources.md` | Vietnamese SME OR MST/tax code OR sparse public data | conditional | 2026-07 |
| `skills/draft-outreach-email/references/email-templates.md` | artifact=email OR LinkedIn OR call opener | conditional | 2026-07 |
| `skills/draft-outreach-email/references/objection-responses.md` | objection handling OR re-engagement OR reply drafting | conditional | 2026-07 |
| `skills/draft-proposal/references/proposal-sections.md` | artifact=proposal OR executive summary | conditional | 2026-07 |
| `skills/draft-proposal/references/roi-calculator.md` | artifact=proposal AND ROI/investment requested | conditional | 2026-07 |
| `skills/suggest-next-step/references/follow-up-timing.md` | artifact=next_step OR follow-up timing | conditional | 2026-07 |
| `policies/hallucination-prevention-policy.md` | buyer-facing artifact OR research | required | 2026-07 |
| `policies/context-budget-policy.md` | always | required | 2026-07 |
| `policies/independent-review-policy.md` | buyer-facing artifact review | required | 2026-07 |
| `policies/state-management-policy.md` | resume OR checkpoint OR local memory | conditional | 2026-07 |
| `policies/research-data-policy.md` | research OR public data missing | conditional | 2026-07 |
| `workflows/verification-checkpoint.md` | buyer-facing artifact | required | 2026-07 |
| `workflows/router-first-execution.md` | always | required | 2026-07 |
| `workflows/feedback-loop.md` | feedback OR win/loss OR template update | conditional | 2026-07 |

## Context Manifest Requirement

Include a concise `Context Loaded` section only when it helps the user understand confidence:

```markdown
### Context Loaded
- local-state/product-context.md (offer/pricing)
- local-state/deals/acme.md (deal history)
- public search: unavailable
```

Do not dump full file contents.

## Token Guardrails

- Prefer one template/reference file per artifact.
- Do not load both `email-templates.md` and `objection-responses.md` unless handling an objection.
- Do not load both `proposal-sections.md` and `roi-calculator.md` unless ROI is explicitly requested.
- Keep the active prompt focused on one output.
