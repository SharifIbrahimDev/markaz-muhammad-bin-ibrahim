$ErrorActionPreference = 'Stop'

$scriptDir = $PSScriptRoot
$partsDir = Join-Path $scriptDir "parts_fath_ar_rahim"
$targetMd = Join-Path $scriptDir "3_fath_ar_rahim_al_mannan.md"

$parts = @(
    "part1_muqaddimat_madakhil.md",
    "part2_muqaddimat_almatn.md",
    "part3_al_asl_al_awwal_ibadat.md",
    "part4_al_asl_ath_thani_maratib_ad_din.md",
    "part5_al_asl_ath_thalith_wa_khatimah.md"
)

$combined = New-Object System.Collections.Generic.List[string]

foreach ($p in $parts) {
    $filePath = Join-Path $partsDir $p
    if (-not (Test-Path $filePath)) {
        throw "Part not found: $filePath"
    }
    Write-Host "Reading: $p"
    $content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
    $combined.Add($content.Trim())
}

$fullText = $combined -join "`r`n`r`n---`r`n`r`n"
[System.IO.File]::WriteAllText($targetMd, $fullText, [System.Text.Encoding]::UTF8)

$size = (Get-Item $targetMd).Length
Write-Host "SUCCESS: Combined Book 3 manuscript written to: $targetMd"
Write-Host "Total Size: $size bytes ($([Math]::Round($size / 1KB, 2)) KB)"
