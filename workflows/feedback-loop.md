---
load_when: ["feedback", "win_loss", "template_update", "knowledge_update"]
layer: "conditional"
summary: "Collects sales outcomes and turns them into simple local learning."
last_updated: "2026-07"
freshness_warning_days: 90
---

# Feedback Loop Workflow

Feedback should feel like a quick sales note, not a report.

## When To Ask

After every buyer-facing draft, add one short line:

```text
Sau khi gửi, nhắn lại "khách trả lời..." hoặc "không phản hồi" để mình cập nhật deal.
```

If file writing is available, append a pending item to `local-state/feedback.md`.

## Inputs

- sent / not sent
- replied / no reply
- objection received
- meeting booked
- proposal advanced / stalled / lost / won
- user edited the copy

## Process

1. Save a short dated note in `local-state/feedback.md`.
2. Update the matching deal file and deal index.
3. Change the stage immediately when the wording is clear:
   - replied -> Replied
   - no reply -> Waiting reply
   - meeting booked -> Meeting booked
   - proposal sent -> Proposal sent
   - won -> Won
   - lost -> Lost
4. If the feedback changes the offer, pricing, proof, or template style, suggest a small update.
5. If the buyer replied, suggest a short reply message immediately.
6. Ask before changing product context or templates.

## Note Format

```markdown
## YYYY-MM-DD - [Company]
- Output:
- Result:
- Buyer said:
- User changed:
- Next action:
```

## Rules

- Do not ask for long feedback forms.
- Do not silently change product claims, pricing, or templates.
- Winning copy can become a reusable example only after the user confirms it worked.
- For clear deal outcome feedback, do update local deal stage automatically.
- For buyer replies, produce a reply draft unless the user only asked to log the update.
