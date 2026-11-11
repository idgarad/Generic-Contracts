#!/usr/bin/env bash
# chat-save.sh - force-save a chat into the audit archive (CORE-AUDIT), gzipped.
# Usage: bash tools/chat-save.sh [-a agent] [-t topic] [-n] [file|-]
#   file : transcript to save; - reads stdin. Omitted: the agent's native
#          transcript is located (claude, codex/chatgpt); others need a file.
#   -n   : only print the native transcript path that would be saved.
# Writes .ai/archive/<agent>/<YYYYMMDDTHHMMSS>-<topic>.<ext>.gz. Never
# overwrites; duplicate copies are fine. AI_ARCHIVE_DIR overrides .ai/archive.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
AGENT=claude TOPIC=chat PRINT=0
while getopts "a:t:nh" o; do
  case "$o" in
    a) AGENT="$OPTARG" ;; t) TOPIC="$OPTARG" ;; n) PRINT=1 ;;
    *) sed -n '2,9p' "$0"; exit 0 ;;
  esac
done
shift $((OPTIND - 1))
IN="${1:-}"
AGENT="$(printf '%s' "$AGENT" | tr 'A-Z' 'a-z')"
TOPIC="$(printf '%s' "$TOPIC" | tr -c 'A-Za-z0-9._-' '-')"
lower() { printf '%s' "$1" | tr 'A-Z' 'a-z'; }

newest() { # newest file among paths read from stdin
  local f best=""
  while IFS= read -r f; do
    if [ -z "$best" ] || [ "$f" -nt "$best" ]; then best="$f"; fi
  done
  printf '%s' "$best"
}

winpath() { if command -v cygpath >/dev/null 2>&1; then cygpath "$1" "$ROOT"; else printf '%s' "$ROOT"; fi; }

native() { # path of the newest native transcript for this project, or nothing
  local key d want
  case "$AGENT" in
    claude) # ~/.claude/projects/<project path with non-alphanumerics as ->/*.jsonl
      key="$(lower "$(winpath -w | sed 's/[^A-Za-z0-9]/-/g')")"
      for d in "$HOME"/.claude/projects/*/; do
        if [ "$(lower "$(basename "$d")")" = "$key" ]; then
          find "$d" -maxdepth 1 -name '*.jsonl' | newest; return 0
        fi
      done ;;
    codex|chatgpt) # newest Codex session whose recorded cwd (line 1) is this project or below
      want="$(lower "$(winpath -m)")"; want="${want%/}"
      find "$HOME/.codex/sessions" -name '*.jsonl' 2>/dev/null | while IFS= read -r f; do
        c="$(head -n1 "$f" | grep -o '"cwd":"[^"]*"' | head -n1 \
             | sed 's/^"cwd":"//; s/"$//; s/\\\\/\//g; s/\\/\//g' || true)"
        c="$(lower "${c%/}")"
        case "$c" in "$want"|"$want"/*) printf '%s\n' "$f" ;; esac
      done | newest ;;
  esac
}

if [ "$PRINT" = 1 ]; then native; echo; exit 0; fi

if [ "$IN" = - ]; then SRCDESC=stdin; EXT=md; IN=/dev/stdin
elif [ -n "$IN" ]; then
  SRCDESC="$IN"
  case "$(basename "$IN")" in *.*) EXT="${IN##*.}" ;; *) EXT=txt ;; esac
else
  IN="$(native)"
  if [ -z "$IN" ]; then
    echo "No native transcript found for '$AGENT'. Pass a file, or - for stdin." >&2; exit 1
  fi
  SRCDESC="$IN"; EXT=jsonl
fi

DIR="${AI_ARCHIVE_DIR:-$ROOT/.ai/archive}/$AGENT"
mkdir -p "$DIR"
BASE="$DIR/$(date +%Y%m%dT%H%M%S)-$TOPIC"
OUT="$BASE.$EXT.gz"; i=2
while [ -e "$OUT" ]; do OUT="$BASE-$i.$EXT.gz"; i=$((i + 1)); done

if [ "$EXT" = gz ]; then OUT="${OUT%.gz.gz}.gz"; cp "$IN" "$OUT"; else gzip -9c < "$IN" > "$OUT"; fi
echo "Saved $OUT ($(wc -c < "$OUT" | tr -d ' ') bytes) from $SRCDESC"
