---
tags: [source-summary, multi-agent, context-engineering]
last_updated: 2026-04-05
sources_count: 1
---

# Core Insight

Multi-agent demos almost universally use research/retrieval tasks because the failure mode of write-task coordination (conflicting edits, merge complexity) is invisible in demos — meaning the field's apparent progress on multi-agent systems is largely benchmarked on the easy half of the problem.

## Why It Matters to Minyan

When evaluating agent business opportunities, build complexity scales with write-task proportion, not total task complexity. A multi-agent research system is structurally simpler than a multi-agent coding or content system, even if the research task is more intellectually demanding. This asymmetry is systematically underestimated.

## What Changes

Use read/write ratio as a first-pass filter for multi-agent opportunity assessment. High read-to-write ratio → faster path to production, lower coordination overhead. Write-heavy tasks → budget 3× the infrastructure time for conflict resolution, state management, and merge logic.

## What It Contradicts

[[Synthesis/Multi-Agent Patterns]] lists "when to use" criteria (breadth-first queries, parallelizable subtasks) but doesn't surface the read/write asymmetry as the primary filter. The current framing buries the most predictive variable.

# Connections

- [[Synthesis/Multi-Agent Patterns]] - Core patterns and when to use.
- [[Markets/AI Agents]] - Agent building challenges.

# Actions

- Add read/write ratio as a primary evaluation criterion in the Opportunities template or CLAUDE.md.
- Before committing to any multi-agent architecture, explicitly classify the task breakdown by read vs. write proportion.

<details>
<summary>Structure Notes</summary>

LangChain synthesis drawing on Cognition and Anthropic research. Key claims: context engineering is the primary determinant of multi-agent reliability (vague instructions cause duplication/gaps); read tasks (research, retrieval, analysis) are more suitable for multi-agent than write tasks (coding, drafting, editing) due to coordination overhead; production challenges include durable execution for long-running stateful processes, error handling, debugging/observability, and evaluation using LLM-as-judge. Best fit: breadth-first queries, high-value domains, parallelizable subtasks. Avoid: tight inter-agent dependencies.

</details>
