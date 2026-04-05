# Source Ingestor Skill

## Description
This skill handles the ingestion of new source documents into Minyan's Wiki, following a proven workflow that maintains wiki coherence, avoids duplicates, and compounds knowledge through synthesis. It is based on successful ingests of AI agent-related sources, ensuring single-topic focus, appropriate page updates, and proper logging.

## Workflow Steps
1. **Read the source fully**: Read the entire source file from `/raw/articles/` to extract key information, themes, and insights.
2. **Extract key information**: Identify main ideas, actionable insights, and connections to existing wiki content. Focus on single-topic sources to update only 1-2 relevant wiki pages.
3. **Read existing relevant wiki pages**: Before editing, read pages like `wiki/Markets/AI Agents.md` or `wiki/Synthesis/Multi-Agent Patterns.md` to understand current content and avoid duplication.
4. **Determine update vs. new page**: Prefer updating existing pages (e.g., add bullets under Key Insights) over creating duplicates. Only create new pages if no relevant existing page fits.
5. **Update/create wiki page**: Integrate insights by adding 1-2 bullets under relevant sections (e.g., Key Insights). Update frontmatter: increment `sources_count`, set `last_updated` to current date. Maintain sections: # Overview, # Key Insights, # Connections, # Actions.
6. **Create source summary**: Create a new file in `wiki/source-notes/` with frontmatter, # Overview, # Key Insights, # Connections, # Actions. Keep concise, link to main wiki pages.
7. **Update index.md**: Revise summaries for updated pages to include new keywords (1-2 sentences). Add new entries for source notes under Source Notes table.
8. **Append to log.md**: Add entry in format `## [YYYY-MM-DD] ingest | Source Title`.
9. **Commit changes**: Use `git add . && git commit -m "Ingest: Source Title - description"`.
10. **Report files touched**: List all files read, updated, or created.

## Rules
- **Read existing relevant wiki pages before editing**: Always check current state to integrate seamlessly.
- **Prefer updating existing pages over creating duplicates**: Merge insights into existing structures; avoid fragmentation.
- **Raw source files and assets files are immutable**: Never modify `/raw/` or `/assets/`; they are sources of truth.

## Files Typically Touched
- Read: `/raw/articles/Source.md`
- Updated: `wiki/Markets/AI Agents.md` (or similar)
- Created: `wiki/source-notes/Source.md`
- Updated: `index.md`
- Updated: `log.md`

## Index.md Update Guidelines
- For updated pages: Revise Summary column to incorporate new keywords/concepts, keeping 1-2 sentences.
- For new source notes: Add row under Source Notes: | Source Title | Concise summary | YYYY-MM-DD |

## Log.md Entry Format
## [YYYY-MM-DD] ingest | Source Title

## Proven Effectiveness
This workflow has successfully ingested sources like "A practical guide to building agents", "Agent Development Kit (ADK)", and "Context Engineering", updating `Markets/AI Agents.md` with agent concepts, frameworks, and context strategies, while maintaining coherence and cross-links.