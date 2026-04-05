---
tags: [source-summary, context-engineering, ai-agents]
last_updated: 2026-04-05
sources_count: 1
---

# Core Insight

"Context rot" — Anthropic's term for accumulated conversation history that actively degrades agent performance over time — means long-running agents need explicit *forgetting strategies*, not just retrieval strategies; more context is not better context.

## Why It Matters to Minyan

This wiki's LLM maintenance workflow is a long-running agent use case. Every ingest session that carries over raw prior conversation is accumulating rot. The right design isn't giving Claude full history — it's compacting history into structured notes (index, log, source notes) before each session, which is already what the wiki schema does.

## What Changes

Design every long-horizon agent workflow with a compaction step as a first-class operation from the start, not as an optimization to add when performance degrades. The compaction architecture should be specified before the agent logic.

## What It Contradicts

The common assumption that "full context = best results" is directly contradicted: Anthropic finds that accumulated context actively degrades attention quality past a threshold. The wiki's own architecture (index.md + log.md as compressed state) is the correct response — but this justification is missing from CLAUDE.md.

# Connections

- [[Markets/AI Agents]] - Core agent building strategies.
- [[Synthesis/Multi-Agent Patterns]] - Long-horizon and multi-agent techniques.
- [[Meta/LLM Wiki Pattern]] - This wiki's compaction architecture directly implements these principles.

# Actions

- Add a note to CLAUDE.md explaining why index.md and log.md exist as compressed state (context rot prevention), so future sessions understand the design intent.
- When building any agent product with sessions longer than ~10 turns, spec the compaction strategy before the agent prompts.

<details>
<summary>Structure Notes</summary>

Anthropic distinguishes context engineering from prompt engineering: context engineering is about holistic state management, not just instruction writing. Covers: system prompt design (clear altitude, organized sections), tool design (efficient, self-contained, unambiguous), few-shot examples (diverse, canonical), just-in-time retrieval (dynamic loading via tools, progressive disclosure), and long-horizon techniques (compaction via summarization, structured note-taking, multi-agent architectures to distribute context load).

</details>
