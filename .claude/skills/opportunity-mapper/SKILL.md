# Opportunity Mapper Skill

## Description
This skill identifies and maps concrete commercial or strategic opportunities emerging from existing wiki knowledge. It triggers when the user asks "what opportunities emerge from what I know about X", where X is a topic covered in the wiki. The skill synthesizes insights from theme pages, synthesis pages, and supporting wiki content to surface actionable opportunities, grounded in evidence, without inventing unsupported ideas.

## Workflow Steps
1. **Parse the query**: Identify the topic X from the user's question (e.g., "AI agents" from "what opportunities emerge from what I know about AI agents").
2. **Read relevant wiki pages**: Scan `index.md` to find pages related to X, including theme pages (e.g., `wiki/Markets/AI Agents.md`), synthesis pages (e.g., `wiki/Synthesis/Multi-Agent Patterns.md`), and supporting pages (e.g., `wiki/Ideas/AI Ventures.md`, `wiki/Opportunities/AI Agent Deployments.md`).
3. **Extract key insights**: Review the content to identify patterns, gaps, or intersections that suggest opportunities. Focus on commercial (e.g., market applications) or strategic (e.g., ventures, deployments) angles.
4. **Identify 3–5 opportunities**: Select concrete opportunities based on wiki evidence. For each:
   - **Opportunity**: A clear, actionable idea.
   - **Why it matters**: Strategic or commercial value.
   - **Supporting evidence**: Specific references to wiki pages/sections.
   - **Uncertainty or risk**: Potential challenges or unknowns.
   - **Next experiment or action**: A concrete next step.
5. **Draft the opportunity page**: Create a new page in `wiki/Opportunities/` with frontmatter (tags: [opportunities, topic], last_updated: current date, sources_count: number of referenced pages), sections: # Overview, # Opportunities (listing the 3–5 with details), # Connections.
6. **Update index.md**: Add the new page under Opportunities section with a concise 1-2 sentence summary.
7. **Append to log.md**: Add entry in format `## [YYYY-MM-DD] opportunity | Topic Name`.
8. **Commit changes**: Use `git add . && git commit -m "Map opportunities: Topic Name - identified X opportunities"`.
9. **Report files touched**: List all files read, created, or updated.

## Rules
- **Ground in wiki evidence**: Only identify opportunities supported by existing wiki content; never invent or speculate.
- **Limit to 3–5 opportunities**: Focus on quality over quantity to maintain actionability.
- **Include all required elements**: Each opportunity must have the five components (opportunity, why, evidence, risk, action).
- **Update wiki structure**: Ensure bidirectional links in Connections section.

## Files Typically Touched
- Read: `index.md`, relevant `wiki/Markets/`, `wiki/Synthesis/`, `wiki/Ideas/`, `wiki/Opportunities/` pages
- Created: `wiki/Opportunities/Topic Name.md`
- Updated: `index.md`
- Updated: `log.md`

## Proven Effectiveness
This skill builds on the synthesis-builder by turning synthesized insights into actionable opportunities, tested on AI agent topics to surface deployment and venture paths.</content>
<parameter name="filePath">/Users/minyan/Minyan's Wiki/.claude/skills/opportunity-mapper/SKILL.md