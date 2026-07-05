# User Intent Cases

Use this file to classify messy user requests into a reliable pipeline path.

## Case 1: Full Pipeline

User says:

- "Run the whole pipeline for Acme."
- "Lam het tu research den proposal cho cong ty nay."
- "Tu dong hoa sales cho prospect nay."

Action:

- Produce prospect brief, outreach email, proposal draft or skeleton, next best action, CRM note
  draft.
- Ask only for critical missing offer/pricing/contact details.

## Case 2: Research Only

User says:

- "Research Acme."
- "Tim hieu cong ty nay."
- "Who are decision makers at Acme?"

Action:

- Run research agent only.
- Output prospect brief, source notes, confidence, recommended angle.
- Do not draft outreach unless the user asks.

## Case 3: Email From Research

User says:

- "Write a cold email to their VP Sales."
- "Viet email tiep can cho cong ty nay."
- "Draft follow-up after no reply."

Action:

- Ensure company, recipient/persona, sales stage, and offer are known.
- If there is no prospect brief, generate a lightweight brief first.
- Output subject options, email, notes, and approval reminder.

## Case 4: Proposal

User says:

- "Create proposal for Acme."
- "Soan proposal."
- "Lam ban de xuat gui khach."

Action:

- Require offer, scope, pricing or budget range, and primary pain points.
- If pricing/scope is missing, produce a proposal skeleton plus questions.
- Do not invent pricing.

## Case 5: Next Step / Stalled Deal

User says:

- "They have not replied."
- "Deal nay dang stuck."
- "What should I do next?"

Action:

- Pull or request timeline.
- Classify deal state.
- Recommend one action, draft message, and fallback action.

## Case 6: Existing CRM Record

Signals:

- Company/contact already exists in CRM.
- Deal notes, meetings, calls, or previous email threads exist.

Action:

- Prioritize CRM relationship history.
- Use external research only to refresh context or find new triggers.
- Mention old commitments, objections, stakeholders, and stage.

## Case 7: Cold Prospect With No CRM Data

Signals:

- CRM has no account/contact/deal.
- User only gave company name.

Action:

- Use public research and ICP patterns.
- Output "cold prospect" status.
- Ask for product/offer before writing a ready-to-send email.

## Case 8: Multiple Companies

User gives a list of companies.

Action:

- Run a light scoring pass first.
- Rank by ICP fit and visible urgency.
- Ask the user whether to deep-dive the top 1-3 before generating long artifacts.

## Case 8A: Qualification Before Deep Work

User says:

- "Kiem tra co nen tiep can cong ty nay khong."
- "Cham diem prospect nay truoc."
- "Co dang de research/proposal khong?"

Action:

- Run a light ICP fit score first.
- Return `strong`, `possible`, `weak`, or `unknown` with reasons.
- For weak-fit accounts, recommend light research or skip before drafting long artifacts.
- Do not present the fit score as a sourced external fact.

## Case 9: Weak Or Missing Data

Signals:

- Website unavailable.
- No CRM.
- No contact found.
- Unknown pricing.

Action:

- Do not stop the whole workflow.
- Produce a lower-confidence brief or skeleton.
- Ask targeted questions for the missing pieces.

## Case 10: Write-Back Or Send Request

User says:

- "Log this to CRM."
- "Create follow-up task."
- "Send email."

Action:

- Summarize the exact action and content.
- Ask for explicit approval before any external write/send.
- After approval, perform only the approved action.

## Case 10A: Persist Product Context

User says:

- "Luu context san pham cua toi."
- "Thiet lap product context."
- "Ghi nho toi ban gi."

Action:

- Route to `skills/setup-product-context/SKILL.md`.
- Collect missing offer, ICP, pricing, proof, objection, and CTA details.
- Produce a ready-to-review replacement block for `knowledge/product-context-template.md`.
- Do not invent proof or overwrite files without explicit approval.

## Case 11: Raw Input / Paste And Go

User pastes:

- An email from a prospect.
- A LinkedIn profile snippet.
- A meeting note.
- A news article about a company.

Action:

- Extract company name, contact, context, and intent signal.
- Infer the most useful next output: brief, reply email, proposal follow-up, or next step.
- Ask one question only if company or offer is still unclear after extraction.
- Prefer continuing with a draft over pushing the user to name a skill or trigger.

## Case 12: Tracking Signal Next Step

User says:

- "Proposal da mo 4 lan nhung chua reply."
- "Email opened/clicked but no response."
- "Ho click pricing page roi im lang."

Action:

- Use the provided tracking signal explicitly.
- Recommend a specific timely follow-up tied to the signal.
- Do not overstate intent or say the buyer is ready to buy.
- If tracking is missing, use default follow-up timing and say the signal is unavailable.
