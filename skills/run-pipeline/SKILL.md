---
name: run-pipeline
description: >
  Runs a local-first sales workflow for B2B sales. Triggered when a user asks
  to "run the pipeline", "automate sales workflow", "research and write email", "create the full
  pipeline for [company]", "tu dong hoa quy trinh sales", "lam het tu research den proposal",
  "chay pipeline cho [cong ty]", "nghien cuu roi viet email/proposal", "kiem tra co nen tiep can",
  or provides a company name and asks for a complete sales output.
  Uses local memory, user context, optional research, and compact review.
  Never sends or writes back without approval.
---

# Run Pipeline / Tu Dong Hoa Pipeline Sales

This is the main sales workflow skill. Use it when the user wants more than one isolated task or
when the request is ambiguous but clearly related to prospect research, email, proposal, or next
sales action.

This release is optimized for a normal salesperson running locally. Do not require server setup,
hosted infrastructure, durable database persistence, or external API configuration.

If the request is too vague to infer an artifact, use `skills/mode-selector/SKILL.md` first.

## Core Principle

Run as much of the workflow as possible with available data. Stop and ask only when a missing input
would make the output useless or unsafe.

Produce the best safe version:

- Full artifact: enough data to use externally after human review.
- Draft artifact: useful but needs user edits before use.
- Skeleton artifact: structure only because a critical input is missing.

## Agent Order

1. Orchestrator agent: understand the request and target output.
2. Fit check: lightly decide whether the prospect is worth deeper work.
3. Research agent: assemble company, local memory, contact, pain, and source context.
4. Messaging agent: draft outreach or follow-up when stage and offer are known.
5. Proposal agent: draft proposal only when offer, scope, and pricing assumptions are known.
6. Deal coach agent: recommend the next best action from local history/user context.
7. Reviewer agent: check risky claims and approval needs.
8. Verification checkpoint: block send-ready output when buyer-facing claims still need confirmation.
9. Checkpoint policy: stop at research/email/proposal boundaries when the user did not request the
   next artifact.

Follow `workflows/router-first-execution.md`: load `knowledge/knowledge-index.md` first, then load
only the next worker, policy, schema, or reference needed for the active step. Resolve paths from
the plugin root.

Follow `policies/context-budget-policy.md` as a hard limit. Default to compact mode.

## Inputs To Extract

From the user's request, extract:

```json
{
  "company_name": "",
  "target_contact": "",
  "sales_stage": "unknown | cold | active_conversation | post_demo | proposal_sent | stalled | lost | renewal",
  "requested_outputs": ["prospect_brief", "email", "proposal", "next_step", "crm_note"],
  "offer": "",
  "pricing": "",
  "language": "auto",
  "write_back_requested": false,
  "local_deal_slug": ""
}
```

If `company_name` is missing, ask for it before doing anything else.

## Quick Intake

Before the first run in a conversation, check whether the user's offer context is
already known from:

- the current request
- the conversation
- `local-state/product-context.md`
- `knowledge/product-context-template.md`

If it is missing, ask one short question:

```text
Mày bán gì cho khách này? Nếu có giá/package thì gửi kèm, không có tao sẽ viết bản nháp có marker.
```

Store the answer in conversation context and reuse it for the session. When useful, output a
short product memory update for `local-state/product-context.md`.

If product context is empty and the user gave a clear offer/pricing/ICP, save it automatically when
file writing is available. Ask only before replacing existing product context.

If the user says they want the plugin to remember the offer, use
`skills/setup-product-context/SKILL.md` to prepare a persistent context block.

## Clarification Rules

Ask at most one focused question at a time. Prefer continuing with a partial output over asking for
non-critical details.

Ask before continuing when any of these are missing:

- Company name.
- Product/service being sold when drafting final email or proposal.
- Pricing or budget range when drafting a final proposal.
- Approval when sending, logging, updating CRM, creating tasks, or changing deal stage.

Do not ask when the missing data can be safely handled as an assumption. State the assumption in
`missing_info` and lower confidence.

If public data is weak, do not ask a long research form. Ask early with one practical question only
if it changes the message angle:

```text
Mình chưa rõ [Company] làm ngành gì. Mình nên nhắm chủ doanh nghiệp, sales, ops hay kế toán? Nếu
chưa rõ, mình viết bản trung tính cho owner/ops.
```

## Data Source Priority

1. User-provided context in chat.
2. Local memory: `local-state/product-context.md`, `local-state/deals/`, `local-state/follow-ups.md`.
3. Internal knowledge: templates, proof points, objection handling, proposal structure.
4. CRM data only when the user's environment separately provides it.
5. External sources only when browser/search tools are available.
6. Inference from patterns, only when clearly labeled as inference.

If public search is not available or weak, continue with local/user data, lower confidence, and use
persona-based copy. Do not ask the user to configure an API.

## Missing Data

If CRM, browser/search, email, calendar, local files, or knowledge-base tools fail:

- Track the issue internally.
- Continue with the next available source.
- Lower confidence only where that source matters.
- Say the data was unavailable instead of saying the data does not exist.
- Ask for business context only if it materially improves the requested artifact.

## Workflow

Follow `workflows/end-to-end-pipeline.md`.

Minimum automated flow:

1. Resolve company and requested output.
2. Load relevant local product/deal memory when available.
3. Build a short working context.
4. Run light fit check.
5. Run data readiness check using `skills/run-pipeline/references/data-readiness-checklist.md`.
6. Apply fallback handling using `workflows/data-fallback-matrix.md`.
7. Produce only the requested artifact for the active stage.
8. Run independent reviewer checks using `policies/independent-review-policy.md`.
9. Run verification checkpoint using `workflows/verification-checkpoint.md`.
10. Return a compact plain-language output.
11. Save or suggest local memory/follow-up updates.

When shell access is available, prefer `scripts/update-local-state.ps1` for local deal, follow-up,
and feedback updates.
Never treat a generated output artifact, attachment, or temp file outside `local-state/` as a
successful memory save.

## Output Bundle

Follow `policies/output-anatomy-policy.md` for section order.

Default to compact output. Do not generate a long full proposal, long CRM history, or multiple draft
variants unless the user explicitly asks. For broad "run the pipeline" requests, return the brief
plus the highest-priority requested buyer-facing artifact, then offer one clear next command.

Do not show internal labels like `completion level`, `confidence`, `source health`, `claim
registry`, `pipeline state`, or `context loaded` in normal output. Use plain text:

- "Dùng được ngay" / "Cần sửa nhẹ" / "Thiếu dữ liệu"
- "Mình đang giả định..."
- "Trước khi gửi cần..."

When useful, include:

```markdown
### Đã lưu
- Deal: local-state/deals/[company].md
- Follow-up: local-state/follow-ups.md

### Nếu chưa lưu được
- [ ] YYYY-MM-DD - [Company] - [Action] - [Context]

### Hỏi lại sau khi gửi
Sau khi gửi, nhắn: "khách trả lời..." hoặc "không phản hồi" để mình cập nhật deal.
```

Only include `### Đã lưu` when those exact `local-state/...` files were actually updated. If not,
use only the `### Nếu chưa lưu được` fallback.

## Language Rules

- Reply in the same language as the user.
- If the prospect-facing artifact should be in another language, label it clearly.
- Vietnamese user interface text should be natural and practical, not overly formal.
- Vietnamese sales copy should sound like a normal B2B salesperson, not a corporate brochure.
- Avoid technical/productivity jargon in user-facing output unless the user asks for debugging.
- Keep names, company names, job titles, product names, and quoted source titles unchanged.

## Safety And Approval

- Never send an email automatically.
- Never update CRM, create a task, change deal stage, or write notes without explicit approval.
- Local deal memory can be updated automatically when file writing is available, unless the content
  is sensitive or overwrites existing product context.
- A temp artifact or downloadable markdown file is not the same as updating `local-state/`.
- Never invent a decision maker, quote, funding event, customer result, or price.
- Label inferred pain points as inferred.
- Include source notes for important company facts.
- Remove unsupported risky claims before returning buyer-facing copy.
- Use `schemas/claim-registry.schema.json` for risky claims.
- Do not mark output `full` until `workflows/verification-checkpoint.md` passes.

## Operating Files

Always load at pipeline start:

- `knowledge/knowledge-index.md` - use it to decide which other files to load conditionally.
- `agents/orchestrator-agent.md` - routing, local memory, output packaging.
- `policies/context-budget-policy.md` - hard limits for context, token usage, and output length.
- `policies/hallucination-prevention-policy.md` - required for all buyer-facing artifacts.
- `workflows/router-first-execution.md` - required to avoid context bloat.

Load conditionally based on knowledge-index.md and requested artifact:

- `local-state/product-context.md` - first choice for offer, pricing, proof, or ICP context.
- `local-state/deals/` matching deal file - when company/deal history may exist.
- `knowledge/product-context-template.md` - fallback product context.
- `workflows/end-to-end-pipeline.md` - only for explicitly broad pipeline runs.
- `agents/research-agent.md` - when research is needed.
- `agents/messaging-agent.md` - when email or LinkedIn message is requested.
- `agents/proposal-agent.md` - when proposal is requested.
- `agents/deal-coach-agent.md` - when next step is requested.
- `agents/reviewer-agent.md` - before returning any buyer-facing artifact.
- `workflows/verification-checkpoint.md` - before marking any artifact full.
- `workflows/data-fallback-matrix.md` - when any source is missing or fails.
- `policies/state-management-policy.md` - when a run reaches a checkpoint or needs resume support.
- `workflows/feedback-loop.md` - when the user provides win/loss, reply, objection, or edit feedback.
- `policies/output-anatomy-policy.md` - for section order of final output bundle.
- `schemas/claim-registry.schema.json` - when reviewer builds claim registry.
- `schemas/pipeline-state.schema.json` - when state is saved as a local memory block.
- `schemas/feedback-event.schema.json` - when feedback is captured.
- `skills/mode-selector/SKILL.md` - when request is vague at conversation start.
- `skills/setup-product-context/SKILL.md` - when user wants persistent offer memory.
- `skills/update-deal-feedback/SKILL.md` - when user reports reply/no reply/won/lost/meeting.
- `skills/run-pipeline/references/data-readiness-checklist.md` - for data readiness check.
- `scripts/update-local-state.ps1` - when local memory should be written.
