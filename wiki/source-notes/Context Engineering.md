---
tags: [source, ai, agents, context]
last_updated: 2026-04-05
sources_count: 1
---

# Core Insight

Multi-agent orchestration is fundamentally an *information routing problem*, not a task delegation problem — the bottleneck isn't which agent does what but what context flows between them, in what form, at what point in the workflow.

## Why It Matters to Minyan

Designing a multi-agent product means designing the inter-agent context handoff schema before designing the agents themselves. Production failures in multi-agent systems are almost always information failures at handoffs — missing context, malformed state, truncated history — not reasoning failures within individual agents.

## What Changes

When evaluating or building multi-agent architectures, ask "what is the context contract between agents?" before "how are tasks divided?" The former determines reliability; the latter is implementation detail.

## What It Contradicts

[[Synthesis/Multi-Agent Patterns]] frames orchestration as task division and pattern selection (manager vs. decentralized). This source says the real architectural decision is the information contract, which is orthogonal to the org-chart framing and more predictive of production success.

# Connections

- [[Markets/AI Agents]] - Optimization techniques.
- [[Synthesis/Multi-Agent Patterns]] - Context integration.
- [[source-notes/Agent Development Kit (ADK)]] - Framework for implementing multi-agent systems.

# Actions

- In any multi-agent design, specify inter-agent context contracts (what is passed, what is compressed, what is discarded) before writing agent prompts.

<details>
<summary>Structure Notes</summary>

LangChain's framework defines four context operations: write (generate new context for downstream agents), select (retrieve relevant data from memory/tools), compress (summarize to fit context windows), isolate (separate concerns across agents or subagents). Presented as the core engineering discipline for multi-agent reliability.

</details>
