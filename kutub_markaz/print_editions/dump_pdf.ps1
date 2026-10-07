$ErrorActionPreference = 'Stop'

$pdfPath = Join-Path (Resolve-Path "kutub_markaz\pdf_editions").Path "1_ad_durar_al_bahiyyah.pdf"
$bytes = [System.IO.File]::ReadAllBytes($pdfPath)

# Look for /Filter /FlateDecode streams
# A simple regex to find stream start/end indices in bytes
$text = [System.Text.Encoding]::ASCII.GetString($bytes)
$matches = [regex]::Matches($text, 'stream\r?\n')

Write-Host "Found $($matches.Count) streams. Testing decompression..."

function Decompress-Zlib($data, $start, $length) {
    # Skip 2-byte zlib header (usually 0x78 0x9C or 0x78 0x01)
    $ms = New-Object System.IO.MemoryStream($data, $start + 2, $length - 6)
    $ds = New-Object System.IO.Compression.DeflateStream($ms, [System.IO.Compression.CompressionMode]::Decompress)
    $outMs = New-Object System.IO.MemoryStream
    try {
        $ds.CopyTo($outMs)
        return [System.Text.Encoding]::UTF8.GetString($outMs.ToArray())
    } catch {
        return $null
    }
}

$streamMatches = [regex]::Matches($text, '(?s)/Length\s+(\d+).*?stream\r?\n')
Write-Host "Length matches: $($streamMatches.Count)"

$count = 0
foreach ($sm in $streamMatches) {
    $len = [int]$sm.Groups[1].Value
    $streamStart = $sm.Index + $sm.Length
    if ($len -gt 50 -and ($streamStart + $len) -le $bytes.Length) {
        $dec = Decompress-Zlib $bytes $streamStart $len
        if ($dec -and ($dec.Contains("Tj") -or $dec.Contains("TJ"))) {
            Write-Host "--- Stream $count (decompressed $($dec.Length) chars) ---"
            # Show first 300 chars
            $lines = $dec -split "\r?\n"
            foreach ($line in $lines | Select-Object -First 15) {
                Write-Host $line
            }
            $count++
            if ($count -ge 3) { break }
        }
    }
}
