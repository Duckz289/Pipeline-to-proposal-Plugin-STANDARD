---
name: draft-proposal
description: >
  Creates a personalized B2B sales proposal, proposal skeleton, or executive summary.
  Triggered by "create proposal", "draft proposal for [company]", "tao proposal",
  "soan proposal", "viet de xuat", or "lam ban de xuat". Uses prospect brief, local deal context,
  offer knowledge, pricing, ROI framing, and approval rules.
---

# Draft Proposal / Soan Proposal

Use this skill for proposal-only requests. If the user also wants research/email/next step, use
`run-pipeline`.

## Required for Final Proposal

- Company name.
- Product/service being proposed.
- Primary pain points.
- Scope or package.
- Pricing or budget range.
- Target stakeholder.
- Next step.

If pricing or scope is missing, create a proposal skeleton and ask for the missing fields. Do not
invent pricing.

## Proposal Structure

Default short structure:

1. Executive summary.
2. Situation.
3. Proposed solution.
4. Scope / package.
5. Investment and ROI assumptions.
6. Next steps.

Use a longer structure only when the user asks for a full proposal.

## Output Versions

- Usable proposal: enough context exists.
- Short skeleton: pricing/scope/proof is missing.
- Executive summary only: context is very thin.

## Output

```markdown
### Proposal nháp
Tóm tắt:
...

Tình huống:
...

Cách làm:
...

Chi phí / ROI:
...

### Việc tiếp theo
- Bổ sung: ...
- Sau khi gửi proposal, nhắn lại phản hồi của khách để mình cập nhật deal.
```

## Rules

- Use real proof only.
- Show ROI assumptions transparently.
- Treat ROI as a framework until real customer numbers are confirmed.
- Mark unverified ROI/pricing numbers with `[NUMBER NEEDS CONFIRMATION]` or
  `[SỐ CẦN XÁC NHẬN]`; do not call the proposal send-ready while those markers remain.
- Label inferred pain points.
- Keep proposal practical and concise.
- Vietnamese proposals should use natural business Vietnamese, not stiff legal language.
- If pricing/scope is missing, keep the skeleton short instead of padding.
- After drafting, update local deal memory and add a feedback pending note when writing is
  available.
- Use `[[EDIT: ...]]` for placeholders that need human review.
- Run the verification checkpoint before calling a proposal send-ready.

## References

- `references/proposal-sections.md`
- `references/roi-calculator.md`
- `knowledge/product-context-template.md`
- `policies/confidence-and-source-policy.md`
- `policies/hallucination-prevention-policy.md`
- `policies/output-anatomy-policy.md`
- `workflows/verification-checkpoint.md`
