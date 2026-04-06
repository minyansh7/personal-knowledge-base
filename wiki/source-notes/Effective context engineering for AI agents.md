---
tags: [source-note, ai, agents, context]
last_updated: 2026-04-06
---

# Insight

More context is not better context — accumulated conversation history actively degrades LLM attention quality past a threshold, meaning long-running agents need explicit forgetting strategies, not richer retrieval.

This wiki's index.md and log.md are not navigation aids — they are the compaction layer that prevents context rot from accumulating across Minyan's ingest sessions.

## Contradicts

The widespread assumption that "full context = best results" is directly inverted: Anthropic finds that accumulated context degrades attention quality. Most RAG and retrieval architectures optimize for adding more context; the correct optimization is disciplined removal.

# Connections

- [[Findings/Context Engineering]]
- [[Meta/LLM Wiki Pattern]]

<details>
<summary>Structure Notes</summary>

Distinguishes context engineering from prompt engineering: context engineering manages holistic state, not just instructions. Covers: system prompt design (clear altitude, organized sections), tool design (efficient, self-contained, unambiguous), few-shot examples (diverse, canonical), just-in-time retrieval (dynamic loading via tools, progressive disclosure), long-horizon techniques (compaction via summarization, structured note-taking, multi-agent architectures to distribute context load).

</details>
