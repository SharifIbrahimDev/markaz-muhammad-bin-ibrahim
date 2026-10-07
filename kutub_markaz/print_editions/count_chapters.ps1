$filePath = Join-Path $PSScriptRoot "..\manuscripts\5_umdat_al_muwahhid.md"
$lines = [System.IO.File]::ReadAllLines($filePath, [System.Text.Encoding]::UTF8)

$headings = @()
$idx = 0
foreach ($line in $lines) {
    if ($line.StartsWith("## ")) {
        $idx++
        $headings += "$idx : $line"
    }
}

$outPath = Join-Path $PSScriptRoot "headings_list.txt"
[System.IO.File]::WriteAllLines($outPath, $headings, [System.Text.Encoding]::UTF8)
Write-Host "Total headings found: $($headings.Count)"
