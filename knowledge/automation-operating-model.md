---
load_when: ["automation", "write_back", "approval", "crm", "email_send"]
layer: "conditional"
summary: "Assist/Copilot/Action modes and approval boundaries for sales automation."
last_updated: "2026-07"
freshness_warning_days: 90
---

# Automation Operating Model

This plugin supports three operating modes.

## Assist Mode

Default for new users.

- Reads available context.
- Produces drafts in chat.
- No external write-back.
- Best for testing quality and training the sales playbook.

## Copilot Mode

Use after the user trusts the outputs.

- Reads CRM and knowledge base.
- Produces drafts.
- Prepares CRM notes/tasks.
- Requires approval before writing.

## Action Mode

Use only with mature governance.

- Can prepare outbound actions.
- Requires exact human approval before send/write.
- Logs assumptions and sources.

## Recommended Rollout

1. Week 1: Assist mode for 10 real prospects.
2. Week 2: Copilot mode for CRM notes and follow-up tasks.
3. Week 3: Add proposal drafts for active opportunities.
4. Week 4: Measure time saved, reply rate, and proposal movement.

## Success Metrics

- Research time saved per prospect.
- Email draft time saved.
- Proposal draft time saved.
- Reply rate.
- Meeting booked rate.
- Proposal-to-next-meeting rate.
- CRM hygiene improvement.
