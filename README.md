# Personal Knowledge Base

> One of many experiments. This one inspired by Andrej Karpathy's idea that
> a wiki maintained by an LLM compounds knowledge in ways a human-maintained
> one hardly sustains.
> [Source](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)

---

## What this is

A personal knowledge base where Claude maintains a persistent, interlinked wiki from raw sources — articles, notes, transcripts. The LLM handles all filing, cross-referencing, and synthesis. You handle sourcing and questions.

The wiki gets richer with every source added and every query answered. Nothing is rediscovered from scratch.

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                        YOU                              │
│          clip articles · ask questions                  │
└────────────────┬─────────────────┬───────────────────── ┘
                 │                 │
          new article           query
                 │                 │
                 ▼                 ▼
┌────────────────────┐   ┌─────────────────────┐
│   Obsidian Web     │   │     Claude Code      │
│   Clipper          │   │   + qmd (MCP)        │
└────────┬───────────┘   └──────────┬──────────┘
         │                          │
         ▼                          │ qmd search → ranked pages
  raw/articles/                     │ synthesize → propose file-back
         │                          │
         ▼                          ▼
  fswatch detects          ┌─────────────────┐
  new .md file             │   wiki/         │
         │                 │                 │
         ▼                 │  Findings/      │ ← cross-source claims
  scripts/ingest.sh        │  source-notes/  │ ← one per source
         │                 │  Meta/          │ ← architectural docs
         ▼                 │  index.md       │ ← navigation
  Claude Code              │  log.md         │ ← append-only record
  (--print mode)           └────────┬────────┘
         │                          │
         ├── writes source note     │
         ├── updates index.md       │
         ├── appends log.md    ─────┘
         ├── increments counter
         │
         ▼
  counter >= 5?
         │
    yes  ▼
  Synthesis runs inline
  Findings pages written
  counter reset to 0
         │
         ▼
  git commit (atomic)
         │
         ▼
  qmd reindex
```

## How it works

**Three layers:**
- `/raw/` — immutable source documents, never modified
- `wiki/` — everything Claude writes: source notes, Findings, Meta, index, log
- `CLAUDE.md` — the schema: architecture, page types, format templates, conventions
- `.claude/skills/` — the procedures: one skill file per workflow, loaded on demand

**Three wiki page types:**
- **Source Notes** — one per source, the non-obvious insight a first-pass reader would miss
- **Findings** — cross-source claims that only emerge when holding multiple sources simultaneously. Named after the assertion, not the topic.
- **Meta** — architectural documentation about how this wiki works

**Four workflows** (each a skill, loaded only when invoked):
- **Ingest** (`source-ingestor`) — triggered automatically when a new file lands in `raw/`. Dedup check → quality gate → write → synthesis trigger → commit
- **Synthesis** (`synthesis-builder`) — runs inline at every 5th ingest, or on demand. Reads all source notes, identifies cross-source claims, writes or extends Findings pages
- **Query** (`query`) — qmd retrieves semantically relevant pages, Claude synthesizes, proposes filing back if the answer produces something new
- **Lint** (`lint`) — periodic health check: name collisions, orphan pages, stale links, CLAUDE.md drift

**The synthesis trigger:**
```
scripts/ingest_counter  →  increments every ingest
                        →  synthesis fires when value >= 5
                        →  resets to 0 after synthesis
```

**The file-back loop (Karpathy's key insight):**
```
query → qmd retrieves wiki pages → Claude synthesizes
      → new cross-source insight? → propose filing back
      → filed page gets indexed by qmd
      → next query starts from richer foundation
```

## Stack

- **Claude Code** — LLM that maintains the wiki (`--print --dangerously-skip-permissions`)
- **qmd** — local hybrid BM25 + vector search with LLM reranking, wired as MCP server
- **Obsidian** — local markdown editor and graph viewer
- **Obsidian Web Clipper** — clips web pages to `raw/articles/`
- **fswatch + launchd** — watches `raw/` for new files, auto-triggers ingest
- **git** — versions CLAUDE.md and README.md; wiki content stays local

## What's tracked in this repo

```
CLAUDE.md                        Schema — architecture, page types, formats, conventions
.claude/skills/source-ingestor/  Ingest workflow
.claude/skills/synthesis-builder/ Synthesis workflow
.claude/skills/query/            Query workflow
.claude/skills/lint/             Lint workflow
README.md                        This file
```

Wiki content, raw sources, scripts, assets, and config are local only — not pushed.

## Inspiration

Andrej Karpathy's gist on LLM-maintained knowledge bases:
https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
