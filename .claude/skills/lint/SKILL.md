# Lint Skill

## Description

Periodic health check for the wiki. Finds and fixes structural issues: name collisions, duplicated content, stale cross-links, orphan pages, and CLAUDE.md drift.

## Trigger Condition

Run on demand for periodic wiki maintenance.

## Workflow

### Step 1 — Audit

Check for all of the following:
- **Name collisions**: any filename that appears in both `wiki/Findings/` and `wiki/source-notes/`.
- **Duplicated content**: Findings pages that restate the same cross-source claim under different titles.
- **Stale cross-links**: `[[wikilinks]]` that point to pages that no longer exist or have been renamed.
- **Orphan pages**: pages in `wiki/source-notes/` or `wiki/Findings/` not listed in `wiki/index.md`.
- **CLAUDE.md drift**: conventions or formats in CLAUDE.md that contradict observed wiki state (e.g., frontmatter fields in use that CLAUDE.md prohibits, or naming patterns that violate the schema).

### Step 2 — Fix

Resolve each issue found:
- Rename colliding files to disambiguate (Findings file takes precedence for assertion names).
- Merge duplicated Findings content — one file per territory.
- Update or remove stale wikilinks.
- Add orphan pages to `wiki/index.md`.
- Update CLAUDE.md to reflect reality, or fix files to match CLAUDE.md — whichever is correct.

### Step 3 — Log and reindex

1. Append to `wiki/log.md`: `## [YYYY-MM-DD] lint | [Description of what was fixed]`.
2. Run `qmd update --collection wiki && qmd embed`.

### Step 4 — Commit

`git add . && git commit -m "Lint: [Description]"`

### Step 5 — Report

List all issues found and how each was resolved.

## Rules

- Fix issues, don't just report them.
- When CLAUDE.md and observed practice conflict, determine which is authoritative and update the other.
- Do not change source note content during lint — only structural/index fixes.
