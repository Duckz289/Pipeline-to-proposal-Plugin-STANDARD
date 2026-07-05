---
name: suggest-next-step
description: >
  Analyzes prospect or deal history and recommends the best next sales action. Triggered by
  "next step for [company]", "what should I do next", "buoc tiep theo", "deal nay dang stuck",
  "ho chua reply", "proposal sent no response", "proposal da mo nhung chua tra loi", or "revive
  this deal". Uses local deal memory when available and asks for missing timeline only when needed.
---

# Suggest Next Step / Goi Y Buoc Tiep Theo

Use this skill for next-action coaching. If the user also wants research/email/proposal, use
`run-pipeline`.

This skill is a thin wrapper around `agents/deal-coach-agent.md`.

## Inputs

- Company/contact.
- Local deal history or user-provided timeline.
- Deal stage if known.
- Proposal status if relevant.
- Engagement signals such as email opens, link clicks, proposal views, or page visits if available.
- User's latest update.

## Timeline Rule

If local deal memory exists:

- Use it before asking for recap details.
- Do not ask for last interaction unless the local file has no usable timing.

If no local memory exists:

- Extract timing from the user's message before asking for more detail.
- Ask for the last interaction only when timing matters.
- If the user wants an immediate answer, return a conservative recommendation and label the
  missing timeline.

## Deal-State Logic

Load and follow `agents/deal-coach-agent.md` for:

- deal-state classification
- recommendation logic
- fallback behavior
- messaging angle
- signals to watch

## Output

```markdown
## Việc tiếp theo cho [Company / Contact]

### Tình hình
...

### Nên làm ngay
...

- Khi nào:
- Kênh:
- Góc nhắn:

### Tin nhắn nháp
...

### Nếu vẫn chưa phản hồi
...

### Đã lưu / Để lưu lại
- [ ] YYYY-MM-DD - [Company] - [Action] - [Context]

### Cần bổ sung
- ...
```

## References

- `references/follow-up-timing.md`
- `agents/deal-coach-agent.md`
- `policies/human-approval-policy.md`
- `policies/state-management-policy.md`
