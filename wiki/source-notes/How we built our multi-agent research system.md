---
tags: [source-summary, multi-agent, research-system]
last_updated: 2026-04-05
sources_count: 1
---

# How we built our multi-agent research system

## Overview
Anthropic's detailed post on building their multi-agent research system, covering architecture, prompt engineering, evaluation, and production challenges.

## Key Insights
- Benefits: Parallel compression for open-ended research, collective intelligence scaling.
- Architecture: Orchestrator-worker with lead agent spawning subagents for parallel exploration.
- Prompt principles: Delegate with detailed objectives, scale effort, tool design, extended thinking, parallel calling.
- Evaluation: Small samples, LLM-as-judge, human testing.
- Production: Stateful errors, observability, rainbow deployments, synchronous bottlenecks.

## Connections
- [[Synthesis/Multi-Agent Patterns]] - Core architecture and principles.
- [[Markets/AI Agents]] - Research applications.

## Actions
- Implement orchestrator-worker for research tasks.