# Known Limitations

This is a free local-first plugin. It avoids hosted infrastructure and external server maintenance.

## Public Research

- Small Vietnamese companies, SMEs, and early startups may have little public data.
- Public search is optional. If no search/browser tool is available, the plugin uses user context,
  local memory, and ICP patterns.
- Search snippets are leads, not verified facts.

## Local Memory

- Local memory lives in `local-state/`; it is only as good as what the plugin can save or the user
  reports back.
- If the host cannot write files, the plugin returns a short memory block in chat instead.
- Follow-up reminders are markdown checklist items, not automatic notifications.

## Product Context

- If product context is empty, the user can include the offer in one sentence and the plugin can
  save a starter context when writing is available.
- Saved context can become stale when pricing, ICP, packages, proof points, or CTA change.

## CRM And Email

- The plugin does not bundle CRM integrations or server-side sync.
- `sync-crm` prepares notes/tasks for copy-paste unless the user's environment separately provides
  an approved CRM tool.
- The plugin never sends email or writes to CRM without explicit approval.

## ROI And Proof

- ROI is a framework until buyer/user numbers are provided.
- Customer names, metrics, guarantees, quotes, and case studies must be verified.
- Inferred pain points can guide drafting, but must be labeled.

## Learning From Feedback

- Feedback is captured in `local-state/feedback.md` or returned as a short chat note.
- The plugin suggests updates; it does not silently rewrite templates or product context.
