---
tags: [source-note, ai, agents, context]
last_updated: 2026-04-06
---

# Insight

Multi-agent systems don't fail because individual agents reason poorly — they fail at handoffs, where context is missing, malformed, or truncated, which is an information architecture problem that precedes all agent logic.

Before Minyan writes a single agent prompt in any multi-agent design, the inter-agent context contract — what passes, what compresses, what drops — must be specified first.

## Contradicts

The common framing of multi-agent design as task division (who does what) is downstream of the real architectural decision: what information flows between agents and in what form. [[Findings/Multi-Agent Systems]] addresses the task-division question; this source says that question is secondary.

# Connections

- [[Findings/Context Engineering]]
- [[Findings/Multi-Agent Systems]]

<details>
<summary>Structure Notes</summary>

Four context operations: write (generate new context for downstream agents), select (retrieve relevant data), compress (summarize to fit context windows), isolate (separate concerns across agents). Presented as the core engineering discipline for multi-agent reliability.

</details>
