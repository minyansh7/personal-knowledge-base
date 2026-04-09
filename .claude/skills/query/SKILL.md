# Query Skill

## Description

Answers questions from the wiki using semantic search. Uses qmd for precise retrieval over the compiled wiki layer, not linear index scan. After synthesizing, evaluates internally whether the answer warrants filing as a new Findings page.

## Trigger Condition

User asks a question about topics that may be covered in the wiki.

## Workflow

### Step 1 — Retrieve

1. Run `qmd search "<topic>" -c wiki` to retrieve ranked relevant pages.
2. Read full content of top results with `qmd get qmd://wiki/<filepath>`.
3. For broad topics, run `qmd search "<topic>" -c wiki --files` to get a ranked file list, then read selectively.

### Step 2 — Synthesize

Synthesize an answer with citations to the pages read.

### Step 3 — Filing evaluation (internal — never surface unless answer is yes)

After synthesizing, evaluate internally:
- Does this connect 3+ existing pages into something not stated anywhere in the wiki?
- Does it surface a contradiction worth naming?
- Does it produce a reusable principle or framework?
- One-year test: would this insight be worth remembering in a year?

If yes to any of the first three AND the one-year test → propose filing to the user.
If no to all → answer stays in chat. Do not file unprompted.

### Step 4 — File (only if user confirms)

1. Write a Findings page using the Findings format. Run the three synthesis gates (from `synthesis-builder`) before writing.
2. Update `wiki/index.md`. Append to `wiki/log.md`: `## [YYYY-MM-DD] query | Claim Title`.
3. Run `qmd update --collection wiki && qmd embed`.
4. Commit: `git add . && git commit -m "Query: [Claim Title] — [one-line insight]"`

## Rules

- Retrieve before answering — do not answer from memory alone.
- Do not file unprompted — only after user confirmation.
- Citations required — every claim traces to a page read this session.
