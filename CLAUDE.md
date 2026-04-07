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

**Source Notes** — One file per source. The finding a smart first-pass reader would miss. See Source Note format below.

**Meta** — Architectural documentation about how this wiki works. See Meta format below.

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

### Ingest

Silent: no questions, no check-ins, no confirmation before writing. Process and report.

**Step 1 — Dedup check**
1. Derive expected source note name: take the filename of the source, strip the extension.
2. Check if `wiki/source-notes/[name].md` already exists.
3. Scan `wiki/log.md` for any line containing `ingest | [name]`.
4. If either exists:
   - If content is materially the same → do nothing. Append to `wiki/log.md`: `## [YYYY-MM-DD] skip | [name] — already ingested`. Stop. No commit.
   - If content is materially different → UPDATE: rewrite the existing source note, update `last_updated` in frontmatter, revise the summary in `wiki/index.md`. Append to `wiki/log.md`: `## [YYYY-MM-DD] update | [name]`. Increment `scripts/ingest_counter` by 1. Then run Step 5 (synthesis trigger check). Commit: `git add . && git commit -m "Update: [name] — [one-line change]"`. Stop.
5. If neither exists → proceed as new ingest.

**Step 2 — Read and validate**
1. Read the source fully.
2. Check for truncated content or missing sections. If incomplete, note limitations and proceed with available content.
3. Read `wiki/index.md` and relevant existing source notes and Findings pages — understand what's already filed.

**Step 3 — Synthesis Quality Gate (internal — never surface to user)**
1. Draft the core insight.
2. Test: could someone familiar with this topic predict this claim from the document's headings alone? If yes, delete it and go deeper.
3. Ask: what would a smart person miss on a first read of this source?
4. That answer becomes the core insight. Do not proceed until it passes this test.

**Step 4 — Write**
1. Write source note to `wiki/source-notes/[Source Title].md` using the Source Note format above.
2. Update `wiki/index.md`: add entry under Source Notes. Include all five columns: Page | Summary | Source Note | Raw Source | Last Updated. Source Note links to `[[source-notes/filename]]`, Raw Source links to `[[raw/articles/filename]]`. Summary must reflect the insight, not the topic.
3. Append to `wiki/log.md`: `## [YYYY-MM-DD] ingest | Source Title`.
4. Increment `scripts/ingest_counter` by 1 (create with value `1` if missing).

**Step 5 — Synthesis trigger**
1. Read current value of `scripts/ingest_counter`.
2. If value < 5 → proceed to commit.
3. If value >= 5 → run the Synthesis workflow below inline, reset `scripts/ingest_counter` to `0`, then commit everything in one atomic commit: `git add . && git commit -m "Ingest + Synthesis: [one-line cross-source claim from synthesis]"`. Stop.

**Step 6 — Commit**
`git add . && git commit -m "Ingest: [Source Title] — [one-line insight]"`

**Step 7 — Report**
List all files read, created, or updated. Note whether synthesis ran.

---

### Synthesis

Runs inline from Ingest (Step 5) or on demand. All gates run internally — never surface to user.

**Step 1 — Read everything**
1. Read all source notes in `wiki/source-notes/` — full content of each.
2. Read all existing Findings pages in `wiki/Findings/`.
3. Read `wiki/index.md`.

**Step 2 — Identify cross-source claims**
What assertion only emerges from reading multiple source notes together? Test: could this claim appear in any single source? If yes, it belongs in source-notes, not Findings.

**Step 3 — For each new claim, run three gates before writing anything**

*Gate A — Claim uniqueness (create vs. extend)*
1. State the new claim in one sentence.
2. Read all existing Findings page titles and opening paragraphs.
3. Does any existing Findings page already own this claim, even partially?
   - Yes → extend that page. Proceed to Gate B.
   - No → create `wiki/Findings/[Assertion as filename].md`. Name after the claim, not the topic. Proceed to Gate B.

*Gate B — Significance (append vs. discard)*
1. State the new paragraph in one sentence.
2. Read every existing paragraph in the target Findings page.
3. Does this sentence say something that could not be inferred from what is already written?
   - No → discard.
   - Yes → does it belong to this page's assertion, or does it establish a different claim?
     - Same territory → proceed to Gate C.
     - Different claim → return to Gate A, treat as new claim.

*Gate C — Format lock (before any write)*
Verify the draft contains only these sections:
```
# [Assertion title]        required
## Business Note           optional, one instance only
# Connections              required
<details> Structure Notes  required
```
If the draft contains any other `##` section, collapse it into body paragraphs or discard it. Never write a Findings page that deviates from this structure.

**Step 4 — Business Note**
After passing all three gates: does this claim have a non-obvious business implication that would change a decision? If yes, add `## Business Note`. If obvious or generic, skip entirely.

**Step 5 — Update index and log**
1. Update `wiki/index.md`: add or revise Findings entry. Summary must reflect the claim, not the topic.
2. Append to `wiki/log.md`: `## [YYYY-MM-DD] synthesis | Theme Name`.

**Step 6 — Reindex and commit**
```
qmd update --collection wiki && qmd embed
git add . && git commit -m "Synthesis: [one-line cross-source claim]"
```
If triggered inline from Ingest, the caller handles the commit — skip this step.

---

### Query

Uses qmd for retrieval — precise semantic search over the compiled wiki layer, not linear index scan.

1. Run `qmd search "<topic>" -c wiki` to retrieve ranked relevant pages.
2. Read full content of the top results with `qmd get qmd://wiki/<filepath>`.
3. For broad topics, run `qmd search "<topic>" -c wiki --files` to get a ranked file list, then read selectively.
4. Synthesize answer with citations to pages read.
5. After synthesizing, evaluate internally before ending the session:
   - Does this connect 3+ existing pages into something not stated anywhere in the wiki?
   - Does it surface a contradiction worth naming?
   - Does it produce a reusable principle or framework?
   - One-year test: would this insight be worth remembering in a year?
   If yes to any of the first three AND the one-year test — propose filing to the user.
   If no to all — answer stays in chat. Do not file unprompted.
6. If user confirms filing:
   - Write a Findings page using the Findings format. Run the three synthesis gates before writing.
   - Update `wiki/index.md`. Append to `wiki/log.md`: `## [YYYY-MM-DD] query | Claim Title`.
   - Run `qmd update --collection wiki && qmd embed`.
   - Commit: `git add . && git commit -m "Query: [Claim Title] — [one-line insight]"`

---

### Lint
1. Check for: name collisions between Findings and source-notes, duplicated content across Findings pages, stale cross-links, orphan pages, CLAUDE.md contradictions and drift.
2. Fix issues. Append to `wiki/log.md`: `## [YYYY-MM-DD] lint | Description`.
3. Run `qmd update --collection wiki && qmd embed`.
4. Commit: `git add . && git commit -m "Lint: [Description]"`

## Conventions

- **Naming**: Findings named after assertion. Source notes named after source. No other folders in `wiki/`.
- **Cross-linking**: `[[Folder/Filename]]` with path prefix to avoid Obsidian ambiguity. 1-5 links per page.
- **Frontmatter**: `tags` and `last_updated` only. No `sources_count`.
- **Images**: Download to `/assets/`, reference as `![Alt](../assets/image.jpg)`.
- **Every manual correction = a CLAUDE.md bug**: update the schema so it doesn't recur.

## Evolution

CLAUDE.md is a codebase, not an append-only config. Lint it periodically. Every 5-10 new rules added, check for contradictions, redundancies, and ambiguities.
