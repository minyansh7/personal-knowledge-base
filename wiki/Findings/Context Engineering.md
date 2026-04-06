---
tags: [findings, ai, agents, context]
last_updated: 2026-04-06
sources_count: 4
---

# Core Finding

Context is not the input to an agent — it is the ongoing environment the agent reasons within, and it degrades over time whether you act on it or not. This reframes context engineering from a setup problem (write a good system prompt) to a maintenance problem (actively manage what accumulates, what gets compressed, what gets dropped).

The implication most practitioners miss: more context is not better context. Anthropic's research shows that accumulated history actively degrades attention quality past a threshold — "context rot." The correct architecture is not richer retrieval; it is disciplined forgetting. Long-running agents need explicit compaction strategies from day one, not as a performance optimization added later.

The same principle applies at the inter-agent boundary. Production failures in multi-agent systems are almost always information failures at handoffs — missing context, malformed state, truncated history — not reasoning failures within individual agents. The context contract between agents (what is passed, what is compressed, what is discarded) is the primary architectural decision. It determines reliability more than task division does.

## What This Changes

Design any long-horizon or multi-agent workflow by specifying the compaction strategy and inter-agent context contracts *before* writing agent logic. The information architecture determines whether the system holds together in production. The agent prompts are secondary.

## Business Note

The production reliability moat in agent products is infrastructure that manages context degradation automatically — not better models, not better prompts. This is currently undersupplied. The companies building durable agent products are investing in fault tolerance, observability, and context lifecycle management before optimizing capability.

# Connections

- [[Findings/Multi-Agent Systems]] — Coordination cost in multi-agent systems is directly proportional to how poorly context contracts are specified at handoffs.
- [[source-notes/Effective context engineering for AI agents]] — Context rot, compaction architecture, and the case for forgetting strategies.
- [[source-notes/Context Engineering]] — Inter-agent context contracts as the primary reliability determinant.
- [[source-notes/How we built our multi-agent research system]] — Stateful error recovery as the production challenge that context architecture must address.
- [[Meta/LLM Wiki Pattern]] — This wiki's index.md and log.md are a direct implementation of compaction: compressed state rather than full history carried into each session.

<details>
<summary>Structure Notes</summary>

Four context operations: write (generate new context for downstream agents), select (retrieve relevant data from memory or tools), compress (summarize to fit context windows), isolate (separate concerns across agents). System prompt design principles: clear altitude, organized sections, minimal but sufficient. Tool design: efficient, self-contained, unambiguous. Just-in-time retrieval: dynamic loading via tools, progressive disclosure, hybrid retrieval strategies. Long-horizon techniques: compaction via summarization, structured note-taking, multi-agent architectures to distribute context load.

</details>
