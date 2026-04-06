---
tags: [source-note, agent-config, schema]
last_updated: 2026-04-06
---

# Insight

Agent configuration files accumulate drift when rules are added ad-hoc without architectural review — causing inconsistent behavior across sessions that no single session can diagnose, because each session sees only the current state, not the history of contradictions that produced it.

CLAUDE.md is already subject to this: rules have been added reactively across sessions, and without a periodic lint cycle, accumulated contradictions will silently degrade Claude's behavior in this wiki before anyone notices.

## Contradicts

CLAUDE.md's own Evolution section says "update as workflows refine" — framed as append-only growth. Append-only growth without a refactor step is the definition of configuration drift.

# Connections

- [[Meta/LLM Wiki Pattern]]

<details>
<summary>Structure Notes</summary>

File taxonomy: AGENTS.md for operations/procedures (structured, imperative), SOUL.md for personality/tone (narrative), IDENTITY.md for core vibe (minimal, punchy), USER.md for user profile (factual bullets), TOOLS.md for local tools, MEMORY.md for long-term facts, HEARTBEAT.md for checklists. Workflow: identify target file by content type → check current state for size limits and duplication → draft changes following format guidelines. Best practices: 20K char limits, subagent visibility for AGENTS.md and TOOLS.md.

</details>
