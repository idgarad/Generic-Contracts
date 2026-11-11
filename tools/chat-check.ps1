<#
.SYNOPSIS
  Check that chat archiving (CORE-AUDIT) works in this project. Exit code 1 if any check FAILs.
.EXAMPLE
  powershell -ExecutionPolicy Bypass -File tools\chat-check.ps1
#>
$ErrorActionPreference = 'Stop'
$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$Save = Join-Path $PSScriptRoot 'chat-save.ps1'
$script:fails = 0
function Ok($m)   { Write-Host "PASS  $m" }
function Warn($m) { Write-Host "WARN  $m" }
function Bad($m)  { Write-Host "FAIL  $m"; $script:fails++ }

function Expand-Gz($File) {
  $fs = [IO.File]::OpenRead($File)
  try {
    $gz = New-Object IO.Compression.GZipStream($fs, [IO.Compression.CompressionMode]::Decompress)
    $ms = New-Object IO.MemoryStream
    try { $gz.CopyTo($ms) } finally { $gz.Dispose() }
    $ms.ToArray()
  } finally { $fs.Dispose() }
}

try { Add-Type -AssemblyName System.IO.Compression; Ok 'GZip (.NET) available' } catch { Bad 'GZip (.NET) not available' }

try {
  $arc = Join-Path $Root '.ai\archive'
  New-Item -ItemType Directory -Force -Path $arc | Out-Null
  $t = Join-Path $arc ('.check.' + [guid]::NewGuid())
  [IO.File]::WriteAllText($t, 'x'); Remove-Item -LiteralPath $t
  Ok '.ai\archive is writable'
} catch { Bad '.ai\archive is not writable' }

$tmp = Join-Path ([IO.Path]::GetTempPath()) ('chat-check-' + [guid]::NewGuid())
New-Item -ItemType Directory -Path $tmp | Out-Null
try {
  $in = Join-Path $tmp 'in.md'
  [IO.File]::WriteAllText($in, "round-trip test`nline 2`n")
  $env:AI_ARCHIVE_DIR = Join-Path $tmp 'arc'
  & $Save -Agent check -Topic roundtrip -Path $in | Out-Null
  $gzFile = Get-ChildItem (Join-Path $env:AI_ARCHIVE_DIR 'check') -Filter '*-roundtrip.md.gz' | Select-Object -First 1
  $same = $gzFile -and ([Convert]::ToBase64String((Expand-Gz $gzFile.FullName)) -eq [Convert]::ToBase64String([IO.File]::ReadAllBytes($in)))
  if ($same) { Ok 'save + restore round trip matches' } else { Bad 'save + restore round trip failed' }
} catch { Bad "save + restore round trip failed: $_" }
finally { Remove-Item Env:\AI_ARCHIVE_DIR -ErrorAction SilentlyContinue; Remove-Item -Recurse -Force $tmp }

if (Get-Command git -ErrorAction SilentlyContinue) {
  # On 5.1, native stderr under 'Stop' throws even when redirected; judge by exit code only.
  $ErrorActionPreference = 'Continue'
  & git -C $Root rev-parse 2>$null | Out-Null
  $inRepo = $LASTEXITCODE -eq 0
  if ($inRepo) { & git -C $Root check-ignore -q '.ai/archive/x/test.md.gz' 2>$null; $ignored = $LASTEXITCODE -eq 0 }
  $ErrorActionPreference = 'Stop'
  if (-not $inRepo) { Warn 'not a git repository; archives are not version-controlled' }
  elseif ($ignored) { Bad "git ignores .ai/archive/ (add '!/.ai/archive/' to .gitignore; see CORE-AI-FOLDER)" }
  else { Ok 'git tracks .ai/archive/' }
} else { Warn 'git not found; archives are not version-controlled' }

foreach ($a in 'claude', 'codex') {
  $p = & $Save -Agent $a -NativeOnly
  if ($p) { Ok "native $a transcript found: $p" }
  else { Warn "no native $a transcript (fine if $a isn't used here; save from a file instead)" }
}

$n = 0
foreach ($f in Get-ChildItem (Join-Path $Root '.ai\archive') -Recurse -Filter *.gz -File -ErrorAction SilentlyContinue) {
  $n++
  try { Expand-Gz $f.FullName | Out-Null } catch { Bad "corrupt archive: $($f.FullName)" }
}
Ok "$n existing archive(s) checked"

Write-Host ''
if ($script:fails -eq 0) { Write-Host 'Chat archiving OK' } else { Write-Host "$script:fails check(s) failed"; exit 1 }
