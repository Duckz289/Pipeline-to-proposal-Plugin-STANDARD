# Changelog

## 0.4.4

- Promoted the current local-first workflow as the official source version for this folder.
- Kept release packaging on the normalized forward-slash archive format for `.plugin` and `.zip`.
- Refined product description for release metadata and marketplace-style presentation.

## 0.4.3

- Changed local memory priority to direct markdown edits first, PowerShell script second, compact
  save block last.
- Updated feedback handling so buyer replies trigger a short suggested reply message.
- Tightened output guidance: normal output should stay within three sections; four only when the
  user explicitly asks for multiple artifacts.
- Added "Cách dùng trong 30 giây" near the top of README.
- Compressed email and proposal output templates to reduce section count.

## 0.4.2

- Added `update-deal-feedback` skill for user updates like reply, no reply, meeting booked, won,
  and lost.
- Improved `scripts/update-local-state.ps1` to infer deal stage from feedback text, normalize
  Vietnamese diacritics, update deal summaries, and maintain `local-state/deals/index.md`.
- Tightened default output to at most three sections for normal sales use.
- Replaced generic sparse-data question with more specific persona/industry questions.
- Documented deal slug and deal index behavior.

## 0.4.1

- Made local memory more proactive: create/update deal files, follow-up reminders, and pending
  feedback notes when file writing is available.
- Added earlier sparse-data questions for small/obscure companies before producing generic output.
- Reduced user-facing jargon: normal outputs should use plain sections like "Kết quả", "Nội dung
  gửi", "Việc tiếp theo", and "Đã lưu".
- Improved onboarding: first-run offer details can seed local product context when it is empty.
- Made feedback loop lighter: one short "tell me what happened" prompt after buyer-facing drafts.

## 0.4.0

- Removed bundled MCP server, queue worker, Docker config, MySQL migration, and server-oriented docs
  from the source plugin.
- Removed `mcpServers` from `.claude-plugin/plugin.json`.
- Added `local-state/` for local product context, deal memory, follow-up reminders, and feedback.
- Shifted research behavior away from Brave/API dependence and toward optional public research plus
  user/context-driven drafting.
- Simplified onboarding: a user can provide offer/pricing in one sentence instead of completing a
  long setup first.
- Reduced default output length for normal sales use.
- Updated CRM sync behavior to produce copy-paste local CRM notes/tasks by default.
- Updated state/resume behavior to use local markdown blocks instead of durable server state.

Older packaged releases remain available as existing `.zip` and `.plugin` files in the parent
folder.
