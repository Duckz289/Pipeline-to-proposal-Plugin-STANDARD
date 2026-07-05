# Human Approval Policy

Human approval is required before any external or persistent action.

This local-first release usually produces drafts and local memory blocks. Do not claim an external
action happened unless a separate approved tool actually performed it.

## Approval Required

- Sending an email.
- Creating an email draft in an external mailbox.
- Logging a CRM note.
- Creating CRM tasks.
- Updating deal stage.
- Creating contacts or companies.
- Changing owner, value, close date, or pipeline.
- Sending proposal links or attachments.
- Writing local files when the environment requires explicit user approval.

## Approval Message Format

Before action, summarize:

- Action.
- Target record/file/recipient.
- Exact content or fields to write.
- Why the action is recommended.

Ask:

```markdown
Approve this action?
```

Proceed only after clear approval.

## No Approval Needed

- Producing drafts in chat.
- Creating a plan.
- Producing a CRM note draft without writing it.
- Producing a local memory block in chat.
- Reading local plugin knowledge files.
