---
name: research-prospect
description: >
  Researches or qualifies a B2B prospect company and identifies likely personas before outreach.
  Triggered by "research [company]", "tim hieu cong ty [ten]", "nghien cuu prospect",
  "who are the decision makers at [company]", "cho tao biet ve cong ty [ten]", "cham diem
  prospect", or "xem co nen tiep can".
  Uses local memory, user context, optional public research, and returns a short practical brief.
---

# Research Prospect / Nghien Cuu Prospect

Use this skill for research-only requests. If the user asks for research plus email/proposal/next
step, use `run-pipeline` instead.

## Goal

Create a short brief that helps a sales rep decide how to approach the account.

## Process

1. Check local deal memory under `local-state/deals/` when available.
2. Check CRM only when the user's environment separately provides it.
3. Enrich with public research when browser/search tools are available.
4. If the prospect is Vietnamese, an SME, or the user provides MST/tax code, load
   `references/vietnam-business-sources.md` and check relevant registry/company sources before
   concluding public data is thin.
5. Use ICP and pain-signal references.
6. Identify named decision makers only when sourced; otherwise identify target personas.
7. Track missing local memory, CRM, or public research internally.
8. Label assumptions in plain language only when needed.

## Data to Gather

- Company snapshot: industry, size, location, product/service, market.
- Local/CRM status: cold prospect, active deal, lost deal, unknown.
- Relationship history: contacts, notes, calls, emails, deal stage.
- Recent triggers: hiring, funding, expansion, leadership change, product launch.
- Pain signals: sales scaling, manual process, RevOps hiring, long cycle, proposal bottleneck.
- Decision makers: names only if sourced; personas otherwise.
- Suggested next step.

## Fallback Rules

- No local memory: continue as unknown/cold relationship.
- No CRM data: continue as cold prospect.
- No public data: use local/user context and lower confidence.
- No named contacts: recommend persona-based outreach.
- Sparse Vietnamese SME data: ask one natural question early if it changes the message angle:
  "Công ty này làm ngành gì và mình muốn nhắm ai? Nếu chưa rõ, mình viết bản trung tính."
- Conflicting facts: disclose conflict and avoid disputed facts in outbound copy.

## Output

```markdown
## Tóm tắt nhanh: [Company]

- Mình biết:
- Mình đang giả định:

### Góc tiếp cận
...

### Người nên nhắm tới
- ...

### Việc tiếp theo
...

### Cần bổ sung
- ...
```

Omit `Cần bổ sung` if there is nothing important.

## Language

Reply in the same language as the user. Keep names, titles, company names, and source titles in
their original language.

## References

- `references/icp-profiles.md`
- `references/pain-signal-patterns.md`
- `references/vietnam-business-sources.md`
- `policies/confidence-and-source-policy.md`
