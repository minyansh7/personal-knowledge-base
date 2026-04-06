#!/bin/bash
# ingest.sh — Minyan's Wiki ingest trigger
# Called by Obsidian QuickAdd with the target file path as $1
# Usage: /path/to/ingest.sh "/path/to/raw/articles/Article Title.md"

set -euo pipefail

WIKI_DIR="/Users/minyan/Minyan's Wiki"
PYTHON_BIN="/usr/bin/env python3"
INGEST_PY="$WIKI_DIR/.claude/ingest_openai.py"
LOG_FILE="$WIKI_DIR/.claude/watcher.log"
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

# ── Launch ingest ──────────────────────────────────────────────────────────────

echo "[$(date '+%Y-%m-%d %H:%M')] START: $INGEST_FILE" >> "$LOG_FILE"

cd "$WIKI_DIR"

# OPENAI_API_KEY must be set in environment (loaded from macOS Keychain via ~/.zshrc)
if [[ -z "${OPENAI_API_KEY:-}" ]]; then
  OPENAI_API_KEY=$(security find-generic-password -a "openai" -s "OPENAI_API_KEY" -w 2>/dev/null || true)
  export OPENAI_API_KEY
fi

python3 "$INGEST_PY" "$INGEST_FILE" >> "$LOG_FILE" 2>&1
EXIT_CODE=$?

if [[ $EXIT_CODE -eq 0 ]]; then
  echo "[$(date '+%Y-%m-%d %H:%M')] DONE: $INGEST_FILE" >> "$LOG_FILE"
else
  echo "[$(date '+%Y-%m-%d %H:%M')] FAILED (exit $EXIT_CODE): $INGEST_FILE" >> "$LOG_FILE"
fi
