---
load_when: ["research", "public_data", "source_missing"]
layer: "conditional"
summary: "Reality check for prospect research quality and required source disclosure."
last_updated: "2026-07"
freshness_warning_days: 90
---

# Research Data Policy

Research quality depends on available local/user/public data. Do not oversell research when public
tools or CRM are missing.

## Data Reality Levels

| Level | Available data | Allowed output |
|---|---|---|
| L3 | Local/user context + CRM/public source | sourced prospect brief |
| L2 | Local/user context + one public or CRM source | draft brief with gaps |
| L1 | User/local context only | user-context brief; no public claims |
| L0 | Company name only | ask or produce skeleton with low confidence |

## Required Disclosure

Every prospect brief must say which data level was used when confidence is not high.

If public research tools are unavailable, say:

```text
Public research was unavailable, so this uses user/local context only.
```

If CRM is unavailable, say:

```text
CRM was unavailable, so relationship history is unknown.
```

## Not Allowed

- Do not infer LinkedIn, Crunchbase, funding, headcount, or tech stack data without a source or
  user-provided evidence.
- Do not call a prospect "cold" because CRM was unavailable.
- Do not use generic market assumptions as company facts.
