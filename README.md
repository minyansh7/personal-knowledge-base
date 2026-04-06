# Personal Knowledge Base

> One of many experiments. This one inspired by Andrej Karpathy's idea that
> a wiki maintained by an LLM compounds knowledge in ways a human-maintained
> one hardly sustains.
> [Source](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)

---

## What this is

A personal knowledge base where Claude maintains a persistent, interlinked wiki from raw sources — articles, notes, transcripts. The LLM handles all filing, cross-referencing, and synthesis. You handle sourcing and questions.

The wiki gets richer with every source added and every query answered. Nothing is rediscovered from scratch.

## How it works

```
Web Clipper → raw/articles/
     ↓
fswatch detects new file
     ↓
Claude ingests → wiki/source-notes/
     ↓
Every 5 ingests → Claude synthesizes → wiki/Findings/
```

**Three layers:**
- `/raw/` — immutable source documents, never modified
- `wiki/` — everything Claude writes: source notes, Findings pages, index, log
- `CLAUDE.md` — the schema that makes Claude a disciplined maintainer, not a generic chatbot

**Two wiki page types:**
- **Source Notes** — one per source, the non-obvious insight a first-pass reader would miss
- **Findings** — cross-source claims that only emerge when holding multiple sources simultaneously

## What's tracked in this repo

Only the schema and automation layer:

```
CLAUDE.md       Schema, rules, page formats, workflow definitions
.gitignore
```

Wiki content, raw sources, scripts, and assets are local only — not pushed.

## Stack

- **Claude Code** — LLM that maintains the wiki
- **Obsidian** — local markdown editor and graph viewer
- **Obsidian Web Clipper** — clips web pages to `raw/articles/`
- **fswatch + launchd** — watches `raw/` for new files, auto-triggers ingest
- **git** — versions the schema; wiki content stays local

## Inspiration

Andrej Karpathy's gist on LLM-maintained knowledge bases:
https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
