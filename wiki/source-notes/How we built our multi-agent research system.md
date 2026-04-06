---
tags: [source-note, ai, agents, production]
last_updated: 2026-04-06
---

# Insight

The dominant engineering challenge Anthropic hit building their research system wasn't AI — it was stateful error recovery when subagents fail mid-task, which is a distributed systems problem with no LLM-specific solution.

For Minyan, this means the durable competitive surface in agent infrastructure is fault tolerance, observability, and checkpointing — not model quality or prompt sophistication — because those are what enterprise buyers encounter in production and cannot easily replicate.

## Contradicts

The framing of agent competition as capability-led (better models, better prompts) is inverted here: Anthropic's production experience shows the hard problems are operational, not intellectual. This aligns with [[source-notes/A practical guide to building agents]] on trust infrastructure as the real moat.

# Connections

- [[Findings/Multi-Agent Systems]]
- [[Findings/Context Engineering]]

<details>
<summary>Structure Notes</summary>

Architecture: orchestrator-worker (lead agent plans and spawns subagents for parallel exploration; subagents use tools iteratively and return findings). Prompt principles: delegate with detailed objectives, scale effort to complexity, design tools with clear descriptions, extended thinking for planning, parallel tool calling for speed. Evaluation: small samples, LLM-as-judge for factual accuracy and completeness, human testing for edge cases. Production challenges: stateful errors, observability gaps, rainbow deployments for zero-downtime updates, synchronous bottlenecks.

</details>
