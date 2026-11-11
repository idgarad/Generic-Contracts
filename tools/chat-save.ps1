<#
.SYNOPSIS
  Force-save a chat into the audit archive (CORE-AUDIT), gzipped.
.DESCRIPTION
  -Path <file> saves that transcript; -Path - reads stdin or pipeline input.
  With no -Path, the agent's native transcript is located (claude, codex/chatgpt).
  -NativeOnly prints the native transcript path that would be saved.
  Writes .ai\archive\<agent>\<yyyyMMddTHHmmss>-<topic>.<ext>.gz. Never overwrites;
  duplicate copies are fine. $env:AI_ARCHIVE_DIR overrides .ai\archive.
.EXAMPLE
  powershell -ExecutionPolicy Bypass -File tools\chat-save.ps1 -Agent claude -Topic chapter1
#>
param([string]$Agent = 'claude', [string]$Topic = 'chat', [string]$Path = '', [switch]$NativeOnly)
$ErrorActionPreference = 'Stop'
$Root  = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$Agent = $Agent.ToLower()
$Topic = $Topic -replace '[^A-Za-z0-9._-]', '-'

function Find-Native {
  if ($Agent -eq 'claude') {
    # ~/.claude/projects/<project path with non-alphanumerics as ->/*.jsonl
    $key = $Root -replace '[^A-Za-z0-9]', '-'
    $dir = Get-ChildItem (Join-Path $HOME '.claude\projects') -Directory -ErrorAction SilentlyContinue |
      Where-Object { $_.Name -eq $key } | Select-Object -First 1
    if ($dir) {
      Get-ChildItem $dir.FullName -Filter *.jsonl -File | Sort-Object LastWriteTime -Descending |
        Select-Object -First 1 -ExpandProperty FullName
    }
  } elseif ($Agent -in 'codex', 'chatgpt') {
    # newest Codex session whose recorded cwd (line 1) is this project or below
    $want = ($Root -replace '\\', '/').TrimEnd('/').ToLower()
    Get-ChildItem (Join-Path $HOME '.codex\sessions') -Recurse -Filter *.jsonl -File -ErrorAction SilentlyContinue |
      Sort-Object LastWriteTime -Descending |
      Where-Object {
        $line = Get-Content -LiteralPath $_.FullName -TotalCount 1
        if ($line -match '"cwd":"([^"]*)"') {
          $c = ($Matches[1] -replace '\\\\', '/' -replace '\\', '/').TrimEnd('/').ToLower()
          $c -eq $want -or $c.StartsWith("$want/")
        } else { $false }
      } | Select-Object -First 1 -ExpandProperty FullName
  }
}

function Read-Shared($File) { # read even while the agent still has the file open
  $fs = New-Object IO.FileStream($File, 'Open', 'Read', 'ReadWrite')
  try { $ms = New-Object IO.MemoryStream; $fs.CopyTo($ms); $ms.ToArray() } finally { $fs.Dispose() }
}

if ($NativeOnly) { Find-Native; exit 0 }

if ($Path -eq '-') {
  $text = @($input) -join "`n"
  if (-not $text) { $text = [Console]::In.ReadToEnd() }
  $bytes = (New-Object Text.UTF8Encoding($false)).GetBytes($text); $ext = 'md'; $from = 'stdin'
} elseif ($Path) {
  $full = (Resolve-Path $Path).Path
  $bytes = Read-Shared $full; $from = $full
  $ext = [IO.Path]::GetExtension($full).TrimStart('.'); if (-not $ext) { $ext = 'txt' }
} else {
  $full = Find-Native
  if (-not $full) { Write-Error "No native transcript found for '$Agent'. Pass -Path <file>, or -Path - for stdin." }
  $bytes = Read-Shared $full; $ext = 'jsonl'; $from = $full
}

$base = if ($env:AI_ARCHIVE_DIR) { $env:AI_ARCHIVE_DIR } else { Join-Path $Root '.ai\archive' }
$dir  = Join-Path $base $Agent
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$stem = Join-Path $dir ((Get-Date -Format 'yyyyMMddTHHmmss') + "-$Topic")
$out = "$stem.$ext.gz"; $i = 2
if ($ext -eq 'gz') { $out = "$stem.gz" }
while (Test-Path -LiteralPath $out) { $out = if ($ext -eq 'gz') { "$stem-$i.gz" } else { "$stem-$i.$ext.gz" }; $i++ }

if ($ext -eq 'gz') { [IO.File]::WriteAllBytes($out, $bytes) }
else {
  $fs = [IO.File]::Create($out)
  try {
    $gz = New-Object IO.Compression.GZipStream($fs, [IO.Compression.CompressionMode]::Compress)
    try { $gz.Write($bytes, 0, $bytes.Length) } finally { $gz.Dispose() }
  } finally { $fs.Dispose() }
}
Write-Output "Saved $out ($((Get-Item -LiteralPath $out).Length) bytes) from $from"
