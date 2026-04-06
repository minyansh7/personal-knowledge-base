#!/usr/bin/env python3
"""
ingest_openai.py — Minyan's Wiki OpenAI ingest runner

Usage:
    python3 ingest_openai.py <path_to_source_file> [ingest|synthesis]

Models:
    ingest:    gpt-4o
    synthesis: gpt-5

Reads OPENAI_API_KEY from environment. Never hardcodes credentials.
"""

import os
import sys
import json
import urllib.request
import urllib.error
from pathlib import Path

# ── Config ─────────────────────────────────────────────────────────────────────

WIKI_DIR = Path("/Users/minyan/Minyan's Wiki")
INGEST_PROMPT_FILE = WIKI_DIR / ".claude/prompts/ingest.txt"
SYNTHESIS_SKILL_FILE = WIKI_DIR / ".claude/skills/synthesis-builder/SKILL.md"
INGEST_MODEL = "gpt-4o"
SYNTHESIS_MODEL = "gpt-5"
API_URL = "https://api.openai.com/v1/chat/completions"

# ── Key check ──────────────────────────────────────────────────────────────────

def get_api_key() -> str:
    key = os.environ.get("OPENAI_API_KEY", "")
    if not key:
        print("ERROR: OPENAI_API_KEY is not set in environment.", file=sys.stderr)
        print("Run: export OPENAI_API_KEY=$(security find-generic-password -a openai -s OPENAI_API_KEY -w)", file=sys.stderr)
        sys.exit(1)
    if not key.startswith("sk-"):
        print("ERROR: OPENAI_API_KEY does not look valid (should start with sk-).", file=sys.stderr)
        sys.exit(1)
    return key

# ── OpenAI call ────────────────────────────────────────────────────────────────

def call_openai(model: str, system: str, user: str, api_key: str) -> str:
    payload = json.dumps({
        "model": model,
        "messages": [
            {"role": "system", "content": system},
            {"role": "user",   "content": user},
        ],
        "temperature": 0.3,
    }).encode("utf-8")

    req = urllib.request.Request(
        API_URL,
        data=payload,
        headers={
            "Content-Type": "application/json",
            "Authorization": f"Bearer {api_key}",
        },
        method="POST",
    )

    try:
        with urllib.request.urlopen(req, timeout=120) as resp:
            data = json.loads(resp.read().decode("utf-8"))
            return data["choices"][0]["message"]["content"]
    except urllib.error.HTTPError as e:
        body = e.read().decode("utf-8")
        print(f"ERROR: OpenAI API returned {e.code}: {body}", file=sys.stderr)
        sys.exit(1)
    except urllib.error.URLError as e:
        print(f"ERROR: Network error: {e.reason}", file=sys.stderr)
        sys.exit(1)

# ── Counter helpers ────────────────────────────────────────────────────────────

COUNTER_FILE = WIKI_DIR / ".claude/ingest_counter"

def read_counter() -> int:
    if not COUNTER_FILE.exists():
        return 0
    try:
        return int(COUNTER_FILE.read_text().strip())
    except ValueError:
        return 0

def write_counter(value: int):
    COUNTER_FILE.write_text(str(value))

# ── Ingest ─────────────────────────────────────────────────────────────────────

def run_ingest(source_file: Path, api_key: str) -> bool:
    if not INGEST_PROMPT_FILE.exists():
        print(f"ERROR: Prompt file not found: {INGEST_PROMPT_FILE}", file=sys.stderr)
        sys.exit(1)

    system_prompt = INGEST_PROMPT_FILE.read_text()
    source_content = source_file.read_text()

    user_message = f"""The file to ingest is: {source_file}

--- FILE CONTENT START ---
{source_content}
--- FILE CONTENT END ---

Follow the ingest prompt exactly. Run the dedup check, quality gate, write the source note, update index.md, log.md, and ingest_counter. Then report what was done."""

    print(f"[ingest] Calling {INGEST_MODEL} for: {source_file.name}")
    result = call_openai(INGEST_MODEL, system_prompt, user_message, api_key)
    print(result)
    return True

# ── Synthesis ──────────────────────────────────────────────────────────────────

def run_synthesis(api_key: str):
    if not SYNTHESIS_SKILL_FILE.exists():
        print(f"ERROR: Synthesis skill not found: {SYNTHESIS_SKILL_FILE}", file=sys.stderr)
        sys.exit(1)

    skill_content = SYNTHESIS_SKILL_FILE.read_text()

    # Gather all source notes for context
    source_notes_dir = WIKI_DIR / "wiki/source-notes"
    findings_dir = WIKI_DIR / "wiki/Findings"

    source_notes = []
    for f in sorted(source_notes_dir.glob("*.md")):
        source_notes.append(f"=== {f.name} ===\n{f.read_text()}")

    findings = []
    for f in sorted(findings_dir.glob("*.md")):
        findings.append(f"=== {f.name} ===\n{f.read_text()}")

    user_message = f"""Run the full synthesis-builder workflow.

--- SYNTHESIS SKILL ---
{skill_content}

--- EXISTING SOURCE NOTES ---
{"".join(source_notes)}

--- EXISTING FINDINGS PAGES ---
{"".join(findings)}

Apply all three gates (uniqueness, significance, format lock) before writing anything.
Report what was created or updated."""

    print(f"[synthesis] Calling {SYNTHESIS_MODEL}")
    result = call_openai(SYNTHESIS_MODEL, skill_content, user_message, api_key)
    print(result)

# ── Main ───────────────────────────────────────────────────────────────────────

def main():
    if len(sys.argv) < 2:
        print("Usage: ingest_openai.py <source_file_path>", file=sys.stderr)
        sys.exit(1)

    source_file = Path(sys.argv[1])

    if not source_file.exists():
        print(f"ERROR: File not found: {source_file}", file=sys.stderr)
        sys.exit(1)

    api_key = get_api_key()

    # Run ingest
    run_ingest(source_file, api_key)

    # Increment counter
    count = read_counter() + 1
    write_counter(count)
    print(f"[counter] {count}/5")

    # Trigger synthesis at 5
    if count >= 5:
        print("[counter] Threshold reached — running synthesis")
        run_synthesis(api_key)
        write_counter(0)
        print("[counter] Reset to 0")

if __name__ == "__main__":
    main()
