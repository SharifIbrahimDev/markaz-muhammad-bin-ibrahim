$ErrorActionPreference = 'Stop'

$parts = @(
    'part01_muqaddimah_tamheed_madakhil.md',
    'part02_matn_kamil_wa_diwabah_al_maqbul.md',
    'part03_daif_wa_aqsam_al_idhafah.md',
    'part04_sifat_ar_riwayah_wa_turuq_an_naql.md',
    'part05_ilal_al_isnad_as_saqt_wash_shudhudh.md',
    'part06_lataif_al_isnad_al_ilal_al_mardud_ash_shadid.md',
    'part07_qawaid_kulliyyah_wa_faharis_maraji.md'
)

$scriptDir = $PSScriptRoot
$partsDir = Join-Path $scriptDir "parts_bayquniyyah"
$outFile = Join-Path $scriptDir "2_nayl_al_amani.md"

$contentList = foreach ($p in $parts) {
    $filePath = Join-Path $partsDir $p
    Get-Content -Path $filePath -Raw -Encoding UTF8
}

$combined = $contentList -join "`r`n`r`n---`r`n`r`n"
[System.IO.File]::WriteAllText($outFile, $combined, [System.Text.Encoding]::UTF8)

$lines = (Get-Content -Path $outFile -Encoding UTF8).Length
$size = (Get-Item $outFile).Length

Write-Host "Successfully combined parts into 2_nayl_al_amani.md"
Write-Host "Total Lines: $lines"
Write-Host "Total Size: $size bytes ($([Math]::Round($size / 1KB, 2)) KB)"
