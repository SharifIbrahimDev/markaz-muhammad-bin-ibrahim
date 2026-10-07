$ErrorActionPreference = 'Stop'

$scriptDir = $PSScriptRoot
$partsDir = Join-Path $scriptDir "parts_al_manhal"
$outputFile = Join-Path $scriptDir "4_al_manhal_as_safi.md"

$partFiles = @(
    "part1_muqaddimat_manzumah_tamah.md",
    "part2_qawaid_kubra_1_and_2.md",
    "part3_qawaid_kubra_3_4_5.md",
    "part4_qawaid_takmiliyyah_wa_khatimah.md"
)

$combined = New-Object System.Collections.Generic.List[string]

foreach ($pf in $partFiles) {
    $fullPath = Join-Path $partsDir $pf
    if (-not (Test-Path $fullPath)) {
        throw "Part file not found: $fullPath"
    }
    Write-Host "Reading $pf..."
    $content = [System.IO.File]::ReadAllText($fullPath, [System.Text.Encoding]::UTF8)
    $combined.Add($content.Trim())
}

$fullManuscript = $combined -join "`r`n`r`n---`r`n`r`n"
[System.IO.File]::WriteAllText($outputFile, $fullManuscript, [System.Text.Encoding]::UTF8)

$size = (Get-Item $outputFile).Length
$lines = (Get-Content -Path $outputFile -Encoding UTF8).Length

Write-Host "Successfully merged Book 4 into: $outputFile"
Write-Host "Total Size: $size bytes ($([Math]::Round($size / 1KB, 2)) KB)"
Write-Host "Total Lines: $lines"
