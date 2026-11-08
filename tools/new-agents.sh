#!/usr/bin/env bash
# new-agents.sh - ask a few questions, then build an AGENTS.md that lists the
# contracts a project uses, plus a zip of AGENTS.md and those contracts.
#
# Usage: bash tools/new-agents.sh [output-dir]      (default: current dir)
# Output: <output-dir>/<YYYYMMDDTHHMMSS>-AGENTS.zip  (unzip at project root:
#                                                    AGENTS.md + contracts/)
set -euo pipefail

# Public home of these contracts; cited in AGENTS.md and A.G.P disclosures. Edit once.
CONTRACTS_URL="https://github.com/idgarad/Generic-Contracts"

SRC="$(cd "$(dirname "$0")/../contracts" && pwd)"
mkdir -p "${1:-.}"
DEST="$(cd "${1:-.}" && pwd)"
STAMP="$(date +%Y%m%dT%H%M%S)"
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT
SEL=""

field() { sed -n "s/^$1: *//p" "$2" | head -n1 | tr -d '\r'; }
ask()   { local a; read -r -p "$1 [$2]: " a; printf '%s' "${a:-$2}"; }
add()   { case " $SEL " in *" $1 "*) ;; *) SEL="$SEL $1" ;; esac; }
has()   { printf '%s\n' $SEL | grep -q "^$1"; }

# pick TITLE DEFAULT DIR...: one numbered menu over the DIRs. Hidden: files
# starting with _ (pulled in through "requires") and files outside the chosen
# domains. A file's domain is its "domain:" field, else inferred from its folder.
pick() {
  local title="$1" def="$2" files=() f d dom i=1 sel n
  shift 2
  for d in "$@"; do
    for f in "$SRC/$d"/[!_]*.md; do
      [ -e "$f" ] || continue
      dom="$(field domain "$f")"
      if [ -z "$dom" ]; then
        case "$d" in *software*) dom=software ;; *literature*) dom=literature ;; *) dom=any ;; esac
      fi
      case " any $DOMS " in *" $dom "*) files+=("$f") ;; esac
    done
  done
  [ ${#files[@]} -gt 0 ] || return 0
  echo; echo "$title"
  for f in "${files[@]}"; do
    printf '  %2d) %-22s %s\n' "$i" "$(basename "$f" .md)" "$(field summary "$f")"
    i=$((i + 1))
  done
  read -r -p "  Numbers separated by spaces, a = all, Enter = $def: " sel
  sel="${sel:-$def}"
  if [ "$sel" = a ] || [ "$sel" = all ]; then sel="$(seq 1 ${#files[@]})"; fi
  for n in $sel; do
    if [ "$n" -ge 1 ] 2>/dev/null && [ "$n" -le ${#files[@]} ]; then
      add "${files[$((n - 1))]#"$SRC"/}"
    fi
  done
}

resolve() { # contract ID -> path relative to SRC
  local f
  f="$(grep -rlE --include='*.md' "^id: $1[[:space:]]*\$" "$SRC" | head -n1 || true)"
  if [ -n "$f" ]; then printf '%s' "${f#"$SRC"/}"; fi
}

mkzip() { # run inside $STAGE; $1 = absolute zip path
  if command -v zip >/dev/null 2>&1; then
    zip -qr "$1" AGENTS.md contracts
  elif python3 -c '' >/dev/null 2>&1; then
    python3 -m zipfile -c "$1" AGENTS.md contracts
  elif python -c '' >/dev/null 2>&1; then
    python -m zipfile -c "$1" AGENTS.md contracts
  elif command -v powershell.exe >/dev/null 2>&1; then
    powershell.exe -NoProfile -Command \
      "Compress-Archive -Path AGENTS.md,contracts -DestinationPath '$(cygpath -w "$1")' -Force"
  else
    echo "No zip tool found (zip, python, or powershell)." >&2; return 1
  fi
}

# --- Interview ---------------------------------------------------------------
# Question 1 decides which domains every later menu shows.
echo "AGENTS.md builder (contracts from $SRC)"
echo "Is this a software project or a literary project?"
echo "  1) software  2) literary  3) both  4) neither (core + workflow only)"
DOM="$(ask 'Project type' 1)"
case "$DOM" in
  1) DOMS=software ;; 2) DOMS=literature ;; 3) DOMS="software literature" ;; *) DOMS="" ;;
esac
NAME="$(ask 'Project name' "$(basename "$DEST")")"
SCALE=1
case " $DOMS " in *" software "*)
  echo "Scale: 1) solo  2) team  3) enterprise"
  SCALE="$(ask 'Scale' 1)" ;;
esac
MULTI="$(ask 'Will several agents work on this project? (y/n)' n)"

for f in "$SRC"/core/*.md; do add "${f#"$SRC"/}"; done
for f in binding planning records state workspace; do add "workflow/$f.md"; done
if [ "$SCALE" = 3 ]; then add workflow/enterprise.md; fi
case "$MULTI" in y|Y*) for f in "$SRC"/multi-agent/*.md; do add "${f#"$SRC"/}"; done ;; esac

if [ "$SCALE" = 3 ]; then ORGDEF=all; else ORGDEF=none; fi
pick "Organization template (company rules; fill in before use):" "$ORGDEF" organization
pick "Software contracts:" all software
pick "Literature contracts:" all literature
pick "Roles and simulated personas (used only when assigned):" none \
  roles/software roles/literature roles/simulated
pick "Tools this project uses:" none \
  integrations/software integrations/literature integrations/general
pick "Agents used on this project:" none providers

# --- Pull in required contracts ------------------------------------------------
changed=1
while [ "$changed" = 1 ]; do
  changed=0
  for f in $SEL; do
    for r in $(field requires "$SRC/$f" | tr -d '[],'); do
      p="$(resolve "$r")"
      if [ -z "$p" ]; then echo "warning: $f requires unknown $r" >&2; continue; fi
      case " $SEL " in *" $p "*) ;; *) SEL="$SEL $p"; changed=1 ;; esac
    done
  done
done

# --- Write AGENTS.md -------------------------------------------------------------
header() { echo; echo '| ID | File | Summary |'; echo '|---|---|---|'; }
group() {
  local f
  for f in $SEL; do
    case "$f" in $1)
      printf '| %s | `%s` | %s |\n' "$(field id "$SRC/$f")" "$f" "$(field summary "$SRC/$f")" ;;
    esac
  done | sort
}

{
  echo "# AGENTS.md: $NAME"
  echo
  echo "<!-- Generated $STAMP by new-agents.sh -->"
  echo
  echo "File paths below are relative to \`contracts/\`. Use only the contracts listed here."
  echo "Contracts source: $CONTRACTS_URL"
  echo
  echo "1. Read every **Core** and **Organization** contract before any work."
  echo "2. Read a **When relevant** contract only when the task touches its subject."
  echo "3. Adopt a **Role** only when the human assigns it (e.g. \"act as QA\"), then read that file."
  echo "4. Read a **Tools** contract before using that tool."
  echo "5. Precedence: tool/system instructions > core > organization > workflow > domain > tools > multi-agent > role > provider. Lower layers may tighten rules, never weaken them."
  echo
  echo "## Core"; header; group 'core/*'
  if has organization/; then echo; echo "## Organization"; header; group 'organization/*'; fi
  echo; echo "## When relevant"; header
  group 'workflow/*'; group 'software/*'; group 'literature/*'; group 'multi-agent/*'
  if has integrations/; then echo; echo "## Tools"; header; group 'integrations/*'; fi
  if has roles/; then echo; echo "## Roles (on request)"; header; group 'roles/*'; fi
  if has providers/; then echo; echo "## Providers"; header; group 'providers/*'; fi
  echo; echo "## Project rules"; echo; echo "- None yet. Keep additions short; prefer editing a contract."
} > "$STAGE/AGENTS.md"

for f in $SEL; do
  mkdir -p "$STAGE/contracts/$(dirname "$f")"
  cp "$SRC/$f" "$STAGE/contracts/$f"
done
mkdir -p "$STAGE/contracts/tools"
cp "$SRC"/tools/* "$STAGE/contracts/tools/"   # chat-save / chat-check (CORE-AUDIT)

(cd "$STAGE" && mkzip "$DEST/$STAMP-AGENTS.zip")

echo
echo "Wrote $DEST/$STAMP-AGENTS.zip ($(echo $SEL | wc -w | tr -d ' ') contracts)"
echo "Unzip at the project root to get AGENTS.md and contracts/."
if has organization/; then echo "  Fill in contracts/organization/company.md before agents use it."; fi
for f in $SEL; do
  case "$f" in providers/*)
    s="$(field shim "$SRC/$f")"
    if [ -n "$s" ]; then echo "  $(field id "$SRC/$f"): $s"; fi ;;
  esac
done
