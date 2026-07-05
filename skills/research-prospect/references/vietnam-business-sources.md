---
load_when: ["research", "vietnam", "sme", "mst", "ma_so_thue"]
layer: "conditional"
summary: "Vietnam-specific public research checklist for SMEs with thin web presence."
last_updated: "2026-07"
freshness_warning_days: 90
---

# Vietnam Business Research Sources

Use this checklist when the company appears to be Vietnamese, has sparse web presence, or the user
provides a tax code/MST.

## Preferred Checks

1. Company website and social pages.
2. CRM notes and user-provided context.
3. Tax code/MST lookup if the user provides MST or exact legal name.
4. National business registration/public registry search when available.
5. Job posts, Facebook/LinkedIn pages, marketplace listings, and local news.

## What To Extract

- Legal name vs trading name.
- MST/tax code if provided or publicly found.
- Registered address and operating city.
- Industry/business line.
- Representative/legal representative only when sourced.
- Website/social channel freshness.
- Hiring or expansion signals.

## Safety Rules

- Do not infer company size from charter capital, address, or social followers.
- Do not treat missing public registry results as proof the company is inactive.
- Do not include personal phone/email from public directories in outbound copy unless user
  explicitly confirms it is appropriate.
- If only MST/legal registry data exists, mark research depth as low and use persona-based outreach.

## Vietnamese Output Note

For SMEs, prefer practical phrasing:

```text
Dữ liệu public của công ty này khá mỏng. Brief dưới đây dựa trên thông tin tìm được từ [nguồn],
CRM/user context, và các giả định đã được gắn nhãn.
```

Do not overstate the quality of research.
