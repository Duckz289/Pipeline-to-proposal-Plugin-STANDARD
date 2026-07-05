# Maintenance Guide

Keep the plugin useful by maintaining the local files sales reps actually rely on.

## Weekly

- Review `local-state/follow-ups.md`.
- Move completed follow-ups into the relevant deal file under `local-state/deals/`.
- Add replies, objections, wins, losses, and user edits to `local-state/feedback.md`.
- Check whether pending feedback items can update templates or product context.

## Monthly

Update `local-state/product-context.md` and `knowledge/product-context-template.md` when:

- pricing changes
- packages change
- ICP changes
- new proof points or case studies become available
- common objections change
- default CTA changes

## Before Release

1. Validate `.claude-plugin/plugin.json`.
2. Validate `scripts/update-local-state.ps1` parses.
3. Run manual tests that match changed behavior.
4. Search for accidental server/infrastructure references in active docs.
5. Update `CHANGELOG.md`.
6. Bump `.claude-plugin/plugin.json` version.
7. Package a new `.zip` / `.plugin` only when needed; do not delete older packages.
