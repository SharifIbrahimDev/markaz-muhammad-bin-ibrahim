# Inspect PDF page count and find chapter page offsets
$pdfFile = Join-Path $PSScriptRoot "..\pdf_editions\5_umdat_al_muwahhid.pdf"

$bytes = [System.IO.File]::ReadAllBytes($pdfFile)
$str = [System.Text.Encoding]::ASCII.GetString($bytes)

$pageMatches = [regex]::Matches($str, '/Type\s*/Page\b')
Write-Host "Total /Type /Page count: $($pageMatches.Count)"

# Let's check with PDF reader in .NET if available or parse Kids / Count in Catalog
$pagesRegex = [regex]::Matches($str, '/Type\s*/Pages\s*/Count\s+(\d+)')
foreach ($m in $pagesRegex) {
    Write-Host "Catalog /Pages Count: $($m.Groups[1].Value)"
}
