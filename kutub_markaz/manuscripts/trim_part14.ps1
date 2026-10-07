$path = Join-Path $PSScriptRoot "parts_umdat_al_muwahhid\part14_abwab_61_ila_67_wa_al_khatimah.md"
$lines = [System.IO.File]::ReadAllLines($path, [System.Text.Encoding]::UTF8)
$trimmed = $lines[0..521]
[System.IO.File]::WriteAllLines($path, $trimmed, [System.Text.Encoding]::UTF8)
Write-Host "Trimmed part14 successfully. New line count: $($trimmed.Count)"
