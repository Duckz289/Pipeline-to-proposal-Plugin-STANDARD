# Full Pipeline Example

User:

```text
Chạy pipeline cho Acme, công ty SaaS B2B. Mình bán AI sales automation, muốn email đầu tiên và
proposal nháp.
```

Expected behavior:

1. Extract company: Acme.
2. Detect requested outputs: prospect brief, outreach email, proposal.
3. Check CRM.
4. Run public research if CRM is empty.
5. Ask for pricing if not provided, but continue with proposal skeleton.
6. Draft email.
7. Draft proposal skeleton.
8. Review and return bundle.

Expected output status:

```text
Completion level: Draft/Skeleton
Confidence: Medium
Missing info: pricing, named recipient, confirmed case study
Approval needed before: sending email, logging CRM note
```
