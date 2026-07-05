---
name: setup-product-context
description: >
  Helps the user set up or refresh persistent local product context for Pipeline-to-Proposal.
  Triggered when the user asks to "save my offer", "set up product context", "remember what I sell",
  "luu context san pham", "thiet lap thong tin san pham", "ghi nho toi ban gi", or wants the
  sales pipeline to remember offer, pricing, ICP, proof points, objections, and proposal defaults.
---

# Setup Product Context / Thiet Lap Context San Pham

Use this skill when the user wants future sales drafts and proposals to reuse their real offer.

## Goal

Collect enough business context to save a useful local product memory for:

- `local-state/product-context.md`
- optionally `knowledge/product-context-template.md`

If the host can write files and `local-state/product-context.md` is empty, save the starter context
automatically. Ask before replacing an existing non-empty context.

## Intake Questions

Ask only for fields that are missing from the conversation. Keep the first pass short.

Minimum useful context:

1. What do you sell?
2. Starting price or package range, if known.
3. Best-fit customer.

Optional only when needed:

- proof points or case studies
- common objections
- default CTA
- preferred tone/style

If the user is busy, accept partial answers and mark the rest as `Not set yet`.

## Output

Return:

- "Đã lưu" if the file was updated.
- A short summary of the offer.
- One short question for the most important missing field, only if needed.
- A compact fallback block only when file writing is unavailable.

Follow `references/product-context-fields.md` for the final structure when a fuller version is
needed.

## Safety

- Never invent customer names, metrics, pricing, guarantees, or case studies.
- If a proof point is aspirational, label it as an assumption or target outcome.
- Keep buyer-facing claims conservative unless the user provides evidence.
- Do not overwrite existing context without showing a preview and receiving explicit approval.
- Do not expose internal labels in normal output.
