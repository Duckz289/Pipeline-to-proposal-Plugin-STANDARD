---
name: update-deal-feedback
description: >
  Updates local deal history when the user reports what happened after an email/proposal/follow-up.
  Triggered by "khach reply", "khach phan hoi", "khong phan hoi", "book meeting", "hen call",
  "won", "lost", "mat deal", "chot deal", "meeting booked", "no reply", or "cap nhat deal".
---

# Update Deal Feedback / Cap Nhat Ket Qua Deal

Use this skill when the user reports a sales outcome.

## Goal

Update the local deal file, deal index, feedback log, and follow-up list without asking the user to
fill a form.

## Inputs To Extract

- Company/deal name.
- What happened: replied, no reply, meeting booked, objection, won, lost, proposal advanced.
- Buyer wording if pasted.
- Next action if obvious.
- Follow-up date if mentioned.

If the company is missing, ask one short question:

```text
Deal này của công ty nào?
```

## Stage Mapping

- "khach reply", "phan hoi", "tra loi", "interested" -> Replied.
- "hen call", "book meeting", "demo", "dat lich" -> Meeting booked.
- "khong phan hoi", "im lang", "no reply" -> Waiting reply.
- "gui proposal", "bao gia", "quote" -> Proposal sent.
- "chot", "ky hop dong", "won" -> Won.
- "mat deal", "chon ben khac", "lost" -> Lost.

## Local Update

Save priority:

1. Directly edit local markdown files if file writing is available.
2. If shell access is available, call:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/update-local-state.ps1 -Company "[Company]" -FeedbackText "[what user said]" -FollowupDate "[YYYY-MM-DD if known]"
```

3. If writing is unavailable, return only this compact fallback:

```markdown
### De luu lai
- [Company] - [Stage] - [Next action]
```

## Output

Keep it short:

```markdown
### Đã cập nhật
- Stage: ...
- Việc tiếp theo: ...

### Tin nhắn trả lời
...
```

Omit `Tin nhắn trả lời` when there is no reply/action to send.

## Reply Suggestions

If the user says the buyer replied or asked a question, draft one short response automatically.

- Buyer wants meeting/demo: confirm time and ask for 1-2 priorities.
- Buyer asks price: answer with known range or ask for scope; do not invent pricing.
- Buyer says "send proposal": acknowledge and confirm the proposal timing.
- Buyer has objection: answer the objection briefly and ask one next-step question.
- No reply: suggest a light follow-up, not a reply.
