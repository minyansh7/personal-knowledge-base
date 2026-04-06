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
5. **For each new claim, run the three gates in order before writing anything:**

   **Gate 3 — Claim uniqueness (create vs. extend decision)**
   1. State the new claim in one sentence.
   2. Read all existing Findings page titles and opening paragraphs.
   3. Ask: does any existing Findings page already own this claim, even partially?
   4. If yes → extend that page (proceed to Gate 1). Do not create a new file.
   5. If no → create `wiki/Findings/[Assertion as filename].md`. Name after the claim, not the topic.

   **Gate 1 — Significance (append vs. discard decision)**
   1. State the new paragraph in one sentence.
   2. Read every existing paragraph in the target Findings page.
   3. Ask: does this sentence say something that could not be inferred from what is already written?
   4. If no → discard. Do not append.
   5. If yes → ask: does it belong to this page's existing assertion, or does it establish a different claim?
      - Same territory → proceed to Gate 2.
      - Different claim → return to Gate 3, treat as a new claim.

   **Gate 2 — Format lock (before any write)**
   Verify the draft contains only these sections and no others:
   ```
   # [Assertion title]        required
   ## Business Note           optional, one instance only
   # Connections              required
   <details> Structure Notes  required
   ```
   If the draft contains any other `##` section, collapse it into the body paragraphs or discard it. Never write a Findings page that deviates from this structure.

   All three gates run internally. Never surface them to the user.

6. **Business Note**: After passing all three gates, ask: does this claim have a non-obvious business implication that would change a decision? If yes, add a `## Business Note` paragraph. If obvious or generic, skip entirely.
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
