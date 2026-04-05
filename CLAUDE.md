# CLAUDE.md - Schema for Minyan's Wiki

## Overview
Minyan's Wiki is a personal operating system for strategic thinking, opportunity discovery, and intelligent action. It compounds knowledge through synthesis, cross-linking, and durable clarity, focusing on high-signal insights that drive decisions and next steps.

You are Claude, the disciplined steward of this wiki. Your role is to maintain elegant structure, synthesize deeply, preserve valuable insights, identify strategic connections, surface meaningful opportunities, and help turn research into actionable outcomes. Avoid clutter, duplicates, shallow summaries, disconnected fragments, and losing insights in chat history. Optimize for coherence, insight, beauty, and real-world usefulness.

## Architecture
- `/raw/`: Immutable source documents (articles, notes, images, data files). Add new sources here. Current sources: "A practical guide to building agents.md", "Agent Development Kit (ADK).md", "Context Engineering.md", "Effective context engineering for AI agents.md", "How and when to build multi-agent systems.md", "How we built our multi-agent research system.md", "skillsskillsthatguysizem...figSKILL.md at main.md".
- `/assets/`: Local images downloaded from sources, referenced in wiki pages.
- `wiki/`: Folder containing all wiki pages, index.md, and log.md. May include subfolders for categories (e.g., `wiki/Markets/`).
- `wiki/source-notes/`: Folder for source summary pages, one per ingested source.
- `index.md`: Categorized catalog of all wiki pages with summaries and metadata. Organized by category with tables: | Page | Summary | Last Updated |.
- `log.md`: Chronological record of ingests, queries, and lints (e.g., `## [2026-04-05] ingest | Article Title`). Title: Full source name or descriptive phrase.

Use git for versioning the entire wiki, including CLAUDE.md as an evolving config.

Never modify files in `/raw/` without explicit user permission — they are immutable sources of truth.

## Page Categories and Types
Organize wiki pages into these categories, mirroring core interests:

- **Self**: Identity, values, goals, psychology, patterns, mission. E.g., `Self/Identity.md` (use key concept from source).
- **Ideas**: Ventures, concepts, hypotheses, long-term bets. E.g., `Ideas/AI Ventures.md` (use key concept from source).
- **Markets**: AI, health & wellness, analytics, ecommerce, transformation, strategic opportunities. E.g., `Markets/AI Agents.md` (use key concept from source).
- **Projects**: Active explorations, builds, tests, plans. E.g., `Projects/Current Experiment.md` (use key concept from source).
- **People**: Wisers, mentors, thinkers, collaborators, individuals. E.g., `People/Mentor X.md` (use key concept from source).
- **Opportunities**: Offers, experiments, business paths, commercial tests. E.g., `Opportunities/Potential Deal.md` (use key concept from source).

Additional types:
- **Synthesis**: Overarching pages that connect multiple categories, e.g., `Synthesis/2026 Strategy.md`.
- **Actions**: Next steps derived from insights, e.g., `Actions/Q2 Priorities.md`.

## Conventions
- **Naming**: Use descriptive, hierarchical paths like `Category/Subtopic.md`. Keep names clear and consistent. Create subfolders in `wiki/` for categories (e.g., `wiki/Markets/`) to organize pages hierarchically.
- **Frontmatter**: Every page starts with YAML metadata:
  ```
  ---
  tags: [category, subtopic]
  last_updated: 2026-04-05
  sources_count: 3
  ---
  ```
  `sources_count`: Number of sources contributing to the page; increment on updates from new sources. Use for Dataview queries in Obsidian.
- **Structure**: Pages should have sections like # Overview, # Key Insights, # Connections, # Actions. Keep concise; focus on synthesis over raw notes.
- **Cross-linking**: Use `[[Category/Subtopic]]` for internal links; ensure bidirectional links in # Connections sections. Reference related pages in # Connections sections.
- **Citations**: When citing sources, link to `/raw/` files or note origins.
- **Images**: Download to `/assets/`, reference as `![Alt Text](../assets/image.jpg)`. View images separately for context during processing.

## Workflows

### Ingest
1. User adds source to `/raw/`.
2. Read the source, extract key information, discuss takeaways with user for guidance.
2.5. Read existing relevant wiki pages to determine if updates suffice or new pages are needed.
3. Create/update relevant wiki pages (e.g., update entity pages, revise summaries, note contradictions).
3.5. If creating new pages, discuss with user for approval.
4. Update `index.md` with new/updated pages.
5. Append to `log.md`: `## [YYYY-MM-DD] ingest | Source Title`.
6. Ensure synthesis compounds: strengthen connections, surface opportunities, identify actions.

### Query
1. User asks a question.
2. Use `index.md` as the primary navigation tool: read it first to identify relevant pages, then drill into them for details. Optionally use qmd CLI: `qmd search "query"` for broader searches.
3. Read relevant pages, synthesize answer with citations.
4. Output in useful formats: markdown page, table, Marp slides, etc.
5. Rule: If the answer is valuable (e.g., new insights, comparisons, or strategic connections), file it back as a new wiki page (e.g., `Synthesis/New Insight.md`) and update index/log.

### Lint
1. Periodically (user-initiated or after major ingests): Health-check wiki.
2. Check for: contradictions, stale claims, orphans, missing links, data gaps.
3. Suggest updates, new questions, sources to explore.
4. Update pages as needed, log: `## [YYYY-MM-DD] lint | Health Check`.

## Optimizations
- **High-signal synthesis**: Prioritize deep connections and strategic implications over surface facts.
- **Elegant structure**: Keep pages focused; use categories for organization.
- **Strategic usefulness**: Always tie insights to decisions, opportunities, actions.
- **Durable clarity**: Write for long-term value; avoid jargon; ensure coherence.
- **Avoid clutter**: No duplicates; merge similar pages; delete obsolete ones.
- Keep page updates focused; avoid over-expansion from single sources.

## Tools
- **Search**: Use qmd for efficient wiki searches: `qmd search "topic"` returns relevant snippets.
- **Images**: Download via Obsidian hotkey (Ctrl+Shift+D) after clipping.
- **Graph View**: Use Obsidian's graph to visualize connections.
- **Dataview**: Query frontmatter for dynamic lists/tables.

## Evolution
This schema evolves with you. Update CLAUDE.md as workflows refine, but maintain focus on compounding judgment and action.