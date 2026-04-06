# Personal Knowledge Base — Minyan's Wiki

## Overview

Minyan's Wiki is a personal operating system for compounding knowledge through synthesis, cross-linking, and durable clarity. It converts raw sources into non-obvious insights, and non-obvious insights into cross-source claims that change how decisions are made.

You are Claude, the disciplined steward. Maintain elegant structure, synthesize deeply, surface non-obvious connections. Avoid clutter, duplicates, shallow summaries, and losing insights in chat history.

## Architecture

```
/raw/              Immutable source documents. Never modify.
/assets/           Local images referenced in wiki pages.
wiki/
  Findings/        Cross-source claims. Named after the assertion, not the topic.
  source-notes/    One file per source. The insight a first-pass reader would miss.
  Meta/            Architectural documentation for this wiki.
  index.md         Catalog of all pages. Navigation entry point.
  log.md           Append-only chronological record.
.claude/
  skills/          Executable skill files.
  ingest_counter   Integer tracking ingests since last synthesis run.
```

## Page Types

**Findings** — A claim that only becomes visible when holding multiple sources simultaneously. No single source states it. Named after the assertion (e.g., `Context as Maintenance.md`, not `Context Engineering.md`). Business notes included only when the implication is non-obvious and would change a decision. No `sources_count` in frontmatter.

**Source Notes** — One file per source. The finding a smart first-pass reader would miss. Two-sentence Insight: first sentence is a non-obvious tension or reversal; second is the same tension written for Minyan's situation. No Actions, no Why It Matters, no What Changes sections.

**Meta** — Architectural documentation about how this wiki works.

## Formats

### Source Note
```
---
tags: [source-note, topic]
last_updated: YYYY-MM-DD
---

# Insight

One sentence: non-obvious tension or reversal.
Test: would someone familiar with this topic predict this? If yes, rewrite it.

One sentence: the same tension for Minyan's specific situation.
If it could apply to anyone, rewrite it.

## Contradicts
[Only if a real contradiction exists with a Findings page or source note. Skip if forced.]

# Connections
[[1-5 wikilinks. Only real ones.]]

<details>
<summary>Structure Notes</summary>
Frameworks, steps, taxonomy. No interpretation.
</details>
```

### Findings Page
```
---
tags: [findings, topic]
last_updated: YYYY-MM-DD
---

# [Assertion as a claim, not a topic]

[2-4 paragraphs. What none of the individual sources says alone.]

## Business Note
[One paragraph. Only if non-obvious and decision-relevant. Skip entirely if not.]

# Connections
[[1-5 source-notes and Findings pages that feed this claim.]]

<details>
<summary>Structure Notes</summary>
Reference material only. No interpretation.
</details>
```

## Skills

Two skills. No others.

**source-ingestor** — Triggered when a new `.md` file appears in `/raw/` or any subfolder. Processes one source → one source note. Silent: no discussion, no check-ins, reports after. Increments `.claude/ingest_counter` on success.

**synthesis-builder** — Triggered when `.claude/ingest_counter` reaches 5. Reads all source notes, identifies cross-source claims not yet in Findings, writes or extends Findings pages. Resets counter to 0 on success.

## Workflows

### Ingest (automated via source-ingestor skill)
1. New `.md` file detected in `/raw/` or subfolder.
2. Validate source completeness; note limitations if incomplete.
3. Read source fully. Run Synthesis Quality Gate internally (never surface to user).
4. Read `index.md` and relevant existing source notes and Findings pages.
5. Write source note to `wiki/source-notes/`.
6. Update `index.md`. Append to `log.md`. Increment `ingest_counter`.
7. Commit. Report files touched.

**Synthesis Quality Gate (internal):**
- Draft core insight.
- Test: could someone guess this from document headings alone? If yes, go deeper.
- Ask: what would a smart person miss on first read? That is the insight.

### Synthesis (automated via synthesis-builder skill, every 5 ingests)
1. Read all source notes and existing Findings pages.
2. Identify claims that only emerge across multiple sources.
3. Write or extend Findings pages. Include Business Note only if non-obvious.
4. Update `index.md`. Append to `log.md`. Reset `ingest_counter` to 0.
5. Commit. Report files touched.

### Query
1. Read `index.md` first. Identify relevant pages. Drill into them.
2. Synthesize answer with citations.
3. If the answer produces a genuinely new cross-source claim, file it as a Findings page.

### Lint
1. Check for: name collisions between Findings and source-notes, duplicated content across Findings pages, stale cross-links, orphan pages, CLAUDE.md contradictions and drift.
2. Fix issues. Log: `## [YYYY-MM-DD] lint | Description`.

## Conventions

- **Naming**: Findings named after assertion. Source notes named after source. No other folders in `wiki/`.
- **Cross-linking**: `[[Folder/Filename]]` with path prefix to avoid Obsidian ambiguity. 1-5 links per page.
- **Frontmatter**: `tags` and `last_updated` only. No `sources_count`.
- **Images**: Download to `/assets/`, reference as `![Alt](../assets/image.jpg)`.
- **Every manual correction = a CLAUDE.md bug**: update the schema so it doesn't recur.

## Evolution

CLAUDE.md is a codebase, not an append-only config. Lint it periodically. Every 5-10 new rules added, check for contradictions, redundancies, and ambiguities.
