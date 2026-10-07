$ErrorActionPreference = 'Stop'
$scriptDir = $PSScriptRoot
$cdpScript = Join-Path $scriptDir "compile_pdf_cdp.ps1"
& powershell -ExecutionPolicy Bypass -File $cdpScript
