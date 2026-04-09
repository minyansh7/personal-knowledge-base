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
  Meta/            Architectural documentation about how this wiki works.
  index.md         Catalog of all pages. Navigation entry point.
  log.md           Append-only chronological record.
scripts/
  ingest_counter   Synthesis fires when this reaches 5. Reset to 0 after each synthesis.
```

## Page Types

**Findings** — A claim that only becomes visible when holding multiple sources simultaneously. No single source states it. Named after the assertion (e.g., `Context as Maintenance.md`, not `Context Engineering.md`). Business notes included only when the implication is non-obvious and would change a decision. No `sources_count` in frontmatter.

**Source Notes** — One file per source. The finding a smart first-pass reader would miss.

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

### Meta Page
```
---
tags: [meta]
last_updated: YYYY-MM-DD
---

# [What this documents]

[1-3 paragraphs. How this part of the wiki works, why it is structured this way,
and what to watch for when maintaining it. No source summaries, no insights.]

# Connections
[[1-3 links to pages this document governs or relates to.]]
```

## Workflows

Procedures live in skill files — invoke via the Skill tool.

| Workflow | Skill | Trigger |
|----------|-------|---------|
| Ingest | `source-ingestor` | New source in `/raw/` |
| Synthesis | `synthesis-builder` | Ingest counter ≥ 5, or on demand |
| Query | `query` | Answer a question from the wiki |
| Lint | `lint` | Periodic health check |

## Conventions

- **Naming**: Findings named after assertion. Source notes named after source. No other folders in `wiki/`.
- **Cross-linking**: `[[Folder/Filename]]` with path prefix to avoid Obsidian ambiguity. 1-5 links per page.
- **Frontmatter**: `tags` and `last_updated` only. No `sources_count`.
- **Images**: Download to `/assets/`, reference as `![Alt](../assets/image.jpg)`.
- **Every manual correction = a CLAUDE.md bug**: update the schema so it doesn't recur.

## Evolution

CLAUDE.md is a codebase, not an append-only config. Lint it periodically. Every 5-10 new rules added, check for contradictions, redundancies, and ambiguities.
