$ErrorActionPreference = 'Stop'
$scriptDir = $PSScriptRoot
$html = Join-Path $scriptDir "test_css_paged.html"
$pdf = Join-Path $scriptDir "test_css_paged.pdf"
$tmp = Join-Path $scriptDir "edge_temp_paged"

$edge = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edge)) { $edge = "C:\Program Files\Microsoft\Edge\Application\msedge.exe" }

$fileUrl = (New-Object System.Uri($html)).AbsoluteUri
Write-Host "Running Edge to compile test PDF from $fileUrl..."
$args = @(
    "--headless=new",
    "--disable-gpu",
    "--no-sandbox",
    "--user-data-dir=$tmp",
    "--no-pdf-header-footer",
    "--print-to-pdf=$pdf",
    $fileUrl
)

$p = Start-Process -FilePath $edge -ArgumentList $args -PassThru -Wait
Write-Host "Exit code: $($p.ExitCode)"
Write-Host "PDF created: $(Test-Path $pdf)"
if (Test-Path $pdf) {
    Write-Host "PDF size: $((Get-Item $pdf).Length) bytes"
}
