# Checkpoint Policy

Use checkpoints to keep the workflow useful without overwhelming the user.

| Situation | Action |
|---|---|
| Request is vague at conversation start | Use `skills/mode-selector/SKILL.md`. |
| Research done, email/proposal not requested | Stop, show brief, offer next options. |
| Research done, email requested, offer unknown | Ask for offer before continuing. |
| Email drafted, proposal not requested | Show email and offer to continue to proposal. |
| Full pipeline, qualification is weak | Stop after light research and ask before proposal. |
| Buyer-facing artifact has inferred or unsupported claims | Run verification checkpoint; keep as draft until resolved. |
| Any write-back or send requested | Always checkpoint with exact content preview and approval request. |

## Checkpoint Style

Keep checkpoints short. Ask for a decision, not a long explanation.

Good:

```text
Research xong. Fit đang yếu vì chưa thấy team sales B2B hoặc pain liên quan. Muốn tao dừng ở brief,
hay vẫn viết email persona-based?
```

Avoid long menus unless the user is at the start of the workflow.

