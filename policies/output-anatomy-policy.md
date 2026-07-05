# Output Anatomy Policy

Use short plain section headers so sales users can scan repeated outputs.

Default to compact output. Expand only when the user explicitly asks.

Avoid internal terms in user-facing output: status, confidence, source health, claim registry,
pipeline state, context loaded, artifact level, ICP score. Use everyday wording instead.

## Hard Output Cap

Normal output should fit on one screen:

- Maximum 3 sections for normal output.
- Maximum 4 sections only when the user explicitly asks for multiple artifacts.
- Maximum 12 bullets outside the buyer-facing draft.
- Only one buyer-facing draft unless the user asks for variants.
- Omit "Cần bổ sung" when there is nothing urgent.

## Length Budgets

- Prospect brief: 100-220 words.
- Cold email: 60-110 words.
- Follow-up: 40-80 words.
- Proposal skeleton: 250-500 words.
- Full proposal: generate only when explicitly requested.
- Debug/source sections: omit unless the user asks or the draft is risky.

## Default Opening

```markdown
### Kết quả
- Dùng được ngay / Cần sửa nhẹ / Thiếu dữ liệu
- Cần bổ sung: ...
- Trước khi gửi: ...
```

## Prospect Brief

1. Kết quả
2. Góc tiếp cận
3. Việc tiếp theo

## Outreach Email

1. Kết quả
2. Nội dung gửi
3. Việc tiếp theo

## Proposal

1. Kết quả
2. Proposal nháp
3. Việc tiếp theo

## Full Pipeline

1. Kết quả
2. Nội dung quan trọng nhất
3. Việc tiếp theo

Do not include full outreach email, full proposal, and full CRM note in the same response unless
the user explicitly requested all three. Default output should fit on one screen when possible.

## Inline Edit Markers

Use this marker format for user-editable placeholders:

```text
[[EDIT: short description]]
```

Examples:

- `[[EDIT: company name]]`
- `[[EDIT: sourced trigger]]`
- `[[EDIT: confirm pricing]]`
- `[[EDIT: verified proof point]]`

Do not mix `[Company]`, `{company}`, `<company>`, and `[[EDIT: ...]]` in the same artifact.
