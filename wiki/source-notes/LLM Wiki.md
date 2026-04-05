---
tags: [source-note, llm, wiki, pattern]
last_updated: 2026-04-06
sources_count: 1
---

# Core Insight

Wikis don't die because people stop thinking — they die because people stop filing. The LLM Wiki pattern works not because LLMs reason better than humans, but because they are infinitely more patient at the bookkeeping humans reliably abandon: updating cross-references, flagging contradictions, keeping summaries current. The bottleneck in every personal knowledge system has always been maintenance motivation, not intelligence. LLMs have no motivation to decay.

## Why It Matters to Minyan

Every previous tool you've used to capture thinking — Notion, Roam, notes apps — failed at the same point: the moment filing became more work than it was worth. The wiki you're building now has a structural advantage none of those had: the maintenance cost is near zero and stays near zero as the wiki grows. This is not a marginal improvement. It changes the long-term economics of the whole system.

## What This Changes Long-Term

The value of this wiki is not linear with the number of sources ingested — it's compounding. Each new source connects to everything already filed, and those connections are already there when you query. But the compounding only works if Claude keeps maintaining it. The long-term bet isn't on Claude being smart; it's on Claude being consistent. That's a much safer bet.

This means the wiki is worth investing in seriously — not as an experiment but as infrastructure. Sources filed now create value for queries two years from now. The system earns trust by staying maintained, not by being impressive in any single session.

## What It Contradicts

The dominant assumption in personal knowledge management is that the tool is the problem — switch to a better app and the system will hold. This document makes the opposite case: the tool has never been the problem. The problem is that maintenance is inherently demotivating for humans regardless of the interface. Roam didn't fail because of its UI. Notion doesn't fail because of its structure. They fail because humans aren't built for consistent bookkeeping at scale. Fixing the tool doesn't fix the human. Removing the human from the maintenance loop does.

# Connections

- [[Meta/LLM Wiki Pattern]] - Main architectural page for this pattern.
- [[source-notes/skills skills thatguysizemore agent-config SKILL.md at main]] - Configuration drift is the maintenance failure mode applied to CLAUDE.md itself.

# Actions

- Treat this wiki as long-term infrastructure, not an experiment. File things you'd want to find in two years.
- The compounding only holds if Claude maintains consistently — every manual correction not written back to CLAUDE.md is a leak in the system.

<details>
<summary>Structure Notes</summary>

Three-layer architecture: raw immutable sources (`/raw/`), LLM-maintained wiki pages (`wiki/`), schema configuration (`CLAUDE.md`) that governs LLM behavior. Three operations: ingest (add source → Claude files silently → reports), query (ask question → Claude synthesizes from wiki → valuable answers filed back), lint (periodic health check for contradictions, orphans, stale claims). Navigation via index.md (content catalog) and log.md (append-only chronological record). Optional tools: qmd for wiki search, Obsidian for graph view and visualization, git for versioning.

</details>
