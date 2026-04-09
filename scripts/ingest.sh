#!/bin/bash
# ingest.sh — Minyan's Wiki ingest trigger
# Called by Obsidian QuickAdd with the target file path as $1
# Usage: /path/to/ingest.sh "/path/to/raw/articles/Article Title.md"

set -euo pipefail

WIKI_DIR="/Users/minyan/Minyan's Wiki"
NODE_BIN="/Users/minyan/.nvm/versions/node/v24.14.1/bin/node"
CLAUDE_BIN="/Users/minyan/.nvm/versions/node/v24.14.1/bin/claude"
export PATH="/Users/minyan/.nvm/versions/node/v24.14.1/bin:$PATH"
export HOME="/Users/minyan"

# Load ANTHROPIC_API_KEY from shell profile (launchd does not source .zshrc)
if [ -z "${ANTHROPIC_API_KEY:-}" ]; then
  export ANTHROPIC_API_KEY=$(grep '^export ANTHROPIC_API_KEY=' "$HOME/.zshrc" 2>/dev/null | head -1 | sed 's/export ANTHROPIC_API_KEY=//')
fi
PROMPT_FILE="$WIKI_DIR/scripts/ingest.txt"
LOG_FILE="$WIKI_DIR/scripts/watcher.log"
INGEST_FILE="${1:-}"

# ── Validate input ─────────────────────────────────────────────────────────────

if [[ -z "$INGEST_FILE" ]]; then
  echo "[$(date '+%Y-%m-%d %H:%M')] ERROR: No file path provided." >> "$LOG_FILE"
  exit 1
fi

if [[ ! -f "$INGEST_FILE" ]]; then
  echo "[$(date '+%Y-%m-%d %H:%M')] ERROR: File not found: $INGEST_FILE" >> "$LOG_FILE"
  exit 1
fi

# Only process markdown files
if [[ "${INGEST_FILE##*.}" != "md" ]]; then
  echo "[$(date '+%Y-%m-%d %H:%M')] SKIP: Not a markdown file: $INGEST_FILE" >> "$LOG_FILE"
  exit 0
fi

# Ignore Obsidian internals and DS_Store
if [[ "$INGEST_FILE" == *".obsidian"* ]] || [[ "$INGEST_FILE" == *".DS_Store"* ]]; then
  exit 0
fi

# Only process files inside raw/ subfolders (articles, inbox, transcripts)
if [[ "$INGEST_FILE" != "$WIKI_DIR/raw/"* ]]; then
  echo "[$(date '+%Y-%m-%d %H:%M')] SKIP: Not in raw/: $INGEST_FILE" >> "$LOG_FILE"
  exit 0
fi

# ── Launch Claude ──────────────────────────────────────────────────────────────

echo "[$(date '+%Y-%m-%d %H:%M')] START: $INGEST_FILE" >> "$LOG_FILE"

cd "$WIKI_DIR"

export INGEST_FILE="$INGEST_FILE"

"$CLAUDE_BIN" \
  --print \
  --dangerously-skip-permissions \
  "$(cat "$PROMPT_FILE")

The file to ingest is: $INGEST_FILE" \
  >> "$LOG_FILE" 2>&1

EXIT_CODE=$?

if [[ $EXIT_CODE -eq 0 ]]; then
  echo "[$(date '+%Y-%m-%d %H:%M')] DONE: $INGEST_FILE" >> "$LOG_FILE"
  qmd update --collection wiki >> "$LOG_FILE" 2>&1
  qmd embed >> "$LOG_FILE" 2>&1
  echo "[$(date '+%Y-%m-%d %H:%M')] INDEXED: qmd updated" >> "$LOG_FILE"
else
  echo "[$(date '+%Y-%m-%d %H:%M')] FAILED (exit $EXIT_CODE): $INGEST_FILE" >> "$LOG_FILE"
fi
