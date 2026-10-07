$pdfFiles = Get-ChildItem -Path "kutub_markaz\pdf_editions\*.pdf"

foreach ($file in $pdfFiles) {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $text = [System.Text.Encoding]::ASCII.GetString($bytes)
    $pages = [regex]::Matches($text, "/Type\s*/Page[^s]")
    $mb = [math]::Round($file.Length / 1MB, 2)
    Write-Host "$($file.Name) -> $mb MB | Pages: $($pages.Count)"
}
