# Source Ingestor Skill

## Description

Processes a single new source file from `/raw/` (including subfolders) into the wiki. Runs silently — no discussion, no check-ins, no confirmation before writing. Processes, files, reports.

## Trigger Condition

A new `.md` file appears in `/raw/` or any subfolder (`/raw/articles/`, `/raw/inbox/`, `/raw/transcripts/`). Ignores `.DS_Store`, `.obsidian`, and non-markdown files.

## Workflow

### Step 1 — Dedup check

1. Derive expected source note name: take the filename of the source, strip the extension.
2. Check if `wiki/source-notes/[name].md` already exists.
3. Scan `wiki/log.md` for any line containing `ingest | [name]`.
4. If either exists:
   - If content is materially the same → do nothing. Append to `wiki/log.md`: `## [YYYY-MM-DD] skip | [name] — already ingested`. Stop. No commit.
   - If content is materially different → UPDATE: rewrite the existing source note, update `last_updated` in frontmatter, revise the summary in `wiki/index.md`. Append to `wiki/log.md`: `## [YYYY-MM-DD] update | [name]`. Increment `scripts/ingest_counter` by 1. Then run Step 5 (synthesis trigger check). Commit: `git add . && git commit -m "Update: [name] — [one-line change]"`. Stop.
5. If neither exists → proceed as new ingest.

### Step 2 — Read and validate

1. Read the source fully.
2. Check for truncated content or missing sections. If incomplete, note limitations and proceed with available content.
3. Read `wiki/index.md` and relevant existing source notes and Findings pages — understand what's already filed.

### Step 3 — Synthesis Quality Gate (internal — never surface to user)

1. Draft the core insight.
2. Test: could someone familiar with this topic predict this claim from the document's headings alone? If yes, delete it and go deeper.
3. Ask: what would a smart person miss on a first read of this source?
4. That answer becomes the core insight. Do not proceed until it passes this test.

### Step 4 — Write

1. Write source note to `wiki/source-notes/[Source Title].md` using the Source Note format below.
2. Update `wiki/index.md`: add entry under Source Notes. Include all five columns: Page | Summary | Source Note | Raw Source | Last Updated. Source Note links to `[[source-notes/filename]]`, Raw Source links to `[[raw/articles/filename]]`. Summary must reflect the insight, not the topic.
3. Append to `wiki/log.md`: `## [YYYY-MM-DD] ingest | Source Title`.
4. Increment `scripts/ingest_counter` by 1 (create with value `1` if missing).

### Step 5 — Synthesis trigger

1. Read current value of `scripts/ingest_counter`.
2. If value < 5 → proceed to Step 6.
3. If value >= 5 → invoke the `synthesis-builder` skill inline (same session). Synthesis runs `qmd update --collection wiki && qmd embed` internally. Reset `scripts/ingest_counter` to `0`. Then commit everything in one atomic commit: `git add . && git commit -m "Ingest + Synthesis: [one-line cross-source claim from synthesis]"`. Stop.

### Step 6 — Commit

`git add . && git commit -m "Ingest: [Source Title] — [one-line insight]"`

### Step 7 — Report

List all files read, created, or updated. Note whether synthesis ran.

## Source Note Format

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
- Updated: `wiki/index.md`, `wiki/log.md`, `scripts/ingest_counter`
- Updated (if synthesis triggered): `wiki/Findings/*.md`, `wiki/index.md` (revised)
