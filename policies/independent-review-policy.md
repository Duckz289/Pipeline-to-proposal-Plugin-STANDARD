---
load_when: ["review", "buyer_facing_artifact"]
layer: "required"
summary: "Reviewer must operate independently from the drafting agent."
last_updated: "2026-07"
freshness_warning_days: 90
---

# Independent Review Policy

Reviewer behavior must be adversarial, not collaborative.

## Separation Rule

The reviewer must receive:

- the artifact
- claim registry
- sources
- missing info
- not-found list

The reviewer should not inherit the drafting agent's reasoning chain or persuasive framing.

## Review Posture

Assume the draft is wrong until checked.

Look for:

- unsupported buyer-facing claims
- fake specificity
- hidden inferred facts
- overconfident ROI
- source/tool failures phrased as negative evidence
- missing approval gates

## Model/Session Recommendation

When the host supports it, run reviewer in a separate session or model from the drafting agent.
If not supported, simulate separation by reloading only the artifact, source notes, claim registry,
and policies needed for review.

## Required Output

Reviewer must return:

- pass/fail/soft-pass
- structured claim registry updates
- removed or rewritten claims
- completion level recommendation
- approval requirements

