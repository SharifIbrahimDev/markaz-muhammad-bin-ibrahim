$scriptDir = $PSScriptRoot
$kutubDir = Split-Path -Parent $scriptDir
$mdPath = Join-Path $kutubDir "manuscripts\1_ad_durar_al_bahiyyah.md"
$patPath = Join-Path $scriptDir "matn_patterns.txt"

$lines = [System.IO.File]::ReadAllLines($mdPath, [System.Text.Encoding]::UTF8)
$patterns = [System.IO.File]::ReadAllLines($patPath, [System.Text.Encoding]::UTF8)

# Strip diacritics
$tashkeelRegex = [regex]::new("[\u064B-\u0652\u0670]")

$cleanPatterns = @()
foreach ($p in $patterns) {
    $cp = $tashkeelRegex.Replace($p.Trim(), "")
    if ($cp.Length -gt 0) {
        $cleanPatterns += $cp
    }
}

$out = [System.Collections.Generic.List[string]]::new()

for ($i = 0; $i -lt $lines.Length; $i++) {
    $rawLine = $lines[$i]
    $cleanLine = $tashkeelRegex.Replace($rawLine, "")
    foreach ($cp in $cleanPatterns) {
        if ($cleanLine.IndexOf($cp, [System.StringComparison]::OrdinalIgnoreCase) -ge 0) {
            $out.Add(($i + 1).ToString() + ": " + $rawLine)
            break
        }
    }
}

[System.IO.File]::WriteAllLines((Join-Path $scriptDir "matn_scan.txt"), $out, [System.Text.Encoding]::UTF8)
Write-Host "Found $($out.Count) structural matches"
