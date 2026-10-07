$ErrorActionPreference = 'Stop'

$scriptDir = $PSScriptRoot
$partsDir = Join-Path $scriptDir "parts_umdat_al_muwahhid"
$targetMd = Join-Path $scriptDir "5_umdat_al_muwahhid.md"

$parts = @(
    "part1_muqaddimat_wa_asl_at_tawhid.md",
    "part2_al_khawf_min_ash_shirk_wa_ad_da'wah.md",
    "part3_abwab_ash_shirk_al_asghar_wa_al_asbab.md",
    "part4_ash_shafaah_wa_al_ghuluww_wa_al_qubur.md",
    "part5_ar_riya_at_tataiyur_as_sihr_wa_al_khatimah.md",
    "part6_tawakkul_khawf_qadar_wa_al_khatimah.md",
    "part7_al_ghuluww_wa_al_qubur_wa_as_sihr.md",
    "part8_as_sihr_at_tataiyur_wa_al_ibadat.md",
    "part9_at_tataiyur_al_mahabba_wa_al_khawf.md",
    "part10_al_qadar_al_asma_wa_al_khatimah.md"
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
Write-Host "SUCCESS: Combined Book 5 manuscript written to: $targetMd"
Write-Host "Total Size: $size bytes ($([Math]::Round($size / 1KB, 2)) KB)"
