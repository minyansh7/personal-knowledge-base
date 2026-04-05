---
tags: [source-summary, context-engineering, ai-agents]
last_updated: 2026-04-05
sources_count: 1
---

# Effective context engineering for AI agents

## Overview
Anthropic's guide on context engineering for AI agents, distinguishing it from prompt engineering and providing strategies for managing context in agentic systems.

## Key Insights
- Context engineering optimizes token utility in LLMs for desired behaviors, considering holistic state and constraints.
- Essential due to attention budget and context rot; requires minimal high-signal tokens.
- System prompts: Clear, direct, balanced altitude; organized sections.
- Tools: Efficient, self-contained, unambiguous.
- Examples: Diverse, canonical few-shot prompting.
- Just-in-time retrieval: Dynamic loading via tools, progressive disclosure.
- Long-horizon tasks: Compaction (summarize history), structured note-taking, multi-agent architectures.

## Connections
- [[Markets/AI Agents]] - Core agent building strategies.
- [[Synthesis/Multi-Agent Patterns]] - Long-horizon and multi-agent techniques.

## Actions
- Implement compaction in agent workflows for context management.