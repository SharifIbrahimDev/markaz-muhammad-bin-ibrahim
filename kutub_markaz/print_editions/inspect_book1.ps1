$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem

$pdfPath = Join-Path (Resolve-Path "kutub_markaz\pdf_editions").Path "1_ad_durar_al_bahiyyah.pdf"
$bytes = [System.IO.File]::ReadAllBytes($pdfPath)
$text = [System.Text.Encoding]::ASCII.GetString($bytes)

Write-Host "PDF size: $($bytes.Length) bytes"
Write-Host "Page count matches: $(( [regex]::Matches($text, '/Type\s*/Page[^s]') ).Count)"

# Check if there are uncompressed text streams or stream objects
$streams = [regex]::Matches($text, 'stream[\r\n]+([\s\S]*?)[\r\n]+endstream')
Write-Host "Found streams: $($streams.Count)"

$sampleCount = 0
foreach ($m in $streams) {
    $rawStream = $m.Groups[1].Value
    # Try ASCII
    if ($rawStream -match '\(([^\)]+)\)\s*Tj' -or $rawStream -match '\[([^\]]+)\]\s*TJ') {
        Write-Host "Text found in stream: $($matches[1])"
        $sampleCount++
        if ($sampleCount -ge 10) { break }
    }
}
