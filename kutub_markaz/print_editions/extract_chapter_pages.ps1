# Decompress PDF streams to find exact page number for every chapter
$ErrorActionPreference = "Stop"

$pdfFile = Join-Path $PSScriptRoot "..\pdf_editions\5_umdat_al_muwahhid.pdf"
$bytes = [System.IO.File]::ReadAllBytes($pdfFile)

function Decompress-Flate($streamBytes) {
    # Skip 2-byte zlib header (usually 0x78 0x9c or 0x78 0x01)
    if ($streamBytes.Length -gt 2 -and $streamBytes[0] -eq 0x78) {
        $ms = New-Object System.IO.MemoryStream($streamBytes, 2, $streamBytes.Length - 2)
    } else {
        $ms = New-Object System.IO.MemoryStream($streamBytes, 0, $streamBytes.Length)
    }
    $deflate = New-Object System.IO.Compression.DeflateStream($ms, [System.IO.Compression.CompressionMode]::Decompress)
    $outMs = New-Object System.IO.MemoryStream
    $buffer = New-Object byte[] 4096
    while (($count = $deflate.Read($buffer, 0, $buffer.Length)) -gt 0) {
        $outMs.Write($buffer, 0, $count)
    }
    $deflate.Close()
    $ms.Close()
    return $outMs.ToArray()
}

# Let's find all page objects in order
$str = [System.Text.Encoding]::ASCII.GetString($bytes)
$pageMatches = [regex]::Matches($str, '(?s)(\d+)\s+0\s+obj\s*<<.*?/Type\s*/Page\b.*?>>\s*endobj')

Write-Host "Found $($pageMatches.Count) page objects in PDF."

$results = @()
$pageNum = 1

# Let's search each page
for ($p = 0; $p -lt $pageMatches.Count; $p++) {
    $objText = $pageMatches[$p].Value
    # Find /Contents
    if ($objText -match '/Contents\s+(\d+)\s+0\s+R') {
        $contentsId = $matches[1]
        # Locate object definition
        $streamRegex = "(?s)$contentsId\s+0\s+obj\s*<<.*?/Length\s+(\d+).*?>>\s*stream[\r\n]+(.*?)[\r\n]+endstream"
        $mStream = [regex]::Match($str, $streamRegex)
        if ($mStream.Success) {
            $streamStart = $mStream.Groups[2].Index
            $streamLen = [int]$mStream.Groups[1].Value
            
            $subBytes = New-Object byte[] $streamLen
            [System.Array]::Copy($bytes, $streamStart, $subBytes, 0, $streamLen)
            
            try {
                $decomp = Decompress-Flate $subBytes
                $textUtf8 = [System.Text.Encoding]::UTF8.GetString($decomp)
                $textAscii = [System.Text.Encoding]::ASCII.GetString($decomp)
                
                # Check for chapter titles or keywords in page
                $results += [PSCustomObject]@{
                    Page = ($p + 1)
                    ContentsLen = $decomp.Length
                    RawSnippet = $textUtf8.Substring(0, [Math]::Min(200, $textUtf8.Length))
                }
            } catch {
                # Could be uncompressed
            }
        }
    }
}

Write-Host "Processed $($results.Count) pages."
