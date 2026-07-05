---
load_when: ["state", "resume", "checkpoint", "write_back"]
layer: "conditional"
summary: "How pipeline state should be kept locally and safely degraded."
last_updated: "2026-07"
freshness_warning_days: 90
---

# State Management Policy

Chat context is temporary. This free local-first plugin uses markdown memory instead of hosted
infrastructure.

## State Contract

Keep enough local notes so the next request for the same company can continue naturally.

At each useful checkpoint, record:

- run/deal label
- company/deal ID if known
- current step
- requested outputs
- compact context summary
- missing info
- source health
- claim registry
- artifact references
- next action and due date

## Local Files

Preferred local targets:

- `local-state/deals/index.md` for quick lookup across all deals.
- `local-state/deals/[company-slug].md` for deal history and latest drafts.
- `local-state/follow-ups.md` for dated next actions.
- `local-state/product-context.md` for the user's offer and pricing.
- `local-state/feedback.md` for replies, wins, losses, objections, and edits.
- direct file editing when the host allows file writes.
- `scripts/update-local-state.ps1` when shell access is available.

Default behavior:

- First choice: edit markdown files directly when the host supports file writes.
- Second choice: use `scripts/update-local-state.ps1` when shell access is available.
- Last fallback: return a compact "Để lưu lại" block.
- Do not treat missing PowerShell as failure if direct file editing is available.
- Ask before overwriting existing product context.
- Ask before storing sensitive data, private raw emails, or anything the user marks confidential.

## Resume Behavior

When resuming:

1. Load the matching local deal file if it exists.
2. Load only the latest relevant summary, not every prior draft.
3. Revalidate stale assumptions.
4. Continue from the current stage, not from the beginning.
5. Re-run reviewer and verification checkpoint for buyer-facing artifacts.

## Context Compaction

Keep local memory concise:

- Deal snapshot under 10 bullets.
- History as dated bullets.
- Latest drafts as links/summaries when possible.
- Open questions as short bullets.

Do not paste long raw source dumps into deal files.

## Deal File Update Rules

Create or update `local-state/deals/[company-slug].md` after:

- first research for a company
- email/follow-up draft
- proposal draft
- next-step recommendation
- user reports a reply, no reply, win, loss, objection, or meeting booked

Use this compact format:

```markdown
# [Company]

## Summary
- Offer:
- Stage:
- Contact/persona:
- Last touch:
- Next action:

## History
- YYYY-MM-DD: ...

## Latest draft
- Email:
- Proposal:

## Open questions
- ...
```

When shell access exists, call:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/update-local-state.ps1 -Company "[Company]" -Offer "[Offer]" -Stage "[Stage]" -NextAction "[Next action]" -DraftType "email" -DraftSummary "[short summary]" -FollowupDate "YYYY-MM-DD"
```

When user reports feedback, call:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/update-local-state.ps1 -Company "[Company]" -FeedbackText "[user feedback]"
```

When shell access is unavailable but file editing is available, update these files directly:

- `local-state/deals/index.md`
- `local-state/deals/[company-slug].md`
- `local-state/follow-ups.md` when there is a due date
- `local-state/feedback.md`

Use the same compact format shown above. Do not ask the user to paste blocks when direct file
editing is available.

## Feedback Prompt

After any buyer-facing draft, add one short prompt:

```text
Sau khi gửi, nhắn lại "khách trả lời..." hoặc "không phản hồi" để mình cập nhật deal.
```

If file writing is available, append a pending line to `local-state/feedback.md`.

## Safety

- Local deal/follow-up/feedback files can be updated automatically when the host allows it.
- Do not store secrets, API tokens, private raw inbox dumps, or sensitive customer data unless the
  user explicitly asks and understands the risk.
- If persistence fails, continue in-session and return the memory block.
