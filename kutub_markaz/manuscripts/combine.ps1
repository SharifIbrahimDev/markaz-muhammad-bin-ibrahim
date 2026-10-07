$files = @(
    'kutub_markaz\manuscripts\parts\part01_muqaddimah_tamheed.md',
    'kutub_markaz\manuscripts\parts\part02_madkhal1_sheikh_biography.md',
    'kutub_markaz\manuscripts\parts\part03_madkhal2_and_3_tawhid.md',
    'kutub_markaz\manuscripts\parts\part04_tamheed_almatn_saadah.md',
    'kutub_markaz\manuscripts\parts\part05_hanifiyyah_ibadah_hadath.md',
    'kutub_markaz\manuscripts\parts\part06_qaidah_1_rububiyyah.md',
    'kutub_markaz\manuscripts\parts\part07_qaidah_2_shafaah.md',
    'kutub_markaz\manuscripts\parts\part08_qaidah_3_all_deities_tabarruk.md',
    'kutub_markaz\manuscripts\parts\part09_qaidah_4_and_khatimah.md'
)

$combined = ($files | ForEach-Object { Get-Content -Path $_ -Raw -Encoding UTF8 }) -join "`r`n`r`n---`r`n`r`n"

[System.IO.File]::WriteAllText('kutub_markaz\manuscripts\1_ad_durar_al_bahiyyah.md', $combined, [System.Text.Encoding]::UTF8)

$lines = (Get-Content -Path 'kutub_markaz\manuscripts\1_ad_durar_al_bahiyyah.md' -Encoding UTF8).Length
$words = ($combined -split '\s+').Length

Write-Output "RESULT: Lines=$lines, Words=$words"
