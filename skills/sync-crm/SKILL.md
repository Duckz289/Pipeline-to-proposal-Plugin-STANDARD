---
name: sync-crm
description: >
  Prepares local CRM notes, follow-up tasks, and deal-stage suggestions for copy-paste.
  Triggered by "sync CRM", "update deal stage", "log this to HubSpot", "cap nhat CRM",
  "day note vao Salesforce", "tao task follow-up", or "ghi lai deal nay".
---

# Sync CRM / Local CRM Note

This release prepares clean CRM notes/tasks for copy-paste.

Use this skill to prepare exact content the salesperson can copy into CRM, or to update local deal
memory under `local-state/`.

## Rule

Never claim an external CRM was updated unless a separate approved CRM tool actually performed the
write.

## Process

1. Summarize the latest deal context.
2. Prepare a concise CRM note.
3. Prepare a follow-up task with date, owner, and action.
4. Suggest deal-stage change only as a recommendation.
5. Update local deal memory when writing is available.

## Output

```markdown
### Note để dán vào CRM
...

### Task follow-up
- Hạn:
- Người làm:
- Việc cần làm:

### Gợi ý stage
...

### Đã lưu
- local-state/deals/[company].md
```

## References

- `policies/human-approval-policy.md`
- `policies/state-management-policy.md`
