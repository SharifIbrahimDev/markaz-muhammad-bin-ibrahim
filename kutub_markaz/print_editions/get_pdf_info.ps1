$pdfPath = "kutub_markaz\pdf_editions\3_fath_ar_rahim_al_mannan.pdf"
$bytes = [System.IO.File]::ReadAllBytes($pdfPath)
$text = [System.Text.Encoding]::ASCII.GetString($bytes)
$pageMatches = [regex]::Matches($text, '/Type\s*/Page\b')
$fileInfo = Get-Item $pdfPath

Write-Host "File: $($fileInfo.Name)"
Write-Host "Size: $([Math]::Round($fileInfo.Length / 1MB, 2)) MB ($($fileInfo.Length) bytes)"
Write-Host "Total Pages: $($pageMatches.Count)"
