---
tags: [source-note, ai, agents, multi-agent]
last_updated: 2026-04-06
---

# Insight

Multi-agent demos almost universally use research tasks because write-task coordination failures — conflicting outputs, merge complexity, shared state conflicts — are invisible in demos, making the field's apparent progress systematically benchmarked on the easy half of the problem.

When Minyan evaluates any multi-agent opportunity, read/write ratio is the first filter — not total task complexity, not domain, not model capability.

## Contradicts

[[Findings/Multi-Agent Systems]] lists breadth-first queries and parallelizable subtasks as the primary "when to use" criteria. Read/write ratio is the more predictive filter and should precede those criteria — high write-proportion disqualifies regardless of parallelizability.

# Connections

- [[Findings/Multi-Agent Systems]]

<details>
<summary>Structure Notes</summary>

LangChain synthesis drawing on Cognition and Anthropic research. Key claims: context engineering is the primary determinant of multi-agent reliability; read tasks (research, retrieval, analysis) suit multi-agent better than write tasks (coding, drafting, editing) due to coordination overhead; production challenges include durable execution, error handling, debugging/observability, and LLM-as-judge evaluation.

</details>
