$ErrorActionPreference = 'Stop'

$scriptDir = $PSScriptRoot
$partsDir = Join-Path $scriptDir "..\manuscripts\parts_umdat_al_muwahhid"
$masterMd = Join-Path $scriptDir "..\manuscripts\5_umdat_al_muwahhid.md"

$partFiles = @(
    "part1_muqaddimat_wa_asl_at_tawhid.md",
    "part2_al_khawf_min_ash_shirk_wa_ad_da'wah.md",
    "part3_abwab_ash_shirk_al_asghar_wa_al_asbab.md",
    "part4_ash_shafaah_wa_al_ghuluww_wa_al_qubur.md",
    "part5_ar_riya_at_tataiyur_as_sihr_wa_al_khatimah.md",
    "part6_tawakkul_khawf_qadar_wa_al_khatimah.md",
    "part7_al_ghuluww_wa_al_qubur_wa_as_sihr.md",
    "part8_as_sihr_at_tataiyur_wa_al_ibadat.md",
    "part9_at_tataiyur_al_mahabba_wa_al_khawf.md",
    "part10_al_qadar_al_asma_wa_al_khatimah.md",
    "part11_abwab_37_ila_44.md",
    "part12_abwab_45_ila_52.md",
    "part13_abwab_53_ila_60.md",
    "part14_abwab_61_ila_67_wa_al_khatimah.md",
    "part15_maraji_wa_faharis.md"
)

$sb = New-Object System.Text.StringBuilder

foreach ($file in $partFiles) {
    $fullPath = Join-Path $partsDir $file
    if (-not (Test-Path $fullPath)) {
        throw "Part file not found: $fullPath"
    }
    $content = [System.IO.File]::ReadAllText($fullPath, [System.Text.Encoding]::UTF8)
    [void]$sb.AppendLine($content)
    [void]$sb.AppendLine("`n`n---`n`n")
    Write-Host "Appended: $file"
}

[System.IO.File]::WriteAllText($masterMd, $sb.ToString(), [System.Text.Encoding]::UTF8)
$item = Get-Item $masterMd
Write-Host "SUCCESS: Master manuscript written!"
Write-Host "Size: $($item.Length) bytes ($([Math]::Round($item.Length / 1KB, 2)) KB)"
