# Compile Book 5 HTML to PDF using Microsoft Edge Headless (Single Process)
$ErrorActionPreference = "Stop"

$htmlPath = Join-Path $PSScriptRoot "5_umdat_al_muwahhid.html"
$webHtmlPath = Join-Path $PSScriptRoot "..\..\web\books_html\5_umdat_al_muwahhid.html"
$pdfPath = Join-Path $PSScriptRoot "..\pdf_editions\5_umdat_al_muwahhid.pdf"
$webPdfPath = Join-Path $PSScriptRoot "..\..\web\pdf\5_umdat_al_muwahhid.pdf"

if (-not (Test-Path $htmlPath)) {
    throw "HTML file not found: $htmlPath"
}

# Sync HTML to web
Copy-Item -Path $htmlPath -Destination $webHtmlPath -Force
Write-Host "Synced HTML to $webHtmlPath"

# Locate Edge
$edge = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edge)) {
    $edge = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}
if (-not (Test-Path $edge)) {
    throw "Microsoft Edge executable not found."
}

$fullPdf = [System.IO.Path]::GetFullPath($pdfPath)
$fullWebPdf = [System.IO.Path]::GetFullPath($webPdfPath)
$fullHtml = [System.IO.Path]::GetFullPath($htmlPath)
$uri = (New-Object System.Uri($fullHtml)).AbsoluteUri

$tempUser = Join-Path $env:TEMP ("edge_user_" + [System.Guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $tempUser -Force | Out-Null

Write-Host "Building PDF: $fullPdf ..."

$argList = @(
    "--headless",
    "--single-process",
    "--no-sandbox",
    "--disable-gpu",
    "--disable-software-rasterizer",
    "--no-proxy-server",
    "--disable-extensions",
    "--user-data-dir=$tempUser",
    "--print-to-pdf=$fullPdf",
    $uri
)

$proc = Start-Process -FilePath $edge -ArgumentList $argList -PassThru -Wait -NoNewWindow

if (Test-Path $fullPdf) {
    $fileInfo = Get-Item $fullPdf
    $mb = [math]::Round($fileInfo.Length / 1MB, 2)
    Write-Host "SUCCESS: PDF created ($($fileInfo.Length) bytes / $mb MB)"
    
    Copy-Item -Path $fullPdf -Destination $fullWebPdf -Force
    Write-Host "Synced PDF to $fullWebPdf"
} else {
    throw "PDF generation failed: $fullPdf does not exist."
}

# Cleanup temp user data dir
Remove-Item -Path $tempUser -Recurse -Force -ErrorAction SilentlyContinue
