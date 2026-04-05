---
tags: [synthesis, ai, agents, patterns]
last_updated: 2026-04-05
sources_count: 4
---

# Overview

Multi-agent patterns enable collaborative AI systems, distributing workflows across specialized agents. This synthesis connects manager and decentralized approaches for scalable, team-like operations, emphasizing context engineering for reliability and orchestrator-worker architectures for research tasks.

# Key Insights

- **Manager Pattern**: Central agent coordinates specialized agents via tool calls, maintaining unified control. Ideal for ecommerce (order management, support) and health (triage, claims).
- **Decentralized Pattern**: Peer handoffs allow agents to delegate tasks, suitable for complex collaborations without central oversight.
- **Collaboration Benefits**: Mimics team dynamics, improving performance in ambiguous workflows. Guardrails ensure safe interactions.
- **Context Strategies in Orchestration**: Use write (generate context), select (relevant data), compress (summarize), and isolate (separate concerns) to optimize context windows in multi-agent systems, ensuring efficient information flow and decision-making.
- **Context Engineering Critical**: Essential for communicating task context to sub-agents; vague instructions lead to duplication or gaps.
- **Read vs. Write Tasks**: Multi-agent systems excel at parallelizable "read" tasks (e.g., research); "write" tasks (e.g., coding) harder due to conflicting decisions and merging challenges.
- **Production Challenges**: Require durable execution for long-running stateful processes, robust error handling, debugging with observability tools, and evaluation using small datasets with LLM-as-judge.
- **When to Use**: Breadth-first queries, tasks exceeding single-agent context limits, high-value domains with parallelizable subtasks; avoid domains with heavy inter-agent dependencies.
- **Orchestrator-Worker Architecture**: Lead agent plans and spawns subagents for parallel exploration; subagents use tools iteratively, return findings for synthesis.
- **Prompt Engineering Principles**: Teach delegation with detailed objectives; scale effort to complexity; design tools with clear descriptions; use extended thinking for planning; parallel tool calling for speed.
- **Evaluation Methods**: Start with small samples; use LLM-as-judge for factual accuracy, completeness; combine with human testing for edge cases.

# Connections

- [[Markets/AI Agents]] - Market fit and research applications.
- [[Ideas/AI Ventures]] - Venture potential.
- [[Opportunities/AI Agent Deployments]] - Deployment opportunities.

# Actions

- Design manager-pattern agents for ecommerce workflows.
- Implement decentralized handoffs for health triage.
- Evaluate multi-agent for research vs. coding tasks.
- Apply orchestrator-worker for parallel research tasks.