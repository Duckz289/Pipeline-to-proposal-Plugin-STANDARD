---
load_when: ["source_missing", "data_incomplete"]
layer: "conditional"
summary: "What to do when each local or optional data source is missing, unavailable, or weak."
last_updated: "2026-07"
freshness_warning_days: 90
---

# Data Fallback Matrix

Use this matrix when a data source is missing, unavailable, or returns no usable result. Every
fallback should produce a partial artifact, not a dead end.

## Source Fallback Table

| Source | Failure type | Impact | Fallback action |
|---|---|---|---|
| Local deal memory | No matching file | Relationship history unknown | Treat as cold/unknown. Create the deal file after useful output if possible. |
| Product context | Empty | Offer unclear | Ask one short offer question. If user gives offer, save starter product context if possible. |
| CRM | Not connected | No relationship history | Treat as cold/unknown. Mark CRM unavailable, not absent. |
| CRM | Auth error or timeout | Relationship history unknown | Say CRM was unavailable. Do not say no record exists. |
| CRM | Connected, no match found | Confirmed cold prospect | Mark as no CRM record only if the query succeeded. |
| Public research | Tool unavailable | Limited company facts | Ask one early context question if needed, then use persona-based drafting. |
| Public research | Weak results | Uncertain public facts | Ask one early context question if needed. Use careful language. |
| Named contact | Not found | No personalized outreach | Switch to persona-based outreach. Never invent a name. |
| Pricing or scope | Not provided | Cannot draft final proposal | Create proposal skeleton with `[[EDIT: confirm pricing]]`. |
| Proof or case study | Not available | Generic methodology only | Use methodology framing. Do not invent customer results. |
| Email history | Not available | No prior thread context | Draft without thread reference. |
| Follow-up date | Unknown | Reminder cannot be scheduled | Suggest a conservative timing and save it if possible. |

## Artifact Output Level by Data Availability

| Data available | Artifact level | Action |
|---|---|---|
| Local/user context + public/CRM + offer + pricing | Full | Proceed normally |
| Partial context + offer + pricing | Draft | Note missing items |
| Company name + offer, no public/CRM | Draft or skeleton | Mark inferred sections |
| Company name only, no offer | Ask | Get offer before drafting |

## Public Research Caution

| Result quality | Language to use |
|---|---|
| Direct company statement or source opened | "Theo website/nguồn của [company]..." |
| Reputable news source | "Theo [publication]..." |
| Snippet only or weak source | "Nguồn public gợi ý..." |
| No usable result | Record in `not_found`. Do not speculate. |

Never upgrade snippet-only results to confirmed facts.

## Internal Tracking

Track missing sources internally only when it matters:

```json
{
  "source": "[local_memory|product_context|crm|public_research|email_history]",
  "status": "[available|missing|unavailable|timeout|failed|not_attempted]",
  "impact": "one sentence",
  "fallback_used": "what was done instead"
}
```

## Plain Disclosure

When any important source fails or is missing, include a brief disclosure:

```markdown
### Cần bổ sung
- Chưa rõ ngành/người nhận, nên mình viết bản trung tính.
```
