# Inspect Tuhfatul Wildan and 1001 Hadith PDFs
$tuhfa = "kutub_markaz\pdf_editions\تُحْفَةُ_الوِلْدَانِ_الجزء_الأول_والثاني_Book_1_and_2.pdf"
$hadithAr = "kutub_markaz\pdf_editions\1001_Authentic_Hadith_Arabic.pdf"

if (Test-Path $tuhfa) {
    $bytes = [System.IO.File]::ReadAllBytes($tuhfa)
    $text = [System.Text.Encoding]::ASCII.GetString($bytes)
    $pages = [regex]::Matches($text, "/Type\s*/Page[^s]")
    Write-Host "Tuhfatul Wildan Total Pages: $($pages.Count)"
}

if (Test-Path $hadithAr) {
    $bytes = [System.IO.File]::ReadAllBytes($hadithAr)
    $text = [System.Text.Encoding]::ASCII.GetString($bytes)
    $pages = [regex]::Matches($text, "/Type\s*/Page[^s]")
    Write-Host "1001 Hadith Arabic Total Pages: $($pages.Count)"
}
