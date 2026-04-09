#!/bin/bash
# watcher.sh — Minyan's Wiki file watcher
# Watches raw/ recursively for new .md files and triggers ingest.sh
# Managed by launchd — do not run directly

WIKI_DIR="/Users/minyan/Minyan's Wiki"
INGEST_SCRIPT="$WIKI_DIR/scripts/ingest.sh"
LOG_FILE="$WIKI_DIR/scripts/watcher.log"
WATCH_DIR="$WIKI_DIR/raw"

export PATH="/usr/local/bin:/Users/minyan/.nvm/versions/node/v24.14.1/bin:$PATH"

echo "[$(date '+%Y-%m-%d %H:%M')] Watcher started. Watching: $WATCH_DIR" >> "$LOG_FILE"

fswatch -r -e ".*" -i "\.md$" --event Created "$WATCH_DIR" | while read -r FILE; do

  # Skip Obsidian internals
  if [[ "$FILE" == *".obsidian"* ]] || [[ "$FILE" == *".DS_Store"* ]]; then
    continue
  fi

  echo "[$(date '+%Y-%m-%d %H:%M')] New file detected: $FILE" >> "$LOG_FILE"

  # Wait 2 seconds for the file to finish writing (Web Clipper delay)
  sleep 2

  # Hand off to ingest.sh
  bash "$INGEST_SCRIPT" "$FILE"

done
