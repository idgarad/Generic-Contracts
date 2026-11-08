<#
.SYNOPSIS
  Ask a few questions, then build an AGENTS.md that lists the contracts a
  project uses, plus a zip of AGENTS.md and those contracts.
.DESCRIPTION
  PowerShell port of new-agents.sh. Works on Windows PowerShell 5.1 and PowerShell 7+.
  Output: <OutDir>\<yyyyMMddTHHmmss>-AGENTS.zip  (unzip at project root: AGENTS.md + contracts/)
.EXAMPLE
  powershell -ExecutionPolicy Bypass -File tools\new-agents.ps1 -OutDir C:\src\myproject
#>
param([string]$OutDir = '.')
$ErrorActionPreference = 'Stop'
# Public home of these contracts; cited in AGENTS.md and A.G.P disclosures. Edit once.
$ContractsUrl = 'https://github.com/idgarad/Generic-Contracts'
Add-Type -AssemblyName System.IO.Compression, System.IO.Compression.FileSystem

$Src   = (Resolve-Path (Join-Path $PSScriptRoot '..\contracts')).Path
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
$Dest  = (Resolve-Path $OutDir).Path
$Stamp = Get-Date -Format 'yyyyMMddTHHmmss'
$Sel   = New-Object System.Collections.Generic.List[string]   # paths relative to $Src, '/' separated

function Get-Rel($File) { $File.FullName.Substring($Src.Length + 1).Replace('\', '/') }

function Get-Field($Name, $Rel) {
  foreach ($line in Get-Content -LiteralPath (Join-Path $Src $Rel)) {
    if ($line -match "^${Name}:\s*(.*)$") { return $Matches[1].Trim() }
  }
  return ''
}

function Ask($Prompt, $Default) {
  $a = Read-Host "$Prompt [$Default]"
  if ($a) { $a } else { $Default }
}

function Add-Sel($Rel) { if (-not $Sel.Contains($Rel)) { $Sel.Add($Rel) } }

function Get-Md($Dir) {
  $path = Join-Path $Src $Dir
  if (-not (Test-Path -LiteralPath $path)) { return @() }
  @(Get-ChildItem -LiteralPath $path -File | Where-Object { $_.Extension -eq '.md' } | Sort-Object Name)
}

# One numbered menu over the Dirs. Hidden: files starting with _ (pulled in through "requires")
# and files outside the chosen domains. A file's domain is its "domain:" field, else inferred
# from its folder.
function Pick($Title, $Default, [string[]]$Dirs) {
  $files = @()
  foreach ($d in $Dirs) {
    foreach ($f in Get-Md $d | Where-Object { $_.Name -notlike '_*' }) {
      $dom = Get-Field 'domain' (Get-Rel $f)
      if (-not $dom) {
        if ($d -like '*software*') { $dom = 'software' }
        elseif ($d -like '*literature*') { $dom = 'literature' }
        else { $dom = 'any' }
      }
      if ($dom -eq 'any' -or $Doms -contains $dom) { $files += $f }
    }
  }
  if ($files.Count -eq 0) { return }
  Write-Host ''
  Write-Host $Title
  for ($i = 0; $i -lt $files.Count; $i++) {
    Write-Host ('  {0,2}) {1,-22} {2}' -f ($i + 1), $files[$i].BaseName, (Get-Field 'summary' (Get-Rel $files[$i])))
  }
  $answer = Read-Host "  Numbers separated by spaces, a = all, Enter = $Default"
  if (-not $answer) { $answer = $Default }
  if ($answer -eq 'a' -or $answer -eq 'all') { $nums = 1..$files.Count } else { $nums = $answer -split '[\s,]+' }
  foreach ($n in $nums) {
    $k = 0
    if ([int]::TryParse("$n", [ref]$k) -and $k -ge 1 -and $k -le $files.Count) { Add-Sel (Get-Rel $files[$k - 1]) }
  }
}

# --- Interview ---------------------------------------------------------------
# Question 1 decides which domains every later menu shows.
Write-Host "AGENTS.md builder (contracts from $Src)"
Write-Host 'Is this a software project or a literary project?'
Write-Host '  1) software  2) literary  3) both  4) neither (core + workflow only)'
$Dom  = Ask 'Project type' '1'
$Doms = switch ($Dom) { '1' { @('software') } '2' { @('literature') } '3' { @('software', 'literature') } default { @() } }
$Name = Ask 'Project name' (Split-Path $Dest -Leaf)
$Scale = '1'
if ($Doms -contains 'software') {
  Write-Host 'Scale: 1) solo  2) team  3) enterprise'
  $Scale = Ask 'Scale' '1'
}
$Multi = Ask 'Will several agents work on this project? (y/n)' 'n'

foreach ($f in Get-Md 'core') { Add-Sel (Get-Rel $f) }
foreach ($w in 'binding', 'planning', 'records', 'state', 'workspace') { Add-Sel "workflow/$w.md" }
if ($Scale -eq '3') { Add-Sel 'workflow/enterprise.md' }
if ($Multi -like 'y*') { foreach ($f in Get-Md 'multi-agent') { Add-Sel (Get-Rel $f) } }

$OrgDef = if ($Scale -eq '3') { 'all' } else { 'none' }
Pick 'Organization template (company rules; fill in before use):' $OrgDef @('organization')
Pick 'Software contracts:' 'all' @('software')
Pick 'Literature contracts:' 'all' @('literature')
Pick 'Roles and simulated personas (used only when assigned):' 'none' @('roles/software', 'roles/literature', 'roles/simulated')
Pick 'Tools this project uses:' 'none' @('integrations/software', 'integrations/literature', 'integrations/general')
Pick 'Agents used on this project:' 'none' @('providers')

# --- Pull in required contracts ----------------------------------------------
$Index = @{}
Get-ChildItem -LiteralPath $Src -Recurse -File | Where-Object { $_.Extension -eq '.md' } | ForEach-Object {
  $r = Get-Rel $_
  $id = Get-Field 'id' $r
  if ($id) { $Index[$id] = $r }
}
do {
  $changed = $false
  foreach ($f in @($Sel)) {
    $req = (Get-Field 'requires' $f).Trim('[', ']', ' ')
    foreach ($r in ($req -split '\s*,\s*' | Where-Object { $_ })) {
      if (-not $Index.ContainsKey($r)) { Write-Warning "$f requires unknown $r"; continue }
      if (-not $Sel.Contains($Index[$r])) { $Sel.Add($Index[$r]); $changed = $true }
    }
  }
} while ($changed)

# --- Write AGENTS.md ---------------------------------------------------------
$Header = @('', '| ID | File | Summary |', '|---|---|---|')
function Rows($Prefix) {
  @($Sel | Where-Object { $_ -like "$Prefix*" } | ForEach-Object {
    '| {0} | `{1}` | {2} |' -f (Get-Field 'id' $_), $_, (Get-Field 'summary' $_)
  } | Sort-Object)
}
function Has($Prefix) { [bool]($Sel | Where-Object { $_ -like "$Prefix*" }) }

$out = New-Object System.Collections.Generic.List[string]
function Emit { foreach ($a in $args) { foreach ($l in @($a)) { if ($null -ne $l) { $out.Add([string]$l) } } } }
function Section($Title, $Prefix) { if (Has $Prefix) { Emit '' "## $Title" $Header (Rows $Prefix) } }

Emit @(
  "# AGENTS.md: $Name", '',
  "<!-- Generated $Stamp by new-agents.ps1 -->", '',
  'File paths below are relative to `contracts/`. Use only the contracts listed here.',
  "Contracts source: $ContractsUrl", '',
  '1. Read every **Core** and **Organization** contract before any work.',
  '2. Read a **When relevant** contract only when the task touches its subject.',
  '3. Adopt a **Role** only when the human assigns it (e.g. "act as QA"), then read that file.',
  '4. Read a **Tools** contract before using that tool.',
  '5. Precedence: tool/system instructions > core > organization > workflow > domain > tools > multi-agent > role > provider. Lower layers may tighten rules, never weaken them.',
  '', '## Core')
Emit $Header (Rows 'core/')
Section 'Organization' 'organization/'
Emit '' '## When relevant' $Header
foreach ($p in 'workflow/', 'software/', 'literature/', 'multi-agent/') { Emit (Rows $p) }
Section 'Tools' 'integrations/'
Section 'Roles (on request)' 'roles/'
Section 'Providers' 'providers/'
Emit '' '## Project rules' '' '- None yet. Keep additions short; prefer editing a contract.'

$zipPath = Join-Path $Dest "$Stamp-AGENTS.zip"

# ZipArchive with explicit '/' entry names (Compress-Archive on 5.1 can write '\').
# AGENTS.md is written straight into the zip; no loose copy.
$zip = [IO.Compression.ZipFile]::Open($zipPath, 'Create')
try {
  $w = New-Object System.IO.StreamWriter($zip.CreateEntry('AGENTS.md').Open(), (New-Object System.Text.UTF8Encoding($false)))
  try { $w.Write(($out -join "`n") + "`n") } finally { $w.Dispose() }
  foreach ($f in $Sel) {
    [void][IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, (Join-Path $Src $f), "contracts/$f")
  }
  foreach ($t in Get-ChildItem (Join-Path $Src 'tools') -File) {   # chat-save / chat-check (CORE-AUDIT)
    [void][IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $t.FullName, "contracts/tools/$($t.Name)")
  }
} finally { $zip.Dispose() }

Write-Host ''
Write-Host "Wrote $zipPath ($($Sel.Count) contracts)"
Write-Host 'Unzip at the project root to get AGENTS.md and contracts/.'
if (Has 'organization/') { Write-Host '  Fill in contracts/organization/company.md before agents use it.' }
foreach ($f in $Sel | Where-Object { $_ -like 'providers/*' }) {
  $s = Get-Field 'shim' $f
  if ($s) { Write-Host "  $(Get-Field 'id' $f): $s" }
}
