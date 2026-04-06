---
tags: [meta, llm, wiki, architecture, knowledge-base]
last_updated: 2026-04-05
sources_count: 1
---

# Overview

This wiki is a persistent, compounding knowledge base maintained entirely by Claude. You add sources and ask questions. Claude handles all the filing, cross-referencing, and synthesis. The wiki gets richer with every source ingested and every query answered — nothing is rediscovered from scratch.

It works because LLMs don't get bored, don't forget to update a cross-reference, and can touch 15 files in one pass. The maintenance cost is near zero. Your job is curation and questions; Claude's job is everything else.

# How It Works

Three layers:
- **`/raw/`** — your source documents. Immutable. Claude reads, never modifies.
- **`wiki/`** — everything Claude writes and maintains. Pages, synthesis, index, log.
- **`CLAUDE.md`** — the schema that makes Claude a disciplined maintainer, not a generic chatbot.

Three operations:
- **Ingest** — drop a source in `/raw/`, Claude processes and files it silently, then reports.
- **Query** — ask a question, Claude synthesizes from the wiki with citations. Valuable answers get filed back as new pages.
- **Lint** — periodic health check for contradictions, orphans, stale claims, missing links.

# Minyan's Preferences

- **Silent ingests**: no discussion, no check-ins, no confirmation before writing. Process the source, file the pages, report what was done.
- Every manual correction to Claude's filing is a CLAUDE.md bug — update the schema so it doesn't recur.

# Connections

- [[AI Agents]] - LLM agent patterns underlying this architecture.
- [[Multi-Agent Patterns]] - Could extend to multi-agent wiki maintenance.
- [[Actions/Q2 2026]] - Current next steps include feeding personal content and linting CLAUDE.md.
