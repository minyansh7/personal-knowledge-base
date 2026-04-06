# Synthesis Builder Skill

## Description

Creates and updates Findings pages after 5 or more source notes have accumulated since the last synthesis run. A Findings page is a cross-source claim — something that only becomes visible when holding multiple sources simultaneously, not stated by any single source alone. Business implications are included inside the Findings page only when non-obvious and profound; otherwise omitted.

## Trigger Condition

Run only when `.claude/ingest_counter` reaches 5. Reset counter to 0 after successful run.

## Workflow

1. **Read all source notes** in `wiki/source-notes/` — full content of each.
2. **Read existing Findings pages** in `wiki/Findings/` — understand what claims already exist to avoid restating them.
3. **Read `wiki/index.md`** — understand current wiki state.
4. **Identify cross-source claims**: What assertion only emerges from reading multiple source notes together? Test: could this claim appear in any single source? If yes, it belongs in source-notes, not Findings.
5. **For each new claim**:
   - Check if an existing Findings page already owns this territory. If yes, extend it with a new paragraph rather than creating a new file.
   - If genuinely new territory, create `wiki/Findings/[Assertion as filename].md`.
   - Name the file after the claim, not the topic (e.g., `Context as Maintenance.md` not `Context Engineering.md`).
6. **Business Note**: After writing the claim, ask: does this have a non-obvious business implication that would change a decision? If yes, add a `## Business Note` paragraph. If the implication is obvious or generic, skip entirely.
7. **Update `wiki/index.md`**: Add or revise the Findings entry. Summary must reflect the claim, not the topic.
8. **Append to `wiki/log.md`**: `## [YYYY-MM-DD] synthesis | Theme Name`
9. **Commit**: `git add . && git commit -m "Synthesis: [Theme] — [one-line claim]"`
10. **Report**: List all files read, created, or updated.

## Findings Page Format

```
---
tags: [findings, topic]
last_updated: YYYY-MM-DD
---

# [Assertion stated as a claim, not a topic]

[2-4 paragraphs. The cross-source claim and its implications.
What none of the individual sources says alone.]

## Business Note
[One paragraph. Only if non-obvious. Skip section entirely if not.]

# Connections
[[1-5 source-notes and Findings pages that feed this claim. Only real ones.]]

<details>
<summary>Structure Notes</summary>
Reference material only. No interpretation.
</details>
```

## Rules

- **Never create a Findings page for a claim a single source already makes** — that belongs in source-notes.
- **Never restate source note content** — synthesize across it.
- **Prefer extending existing Findings over creating new files** — one clear file per territory.
- **Business Note is optional by default** — include only when it would change a decision.
- **Do not modify source notes** — they are immutable inputs to synthesis.
- **Output paths**: `wiki/Findings/` only. No other folders.

## Files Touched

- Read: `wiki/source-notes/*.md`, `wiki/Findings/*.md`, `wiki/index.md`
- Created/Updated: `wiki/Findings/[Claim].md`
- Updated: `wiki/index.md`, `wiki/log.md`
