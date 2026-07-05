---
name: draft-outreach-email
description: >
  Drafts personalized B2B outreach and follow-up messages. Triggered by "write email",
  "draft email to [contact]", "viet email cho [ten/cong ty]", "soan email chao hang",
  "follow-up", "break-up email", or "LinkedIn message". Uses prospect brief, local deal memory,
  and offer data when available.
---

# Draft Outreach Email / Soan Email Tiep Can

Use this skill for message-only requests. If the user also wants research, proposal, or next-step
automation, use `run-pipeline`.

## Required Inputs

- Company name.
- Recipient name or target persona.
- Sales stage.
- Product/service or offer.
- Desired CTA.

If company or offer is missing, ask one short question before producing a final send-ready message.
If recipient is missing, draft for a persona and label it clearly.

## Message Types

- Cold first touch.
- Follow-up #1.
- Follow-up #2.
- Break-up email.
- Re-engagement.
- Post-call recap.
- Proposal follow-up.
- LinkedIn connect/message.
- Call opener.

## Writing Rules

- Cold email: 60-110 words.
- Follow-up: 40-80 words.
- Subject: under 50 characters.
- No fake familiarity.
- No invented proof.
- Avoid generic AI phrasing.
- Avoid overly formal/corporate Vietnamese.
- Keep CTA low-friction.
- Use `[[EDIT: ...]]` for placeholders that need human review.

## Output

```markdown
### Nội dung gửi
Tiêu đề:
- [Option 1]
- [Option 2]
- [Option 3]

[Email body]

### Việc tiếp theo
- Sửa: ...
- Sau khi gửi, nhắn lại "khách trả lời..." hoặc "không phản hồi" để mình cập nhật deal.
```

## Fallback Rules

- No named recipient: write persona-based draft.
- No trigger: use problem-led angle and mark confidence medium/low.
- No proof: use methodology proof, not fake case study.
- Unknown CTA: default to a 15-minute discovery call.
- Weak public research: do not stall. Write a conservative draft using local/user context.
- After drafting, update local deal memory and add a feedback pending note when writing is
  available.

## Vietnamese Guidance

Use `../../knowledge/vietnamese-sales-language.md`. Prefer natural "anh/chị" language for B2B
prospects.

## References

- `references/email-templates.md`
- `references/objection-responses.md`
- `../../policies/human-approval-policy.md`
- `../../policies/output-anatomy-policy.md`
- `../../policies/hallucination-prevention-policy.md`
