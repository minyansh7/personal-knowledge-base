---
tags: [findings, ai, agents, multi-agent]
last_updated: 2026-04-06
sources_count: 4
---

# Core Finding

The decision to go multi-agent is not primarily a capability decision — it is a coordination cost decision. Every source in this wiki approaches this from a different angle without stating it directly: the reason most multi-agent systems fail in production isn't that the agents reason poorly — it's that the cost of coordinating them exceeds the value of parallelizing them, and this calculation is almost never done upfront.

Read-heavy tasks (research, retrieval, analysis) have low coordination cost because outputs are independent — agents can work in parallel without negotiating shared state. Write-heavy tasks (coding, drafting, editing) have high coordination cost because outputs must be merged, and conflicting decisions compound. This asymmetry is systematically hidden in demos, which almost universally use research tasks. The field's apparent progress on multi-agent systems is benchmarked on the easy half of the problem.

## What This Changes

The right first question when considering a multi-agent design is not "can I break this into parallel tasks?" It is "what is the coordination overhead when those tasks produce conflicting outputs, and does the parallelization gain still exceed it?" For write-heavy work, the answer is almost always no — until someone specifically solves the merge problem.

## Business Note

The companies positioned to win in multi-agent infrastructure are those reducing coordination cost, not those with the best individual agents. Coordination tooling — conflict resolution, state management, merge logic — is currently undersupplied. That is a specific, non-obvious competitive surface.

# Connections

- [[Findings/Context Engineering]] — The coordination cost calculation depends on how well context contracts between agents are specified. Cheap, clear contracts reduce coordination cost. Vague ones multiply it.
- [[source-notes/How and when to build multi-agent systems]] — Read/write asymmetry and production challenge evidence.
- [[source-notes/How we built our multi-agent research system]] — Stateful error recovery as the dominant production challenge.
- [[source-notes/A practical guide to building agents]] — Trust gap as the deployment bottleneck upstream of coordination.

<details>
<summary>Structure Notes</summary>

Orchestration patterns: manager (central agent coordinates via tool calls, unified control), decentralized (peer-to-peer handoffs, no central oversight), orchestrator-worker (lead agent spawns subagents for parallel exploration). When to use: breadth-first queries, tasks exceeding single-agent context limits, high-value parallelizable subtasks. Avoid: heavy inter-agent dependencies, write-heavy tasks requiring output merging. Evaluation: small samples, LLM-as-judge for accuracy and completeness, human testing for edge cases.

</details>
