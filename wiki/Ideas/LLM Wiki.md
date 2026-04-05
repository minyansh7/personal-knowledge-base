---
tags: [ideas, llm, wiki, knowledge-base]
last_updated: 2026-04-05
sources_count: 1
---

# Overview

LLM Wiki is a pattern for building personal knowledge bases using LLMs, where the LLM maintains a persistent, interlinked wiki that compounds knowledge through incremental ingestion and synthesis, rather than rediscovering insights on every query.

# Key Insights

- **Three-Layer Architecture**: Raw immutable sources, LLM-maintained wiki pages, and a schema configuration that guides LLM behavior for disciplined maintenance.
- **Operations**: Ingest (integrate new sources into wiki), Query (synthesize answers from wiki with citations), Lint (health-check for contradictions and gaps).
- **Indexing and Logging**: index.md for navigation, log.md for chronological history; enables efficient wiki management without complex RAG infrastructure.
- **Optional Tools**: CLI search like qmd for growing wikis; Obsidian for visualization and image handling.
- **Tips**: Use Obsidian Web Clipper for sources, download images locally, leverage git for versioning, Dataview for dynamic queries.
- **Why It Works**: LLMs handle maintenance burden (cross-references, consistency) that humans avoid; humans focus on curation and questions.
- **Relation to Memex**: Echoes Vannevar Bush's vision of associative knowledge trails, with LLMs solving the maintenance problem.

# Connections

- [[Markets/AI Agents]] - Leverages LLMs for agent-based knowledge management.
- [[Opportunities/AI Agent Deployments]] - Potential for enterprise wiki deployments.
- [[Synthesis/Multi-Agent Patterns]] - Could incorporate multi-agent for wiki maintenance.

# Actions

- Explore implementing qmd search for larger wiki scale.
- Test Dataview queries on frontmatter for dynamic insights.
- Consider business applications for team wikis maintained by LLMs.