---
tags: [source-note, llm, wiki, pattern]
last_updated: 2026-04-05
sources_count: 1
---

# Core Insight

Personal knowledge management systems fail — Roam, Notion, Obsidian — not because of poor tooling but because maintenance overhead grows faster than compounding value, and the LLM Wiki pattern only breaks this curve if the user genuinely transfers the bookkeeping to the LLM rather than manually correcting its decisions.

## Why It Matters to Minyan

You're already running this wiki. The failure mode isn't technical — it's behavioral. Every manual file move or categorization correction that doesn't result in a CLAUDE.md update is doing wiki maintenance yourself, which is the pattern this is designed to escape.

## What Changes

Treat every manual correction as a CLAUDE.md bug, not a one-time fix. Moving a file (LLM Wiki from Ideas to Meta) means the categorization rules were ambiguous — update CLAUDE.md so the LLM gets it right next time. If corrections to Claude's decisions aren't being written back into the schema, the compounding mechanism is broken.

## What It Contradicts

Nothing in the existing wiki explicitly — but the current CLAUDE.md categorization rules are loose enough that misfilings will recur. The schema says "use descriptive, hierarchical paths" without giving enough signal for borderline cases (architectural docs vs. ideas vs. meta).

# Connections

- [[Meta/LLM Wiki Pattern]] - Main wiki page for this pattern.
- [[source-notes/skills skills thatguysizemore agent-config SKILL.md at main]] - Configuration drift is the same problem applied to CLAUDE.md.

# Actions

- After any manual correction to Claude's filing decisions, update CLAUDE.md with the rule that would have prevented it.
- Add a borderline-case categorization guide to CLAUDE.md (e.g., what distinguishes Meta from Ideas from Projects).

<details>
<summary>Structure Notes</summary>

Three-layer architecture: raw immutable sources, LLM-maintained wiki (markdown files with cross-references), schema document (CLAUDE.md/AGENTS.md) guiding LLM behavior. Three operations: ingest (add new source → update wiki), query (ask questions → synthesize from wiki → file valuable answers back), lint (health-check for contradictions, orphans, stale claims). Two navigation files: index.md (content catalog) and log.md (chronological append-only record). Optional tools: qmd for wiki search (BM25/vector hybrid), Obsidian for visualization, git for versioning. Obsidian Web Clipper for web-to-markdown sourcing.

</details>
