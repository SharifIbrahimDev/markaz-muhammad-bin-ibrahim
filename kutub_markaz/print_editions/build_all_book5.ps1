# One-stop build script for Book 5
$ErrorActionPreference = "Stop"

$scriptDir = $PSScriptRoot

Write-Host "=== Step 1: Combining all 15 parts into master markdown ==="
& (Join-Path $scriptDir "combine_all_parts_book5.ps1")

Write-Host "`n=== Step 2: Generating clean UTF-8 HTML ==="
& (Join-Path $scriptDir "generate_html_book5.ps1")

Write-Host "`n=== Step 3: Compiling PDF and syncing to web ==="
& (Join-Path $scriptDir "compile_pdf_book5.ps1")

Write-Host "`n=== ALL BOOK 5 ARTIFACTS SUCCESSFULLY BUILT! ==="
