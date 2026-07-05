# Confidence and Source Policy

## Source Labels

Use these labels in outputs:

- CRM: data from connected CRM.
- Local: local product context, deal memory, follow-up list, or feedback file.
- Internal: company knowledge base, pricing docs, product docs, templates.
- Public: website, public news, job posts, public profiles.
- User: information provided in chat.
- Inferred: reasoned from patterns; not verified.

## Confidence Scoring

High confidence:

- Critical fields are present.
- At least one authoritative source supports core facts.
- No major conflicts.

Medium confidence:

- Enough data to draft.
- Some facts are inferred or public sources are thin.
- Missing data does not block a useful draft.

Low confidence:

- Only company name or minimal user context is available.
- Important output sections rely on inference.
- Artifact should be treated as exploratory.

## Required Source Support

These claims need source support or must be removed:

- Funding, acquisitions, executive changes.
- Current headcount or revenue.
- Technology stack.
- Named decision makers.
- Existing vendor relationships.
- Case study results.
- ROI or performance claims.

## Claim Validation Procedure

Before returning buyer-facing copy, classify risky claims:

- `supported`: backed by CRM, internal knowledge, public source, or a cited user-provided fact.
- `user_provided`: supplied by the user in the current conversation.
- `inferred`: reasonable internal hypothesis; must be labeled and kept out of confident external
  claims.
- `unsupported`: no source; remove from external copy.
- `removed`: deleted during review because it was risky or unnecessary.

Risky claim types include:

- People: names, titles, emails, decision-maker roles.
- Company facts: funding, revenue, headcount, hiring, technology, vendors.
- Commercial facts: pricing, discounts, package terms, deadlines.
- Proof: customer logos, metrics, quotes, case studies, benchmarks.
- ROI: savings, uplift, payback, productivity gains.

If a buyer-facing artifact contains unsupported risky claims, the reviewer must remove them or
downgrade the artifact before returning it.

## Inference Rules

Allowed:

- "Likely pain point based on hiring pattern."
- "Suggested persona based on company size."

Not allowed:

- Presenting inferred facts as verified.
- Creating fake names, emails, titles, quotes, or metrics.
- Treating unavailable CRM/search/local memory as proof that a fact does not exist.
