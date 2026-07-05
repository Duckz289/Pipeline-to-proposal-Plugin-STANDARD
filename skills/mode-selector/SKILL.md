---
name: mode-selector
description: >
  Helps the user choose the right Pipeline-to-Proposal mode when their request is broad,
  ambiguous, or early in a conversation. Triggered by "bat dau", "toi nen dung mode nao",
  "help me choose", "chay sales plugin", or when the user gives a vague sales request without a
  clear artifact.
---

# Mode Selector / Chon Che Do

Use this skill when the user has not clearly asked for research, email, proposal, next step, or
full pipeline.

## Output

Show three choices and invite free-form input:

```markdown
Muốn tao làm phần nào?

1. **Research nhanh** - hiểu công ty và angle tiếp cận
2. **Email/follow-up** - viết bản ngắn để copy gửi
3. **Làm hết** - brief + email/proposal nháp + next step

Gõ 1, 2, 3 hoặc nói thẳng kiểu: "chạy cho ABC, tao bán X".
```

Use the same language as the user when possible.

## Routing

- `1` or research language -> `research-prospect`
- `2` or email/follow-up language -> `draft-outreach-email` or `suggest-next-step`
- `3` or broad automation language -> `run-pipeline`

Do not show the selector when the user already gave a clear command.
