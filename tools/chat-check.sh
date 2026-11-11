#!/usr/bin/env bash
# chat-check.sh - check that chat archiving (CORE-AUDIT) works in this project.
# Usage: bash contracts/tools/chat-check.sh      Exit code 1 if any check FAILs.
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SAVE="$(dirname "$0")/chat-save.sh"
fails=0
ok()   { echo "PASS  $*"; }
warn() { echo "WARN  $*"; }
bad()  { echo "FAIL  $*"; fails=$((fails + 1)); }

if command -v gzip >/dev/null 2>&1; then ok "gzip available"; else bad "gzip not found"; fi

if mkdir -p "$ROOT/.ai/archive" 2>/dev/null && t="$(mktemp "$ROOT/.ai/archive/.check.XXXXXX" 2>/dev/null)"; then
  rm -f "$t"; ok ".ai/archive is writable"
else bad ".ai/archive is not writable"; fi

tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
printf 'round-trip test\nline 2\n' > "$tmp/in.md"
if AI_ARCHIVE_DIR="$tmp/arc" bash "$SAVE" -a check -t roundtrip "$tmp/in.md" >/dev/null 2>&1 \
   && gzip -dc "$tmp"/arc/check/*-roundtrip.md.gz | cmp -s - "$tmp/in.md"; then
  ok "save + restore round trip matches"
else bad "save + restore round trip failed"; fi

if git -C "$ROOT" rev-parse >/dev/null 2>&1; then
  if git -C "$ROOT" check-ignore -q ".ai/archive/x/test.md.gz"; then
    bad "git ignores .ai/archive/ (add '!/.ai/archive/' to .gitignore; see CORE-AI-FOLDER)"
  else ok "git tracks .ai/archive/"; fi
else warn "not a git repository; archives are not version-controlled"; fi

for a in claude codex; do
  p="$(bash "$SAVE" -a "$a" -n 2>/dev/null | head -n1)"
  if [ -n "$p" ]; then ok "native $a transcript found: $p"
  else warn "no native $a transcript (fine if $a isn't used here; save from a file instead)"; fi
done

n=0
while IFS= read -r f; do
  n=$((n + 1))
  gzip -t "$f" 2>/dev/null || bad "corrupt archive: $f"
done < <(find "$ROOT/.ai/archive" -name '*.gz' 2>/dev/null)
ok "$n existing archive(s) checked"

echo; if [ "$fails" -eq 0 ]; then echo "Chat archiving OK"; else echo "$fails check(s) failed"; exit 1; fi
