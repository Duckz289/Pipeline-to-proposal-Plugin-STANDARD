---
load_when: ["buyer_facing_artifact"]
layer: "required"
summary: "Blocks completion_level: full when any buyer-facing claim has unresolved status."
last_updated: "2026-07"
freshness_warning_days: 90
---

# Verification Checkpoint

Run this checkpoint after the Reviewer Agent has built the claim registry, before the Orchestrator
marks any artifact as `completion_level: full`.

## Purpose

Prevent buyer-facing artifacts from shipping with unsupported or unconfirmed claims that could
embarrass the user or misrepresent the prospect.

## When to Run

- Before every buyer-facing artifact: outreach email, proposal, executive summary.
- After the Reviewer Agent has populated `claim_registry` and `validation_findings`.
- Before setting `completion_level: full` in the output bundle.

## Checkpoint Steps

### Step 1: Scan Claim Registry

Check every entry in `claim_registry` where `buyer_facing: true`.

| Claim status | Allowed action | Checkpoint result |
|---|---|---|
| `supported` | `keep` | ✅ Pass |
| `user_provided` | `keep` | ✅ Pass |
| `inferred` + `label` | Claim is labeled in artifact | ✅ Pass |
| `inferred` + `remove` | Claim is removed | ✅ Pass |
| `inferred` + `ask_user` | Awaiting user confirmation | ⚠️ Soft Pass only |
| `unsupported` + `remove` | Claim is removed from artifact | ✅ Pass |
| `unsupported` + any other action | Claim remains in buyer-facing copy | ❌ Fail |
| `removed` | Already handled | ✅ Pass |

### Step 2: Verify Not Found Is Present

If research was run, confirm the `not_found` section exists in the output and lists every important
searched item that returned no result.

- Empty `not_found` when no research was run: fine.
- Missing `not_found` after research was attempted: checkpoint failure.

### Step 3: Verify Edit Markers

Confirm that all claims requiring user review have `[[EDIT: ...]]` markers in the artifact.

An inferred claim left without an edit marker and without an "inferred" label is a failure.

### Step 4: Check ROI and Performance Claims

If the artifact contains ROI, savings estimates, or performance benchmarks:

- Assumptions must be listed explicitly.
- Forbidden language: "will save", "guaranteed to increase", "proven to reduce", "100% improvement".
- Required language: "based on [assumption]", "estimated if [condition]", "internal assumption".

Guaranteed-outcome language without verified customer data is a failure.

## Checkpoint Outcomes

### Pass — Artifact can be marked `completion_level: full`

All conditions met:
- No buyer-facing unsupported claims remain in artifact text.
- All inferred buyer-facing claims are labeled or removed.
- `not_found` section is present after research.
- All placeholders that need human review have `[[EDIT: ...]]` markers.
- ROI assumptions are explicit with no guaranteed-outcome language.

### Soft Pass — Artifact must be marked `completion_level: draft`

Conditions partially met; all unsupported claims have been removed but:
- Some inferred claims have `ask_user` status pending user confirmation.
- Some required fields are missing, documented in `missing_info`.
- Edit markers are present because sourced data is not yet available.

A `draft` artifact is suitable for internal review but not for sending without human edits.

### Fail — Artifact must be marked `completion_level: skeleton`

One or more hard failures:
- At least one buyer-facing `unsupported` claim remains in the artifact text.
- `not_found` is missing after research was run.
- ROI contains guaranteed-outcome language without verified customer data.
- Named person appears in buyer-facing copy without CRM, public, or user-provided source.

A `skeleton` artifact must be completed by the user before any external use.

## Required Output Block

After running this checkpoint, include in the output bundle:

```markdown
### Verification Checkpoint
- Result: Pass / Soft Pass / Fail
- Completion level: Full / Draft / Skeleton
- Claims reviewed: [N total, N buyer-facing]
- Unsupported claims removed: [N]
- Inferred claims labeled: [N]
- Edit markers placed: [N]
- Not Found section: Present / Missing / Not required
- ROI assumptions: Explicit / Missing / Not applicable
- Blocking issues: [list if Fail, or "None"]
```

## Hard Rules

- Never override a Fail result to produce a `full` artifact without addressing the failure reason.
- If the user asks to mark output full despite a failure, explain what must be fixed and offer to
  fix it immediately.
- A Soft Pass is not a Pass. Do not present a `draft` artifact as ready to send without user edits.
- The checkpoint result determines `completion_level`. No other instruction overrides it.
