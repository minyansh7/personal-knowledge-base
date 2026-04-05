---
tags: [source-summary, agent-config, skills]
last_updated: 2026-04-05
sources_count: 1
---

# Core Insight

LLM agents accumulate *configuration drift* — their context files (AGENTS.md, SOUL.md, etc.) diverge from intended behavior over time as ad-hoc instructions are added without architectural review, causing inconsistent behavior across sessions that no single session can diagnose.

## Why It Matters to Minyan

This wiki's CLAUDE.md is subject to the same drift problem. Every rule added in response to a specific failure — without checking for contradictions, redundancies, or scope creep — degrades the coherence of Claude's behavior in future sessions. The wiki has already had several rules added ad-hoc (synthesis depth rules, quality gate); without a lint cycle, these will eventually conflict.

## What Changes

CLAUDE.md needs a periodic *refactor cycle*, not just a growth cycle — checking for contradictions, redundancies, and ambiguities in accumulated rules, the same way production codebases need refactoring. Treat CLAUDE.md as a living codebase, not an append-only config.

## What It Contradicts

The current CLAUDE.md Evolution section says "update CLAUDE.md as workflows refine" — framed as append-only growth. This source implies that unchecked growth creates drift, and that a lint/refactor step is as important as adding new rules.

# Connections

- [[Markets/AI Agents]] - Agent configuration and building.
- [[Synthesis/Multi-Agent Patterns]] - Operational rules for multi-agent.
- [[Meta/LLM Wiki Pattern]] - CLAUDE.md as a configuration file subject to this exact drift problem.

# Actions

- Add a "CLAUDE.md lint" operation to the wiki's Lint workflow — check for contradictions, redundancies, and ambiguous rules, not just content gaps.
- Schedule a CLAUDE.md refactor after every 5-10 new rules are added.

<details>
<summary>Structure Notes</summary>

OpenClaw skill for modifying agent context files. File taxonomy: AGENTS.md for operations/procedures (structured, imperative), SOUL.md for personality/tone (narrative), IDENTITY.md for core vibe (minimal, punchy), USER.md for user profile (factual bullets), TOOLS.md for local tools, MEMORY.md for long-term facts, HEARTBEAT.md for checklists. Workflow: identify target file by content type → check current state (size limits, duplication) → draft changes following format guidelines. Best practices: 20K char limits, subagent visibility for AGENTS.md + TOOLS.md.

</details>
