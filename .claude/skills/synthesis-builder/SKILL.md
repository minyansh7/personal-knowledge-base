# Synthesis Builder Skill

## Description
This skill creates evidence-based synthesis pages when three or more ingested sources clearly relate to the same theme. It is designed to work after the ingestor has been created and tested, using the same wiki structure and source-note workflow already proven in this project.

## Workflow Steps
1. **Identify a theme with 3+ ingested sources**: Find a theme reflected by at least three source notes in `wiki/source-notes/` that clearly overlap on the same topic.
2. **Read all relevant source notes**: Read the full contents of each relevant source note to capture cross-source patterns, contradictions, and shared terminology.
3. **Read related existing wiki pages**: Read the current page(s) in the relevant category, especially `wiki/Markets/AI Agents.md`, `wiki/Synthesis/Multi-Agent Patterns.md`, and any related idea or opportunity pages.
4. **Identify the strongest cross-source insight**: Determine the insight that only emerges when the sources are combined, not from any single source alone. This should be a clear, actionable theme or strategic principle.
5. **Draft a synthesis page**: Create a new page in `wiki/Synthesis/` with sections: # Overview, # Key Insights, # Connections, # Actions. Keep it grounded, non-redundant, and evidence-based.
6. **Document source and page provenance**: In the synthesis page, clearly show which source notes and existing pages it is drawing from, either in the text or in the Connections section.
7. **Update wiki/index.md**: Add the new synthesis page under the Synthesis section with a concise 1-2 sentence summary that reflects the theme.
8. **Append to wiki/log.md**: Add an entry in this format:
   `## [YYYY-MM-DD] synthesis | Theme Name`
9. **Commit and report files touched**: List all files read, created, or updated, including source notes, pages, index, and log.

## Rules
- **Read all relevant source notes and related wiki pages before editing**: Always build the synthesis from the current wiki state.
- **Prefer updating existing synthesis pages over creating duplicates**: If a relevant synthesis page already exists, extend it rather than creating a redundant page.
- **Keep it evidence-based**: Only synthesize insights that are clearly supported by the sources and related pages.
- **Keep source notes immutable**: Do not alter `wiki/source-notes/` source summaries while drafting synthesis.

## Files Typically Touched
- Read: `wiki/source-notes/*.md`
- Read: existing related wiki pages such as `wiki/Markets/AI Agents.md` and `wiki/Synthesis/Multi-Agent Patterns.md`
- Created: `wiki/Synthesis/Theme Name.md`
- Updated: `wiki/index.md`
- Updated: `wiki/log.md`

## Proven Use Case
This skill is intended to turn the project’s existing agent-related source notes into higher-level synthesis pages, such as combining context engineering, multi-agent design, and production reliability into a single takeaway that none of the original sources expresses alone.