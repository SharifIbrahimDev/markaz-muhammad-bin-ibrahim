$ErrorActionPreference = 'Stop'

$scriptDir = $PSScriptRoot
$kutubDir = Split-Path -Parent $scriptDir
$workspace = Split-Path -Parent $kutubDir

$htmlPath = Join-Path $scriptDir "5_umdat_al_muwahhid.html"
$pdfDir = Join-Path $kutubDir "pdf_editions"
$pdfPath = Join-Path $pdfDir "5_umdat_al_muwahhid.pdf"
$webPdfPath = Join-Path $workspace "web\pdf\5_umdat_al_muwahhid.pdf"
$webHtmlPath = Join-Path $workspace "web\books_html\5_umdat_al_muwahhid.html"

if (-not (Test-Path $pdfDir)) { New-Item -ItemType Directory -Path $pdfDir -Force | Out-Null }
if (Test-Path $pdfPath) { Remove-Item $pdfPath -Force }
if (Test-Path $webPdfPath) { Remove-Item $webPdfPath -Force }

$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edgePath)) {
    $edgePath = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}

Write-Host "Compiling Book 5 PDF with Book 1 CSS Margin Boxes architecture..."
$argString = "--headless --no-sandbox --disable-gpu --disable-software-rasterizer --no-pdf-header-footer `"--print-to-pdf=$pdfPath`" `"$htmlPath`""
$proc = Start-Process -FilePath $edgePath -ArgumentList $argString -Wait -PassThru -NoNewWindow
Write-Host "Process Exit Code: $($proc.ExitCode)"

if (Test-Path $pdfPath) {
    $pdfItem = Get-Item $pdfPath
    Write-Host "SUCCESS: Book 5 PDF compiled!"
    Write-Host "Size: $($pdfItem.Length) bytes ($([Math]::Round($pdfItem.Length / 1MB, 2)) MB)"
    
    Copy-Item -Path $pdfPath -Destination $webPdfPath -Force
    Write-Host "Web PDF synced to: $webPdfPath"

    Copy-Item -Path $htmlPath -Destination $webHtmlPath -Force
    Write-Host "Web HTML synced to: $webHtmlPath"

    $bytes = [System.IO.File]::ReadAllBytes($pdfPath)
    $text = [System.Text.Encoding]::ASCII.GetString($bytes)
    $matches = [regex]::Matches($text, "/Type\s*/Page[^s]")
    Write-Host "Total Pages: $($matches.Count)"
} else {
    Write-Host "ERROR: PDF file was not created."
}
