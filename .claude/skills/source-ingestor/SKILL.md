# Source Ingestor Skill

## Description

Processes a single new source file from `/raw/` (including subfolders) into the wiki. Runs silently — no discussion, no check-ins, no confirmation before writing. Processes, files, reports.

## Trigger Condition

A new `.md` file appears in `/raw/` or any subfolder (`/raw/articles/`, `/raw/inbox/`, `/raw/transcripts/`). Ignores `.DS_Store`, `.obsidian`, and non-markdown files.

## Workflow

1. **Identify the new file**: The file that triggered the run.
2. **Validate**: Check for truncated content or missing sections. If incomplete, note limitations and proceed with available content.
3. **Read the source fully**.
4. **Read `wiki/index.md`** to understand current wiki state.
5. **Read relevant existing source notes and Findings pages** — understand what's already filed to avoid duplication.

### Synthesis Quality Gate (internal — never surface to user)

Before writing the source note:
1. Draft the core insight.
2. Test: could someone familiar with this topic predict this claim from the document's headings alone? If yes, delete it and go deeper.
3. Ask: what would a smart person miss on a first read of this source?
4. That answer becomes the core insight.
Do not proceed until the insight passes this test.

6. **Write source note** in `wiki/source-notes/[Source Title].md` using the format below.
7. **Update `wiki/index.md`**: Add entry under Source Notes. Summary must reflect the insight, not the topic.
8. **Append to `wiki/log.md`**: `## [YYYY-MM-DD] ingest | Source Title`
9. **Increment `wiki/.claude/ingest_counter`** by 1 (create file with value `1` if it doesn't exist).
10. **Commit**: `git add . && git commit -m "Ingest: [Source Title] — [one-line insight]"`
11. **Report**: List all files read, created, or updated.

## Source Note Format

```
---
tags: [source-note, topic, subtopic]
last_updated: YYYY-MM-DD
---

# Insight

One sentence: a non-obvious tension or reversal.
Test: would someone familiar with this topic predict this? If yes, rewrite it.

One sentence: the same tension written for Minyan's specific situation.
If it could apply to anyone, rewrite it.

## Contradicts
[Only if a real contradiction exists with an existing Findings page or source note.
Skip entirely if forced.]

# Connections
[[1-5 wikilinks. Only real ones. Findings pages and related source notes.]]

<details>
<summary>Structure Notes</summary>
Frameworks, steps, taxonomy from the source. No interpretation.
</details>
```

## Rules

- **Silent ingest**: no discussion, no takeaway check-ins, no approval before writing.
- **One source note per source**: never split a source across multiple notes.
- **Never modify `/raw/`**: immutable sources of truth.
- **Never modify existing source notes** during an ingest of a different source.
- **Output paths**: `wiki/source-notes/` only. No other wiki folders.
- **Every manual correction to filing = a CLAUDE.md bug**: update the schema so it doesn't recur.

## Files Touched

- Read: `/raw/[subfolder]/Source.md`, `wiki/index.md`, relevant `wiki/source-notes/*.md`, `wiki/Findings/*.md`
- Created: `wiki/source-notes/Source Title.md`
- Updated: `wiki/index.md`, `wiki/log.md`, `.claude/ingest_counter`
