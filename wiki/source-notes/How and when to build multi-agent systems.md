---
tags: [source-summary, multi-agent, context-engineering]
last_updated: 2026-04-05
sources_count: 1
---

# How and when to build multi-agent systems

## Overview
LangChain blog post synthesizing insights from Cognition and Anthropic on multi-agent systems, focusing on context engineering, read vs. write tasks, and production challenges.

## Key Insights
- Context engineering crucial for multi-agent reliability; vague instructions cause duplication/gaps.
- Multi-agent easier for parallelizable "read" tasks (e.g., research) than "write" tasks (e.g., coding) due to conflicting decisions.
- Production challenges: Durable execution, error handling, debugging/observability, evaluation with LLM-as-judge.
- Best for breadth-first queries, parallelizable tasks, high-value domains; avoid heavy inter-dependencies.

## Connections
- [[Synthesis/Multi-Agent Patterns]] - Core patterns and when to use.
- [[Markets/AI Agents]] - Agent building challenges.

## Actions
- Assess tasks for multi-agent suitability based on read/write balance.