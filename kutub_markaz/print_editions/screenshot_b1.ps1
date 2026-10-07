$edge = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$pdfPath = (Resolve-Path "kutub_markaz\pdf_editions\1_ad_durar_al_bahiyyah.pdf").Path
$pdfUri = (New-Object System.Uri($pdfPath)).AbsoluteUri
$outPng = Join-Path (Resolve-Path "kutub_markaz\print_editions").Path "b1_page2.png"
$tmp = Join-Path (Resolve-Path "kutub_markaz\print_editions").Path "edge_temp_snap"

if (Test-Path $tmp) { Remove-Item $tmp -Recurse -Force }
New-Item -ItemType Directory -Path $tmp -Force | Out-Null

$args = @(
    "--headless=new",
    "--disable-gpu",
    "--no-sandbox",
    "--window-size=1200,1600",
    "--user-data-dir=`"$tmp`"",
    "--screenshot=`"$outPng`"",
    "`"$pdfUri#page=2`""
)

Start-Process -FilePath $edge -ArgumentList $args -Wait -NoNewWindow
Write-Host "Screenshot created: $(Test-Path $outPng)"
