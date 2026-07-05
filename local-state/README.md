# Local State

This folder is the local memory layer for the free plugin.

Use it when the host can read/write files in the plugin workspace.

Default behavior: save useful deal notes automatically when writing is available. Return a block in
chat only when writing is unavailable or approval is needed.

Save priority:

1. Edit these markdown files directly if the host supports file writes.
2. Use `scripts/update-local-state.ps1` if shell access is available.
3. Return a short `Để lưu lại` block only when neither option is available.

## Files

- `product-context.md`: what the salesperson sells, pricing, ICP, proof, CTA.
- `deals/index.md`: quick table of all deals.
- `deals/`: one markdown file per company or deal.
- `follow-ups.md`: simple reminder list for upcoming actions.
- `feedback.md`: replies, no-replies, wins, losses, objections, and user edits to learn from.

## Deal File Convention

Use a lowercase no-accent slug. The script creates it automatically:

```text
local-state/deals/acme.md
local-state/deals/cong-ty-minh-an.md
```

Keep each deal file short and readable for a salesperson:

```markdown
# [Company]

## Summary
- Offer:
- Stage:
- Contact/persona:
- Last touch:
- Next action:

## History
- YYYY-MM-DD: ...

## Latest draft
- Email:
- Proposal:

## Open questions
- ...
```

## Auto-Update Rules

Create or update a deal file after:

- first research
- email/follow-up draft
- proposal draft
- next-step recommendation
- user reports a reply, no reply, meeting booked, lost, or won

When the user reports feedback, update the stage:

- replied -> Replied
- no reply -> Waiting reply
- meeting booked -> Meeting booked
- proposal sent -> Proposal sent
- won -> Won
- lost -> Lost

Append a follow-up item when there is a clear next date:

```markdown
- [ ] YYYY-MM-DD - [Company] - [Action] - [Context]
```

Append a feedback prompt after buyer-facing drafts:

```markdown
## YYYY-MM-DD - [Company]
- Output:
- Result: pending
- Next action:
```

Do not store passwords, API tokens, private raw inbox dumps, or sensitive customer data unless the
user explicitly asks and understands the risk.
