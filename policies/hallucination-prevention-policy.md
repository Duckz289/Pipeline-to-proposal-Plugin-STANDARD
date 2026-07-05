# Hallucination Prevention Policy

This policy is the single source of truth for anti-hallucination behavior.

## Level 1: Never Invent

Never invent:

- names, titles, emails, or direct contact details
- prices, discounts, contract terms, or deadlines
- customer names, logos, case studies, metrics, or benchmarks
- quotes from prospects, customers, executives, or public sources
- funding rounds, acquisitions, revenue, headcount, or executive changes
- current vendors or technology stack

If missing, say it is missing or use a persona/placeholder.

## Level 2: Must Label

These can be useful but must be clearly labeled:

- inferred pain points
- persona-based outreach
- likely buying committee
- hypothesis about process maturity
- possible urgency based on hiring, news, or CRM behavior
- tracking-based interest level

Use language such as "hypothesis", "likely", "persona-based", or "inferred from".

## Level 3: Must Source Or Ask

These claims need CRM, public, internal, or user support before buyer-facing use:

- funding, headcount, revenue, or growth claims
- named decision makers
- technology stack and vendor relationships
- verified pain statements from the prospect
- ROI, performance, or efficiency claims
- case studies and customer results
- implementation timelines and pricing terms

If source support is unavailable, ask the user or remove the claim.

## Required Structural Checks

Every buyer-facing artifact must pass:

1. `Not Found` disclosure from research when important searches fail or return no result.
2. Structured claim registry using `schemas/claim-registry.schema.json`.
3. Verification checkpoint using `workflows/verification-checkpoint.md`.

Instruction-only review is not enough. The output must include structured evidence of what was
checked, what was not found, and which claims were removed, labeled, or kept.

