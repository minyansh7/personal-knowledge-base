---
tags: [source-note, ai, agents, trust]
last_updated: 2026-04-06
---

# Insight

Agent deployment fails not because AI can't do the task but because organizations can't trust it to — and trust calibration is a product design problem, not a technical one.

For any agent product Minyan builds, the moat is the audit trail, escalation path, and rollback trigger — not the model or the prompt.

## Contradicts

The common framing of agent opportunity as capability-led — "agents work where rules-based systems fail" — inverts the actual bottleneck. The barrier is organizational trust, which is neither a model problem nor a prompt problem.

# Connections

- [[Findings/Multi-Agent Systems]]
- [[source-notes/Agent Development Kit (ADK)]]

<details>
<summary>Structure Notes</summary>

Core components: model, tools, instructions. Orchestration patterns: manager (central agent via tool calls), decentralized (peer handoffs). Guardrail types: relevance classifiers, safety classifiers, PII filters, moderation, tool safeguards, output validation. Market applications: ecommerce (refund approvals, vendor reviews, order management), health (insurance claims, patient triage).

</details>
