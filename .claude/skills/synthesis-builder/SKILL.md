# Synthesis Builder Skill

## Description

Creates and updates Findings pages from accumulated source notes. A Findings page is a cross-source claim — something that only becomes visible when holding multiple sources simultaneously, not stated by any single source alone. Business implications are included only when non-obvious and would change a decision.

## Trigger Condition

Run when `scripts/ingest_counter` reaches 5 (triggered inline from Ingest), or on demand. Reset counter to 0 after a successful run.

## Workflow

### Step 1 — Read everything

1. Read all source notes in `wiki/source-notes/` — full content of each.
2. Read all existing Findings pages in `wiki/Findings/`.
3. Read `wiki/index.md`.

### Step 2 — Identify cross-source claims

What assertion only emerges from reading multiple source notes together? Test: could this claim appear in any single source? If yes, it belongs in source-notes, not Findings.

### Step 3 — For each new claim, run three gates before writing anything

All gates run internally — never surface to user.

**Gate A — Claim uniqueness (create vs. extend)**
1. State the new claim in one sentence.
2. Read all existing Findings page titles and opening paragraphs.
3. Does any existing Findings page already own this claim, even partially?
   - Yes → extend that page. Proceed to Gate B.
   - No → create `wiki/Findings/[Assertion as filename].md`. Name after the claim, not the topic. Proceed to Gate B.

**Gate B — Significance (append vs. discard)**
1. State the new paragraph in one sentence.
2. Read every existing paragraph in the target Findings page.
3. Does this sentence say something that could not be inferred from what is already written?
   - No → discard.
   - Yes → does it belong to this page's assertion, or does it establish a different claim?
     - Same territory → proceed to Gate C.
     - Different claim → return to Gate A, treat as new claim.

**Gate C — Format lock (before any write)**
Verify the draft contains only these sections:
```
# [Assertion title]        required
## Business Note           optional, one instance only
# Connections              required
<details> Structure Notes  required
```
If the draft contains any other `##` section, collapse it into body paragraphs or discard it. Never write a Findings page that deviates from this structure.

### Step 4 — Business Note

After passing all three gates: does this claim have a non-obvious business implication that would change a decision? If yes, add `## Business Note`. If obvious or generic, skip entirely.

### Step 5 — Update index and log

1. Update `wiki/index.md`: add or revise Findings entry. Summary must reflect the claim, not the topic.
2. Append to `wiki/log.md`: `## [YYYY-MM-DD] synthesis | Theme Name`.

### Step 6 — Reindex and commit

```
qmd update --collection wiki && qmd embed
git add . && git commit -m "Synthesis: [one-line cross-source claim]"
```

If triggered inline from Ingest, skip the git commit — the Ingest caller handles it. Still run `qmd update --collection wiki && qmd embed`.

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
