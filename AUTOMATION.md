# Local Automation Blueprint

This plugin is optimized for a single salesperson running locally.

## Primary Command

```text
Chạy cho [Company]. Tao bán [offer]. Cần [email/proposal/next step/all].
```

## Default Loop

1. Parse the user's one-sentence request.
2. Load only the product/deal memory needed from `local-state/`.
3. Use user-provided context first.
4. Research lightly when a search/browser/tool is available.
5. If public data is weak, ask one early practical question when it changes the angle.
6. If the user has no more context, switch to persona-based drafting.
7. Produce the shortest useful artifact.
8. Save local deal/follow-up/feedback when writing is available.
9. Ask approval before any send/write action.

## Decision Tree

| User wants | Route |
|---|---|
| Research | Research agent |
| Email | Research if needed -> Messaging agent -> Reviewer |
| Proposal | Research if needed -> Proposal agent -> Reviewer |
| Next step | Deal coach agent -> Messaging if draft needed -> Reviewer |
| Full automation | Orchestrator -> only needed agents -> Reviewer |
| CRM/log task | Draft local note/task for copy-paste |

## Critical Stop Points

Stop and ask when:

- company is unknown
- offer is unknown for email/proposal
- pricing is unknown for a final proposal
- the user explicitly asks to send or write somewhere

Otherwise continue with assumptions and mark them clearly.

## Local Follow-Up Habit

When a next action has a date, save this line to `local-state/follow-ups.md` when possible:

```markdown
- [ ] YYYY-MM-DD - [Company] - [Action] - [Context]
```

If writing is unavailable, return it under `Để lưu lại`.

Use `scripts/update-local-state.ps1` when shell access exists.

## Output Standard

Every output should include only what helps the rep act:

- Kết quả
- Nội dung gửi / proposal / note
- Cần bổ sung, only when important
- Việc tiếp theo
- Đã lưu, only when files were updated
- One short feedback prompt after buyer-facing drafts
