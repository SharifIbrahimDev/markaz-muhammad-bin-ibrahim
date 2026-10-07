$ErrorActionPreference = 'Stop'

$scriptDir = $PSScriptRoot
$kutubDir = Split-Path -Parent $scriptDir
$workspace = Split-Path -Parent $kutubDir

$htmlPath = (Resolve-Path (Join-Path $scriptDir "4_al_manhal_as_safi.html")).Path
$pdfDir = Join-Path $kutubDir "pdf_editions"
$pdfPath = Join-Path $pdfDir "4_al_manhal_as_safi.pdf"
$webPdfDir = Join-Path $workspace "web\pdf"
$webPdfPath = Join-Path $webPdfDir "4_al_manhal_as_safi.pdf"
$userDataDir = Join-Path $scriptDir "edge_temp_cdp4"

$headerFile = Join-Path $scriptDir "header_template_book4.html"
$footerFile = Join-Path $scriptDir "footer_template.html"

$headerHtml = [System.IO.File]::ReadAllText($headerFile, [System.Text.Encoding]::UTF8)
$footerHtml = [System.IO.File]::ReadAllText($footerFile, [System.Text.Encoding]::UTF8)

if (-not (Test-Path $pdfDir)) { New-Item -ItemType Directory -Path $pdfDir -Force | Out-Null }
if (-not (Test-Path $webPdfDir)) { New-Item -ItemType Directory -Path $webPdfDir -Force | Out-Null }
if (Test-Path $userDataDir) { Remove-Item $userDataDir -Recurse -Force }
New-Item -ItemType Directory -Path $userDataDir -Force | Out-Null

$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edgePath)) {
    $edgePath = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}

$port = 9224
Write-Host "Starting Edge with Remote Debugging on port $port (CDP)..."
$edgeArgs = @(
    "--headless=new",
    "--disable-gpu",
    "--no-sandbox",
    "--remote-debugging-port=$port",
    "--user-data-dir=`"$userDataDir`"",
    "about:blank"
)

$proc = Start-Process -FilePath $edgePath -ArgumentList $edgeArgs -PassThru -NoNewWindow
Start-Sleep -Seconds 2

function Receive-FullMessage($ws) {
    $buffer = New-Object byte[] 65536
    $ms = New-Object System.IO.MemoryStream
    do {
        $segment = New-Object System.ArraySegment[byte] -ArgumentList @($buffer, 0, $buffer.Length)
        $task = $ws.ReceiveAsync($segment, [System.Threading.CancellationToken]::None)
        $task.Wait()
        $result = $task.Result
        $ms.Write($buffer, 0, $result.Count)
    } while (-not $result.EndOfMessage)
    
    return [System.Text.Encoding]::UTF8.GetString($ms.ToArray())
}

function Send-JsonMessage($ws, $obj) {
    $json = $obj | ConvertTo-Json -Compress -Depth 10
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
    $segment = New-Object System.ArraySegment[byte] -ArgumentList @($bytes, 0, $bytes.Length)
    $task = $ws.SendAsync($segment, [System.Net.WebSockets.WebSocketMessageType]::Text, $true, [System.Threading.CancellationToken]::None)
    $task.Wait()
}

try {
    Write-Host "Connecting to DevTools WebSocket on port $port..."
    $connected = $false
    $tabs = $null
    for ($i = 0; $i -lt 15; $i++) {
        try {
            $tabs = Invoke-RestMethod -Uri "http://127.0.0.1:$port/json" -TimeoutSec 2
            $connected = $true
            break
        } catch {
            Start-Sleep -Milliseconds 800
        }
    }
    if (-not $connected) {
        throw "Could not connect to Edge on port $port after 12 seconds."
    }

    $pageTabs = @($tabs | Where-Object { $_.type -eq "page" })
    if ($pageTabs.Count -eq 0) {
        $newTab = Invoke-RestMethod -Uri "http://127.0.0.1:$port/json/new"
        $wsUrl = $newTab.webSocketDebuggerUrl
    } else {
        $wsUrl = $pageTabs[0].webSocketDebuggerUrl
    }
    Write-Host "Target WebSocket URL: $wsUrl"

    $ws = New-Object System.Net.WebSockets.ClientWebSocket
    $ws.ConnectAsync((New-Object System.Uri($wsUrl)), [System.Threading.CancellationToken]::None).Wait()

    # Enable Page events
    Send-JsonMessage $ws @{ id = 1; method = "Page.enable" }
    $null = Receive-FullMessage $ws

    # Navigate to local HTML file with proper URL encoding
    $fileUrl = (New-Object System.Uri($htmlPath)).AbsoluteUri
    Write-Host "Navigating to: $fileUrl"
    Send-JsonMessage $ws @{ id = 2; method = "Page.navigate"; params = @{ url = $fileUrl } }

    # Wait for page and Google Web Fonts to load
    Write-Host "Waiting for page layout and fonts to render..."
    Start-Sleep -Seconds 5

    Write-Host "Printing to PDF with Running Header, Footer and Page Numbers..."
    $printObj = @{
        id = 100
        method = "Page.printToPDF"
        params = @{
            displayHeaderFooter = $true
            headerTemplate = $headerHtml
            footerTemplate = $footerHtml
            printBackground = $true
            preferCSSPageSize = $true
            marginTop = 0.75
            marginBottom = 0.75
            marginLeft = 0.6
            marginRight = 0.6
        }
    }

    Send-JsonMessage $ws $printObj

    # Receive response with PDF data
    $done = $false
    $pdfBase64 = $null
    while (-not $done) {
        $respRaw = Receive-FullMessage $ws
        if ($respRaw -match '"id"\s*:\s*100') {
            $done = $true
            $preview = $respRaw.Substring(0, [Math]::Min(500, $respRaw.Length))
            Write-Host "CDP Response Preview: $preview"
            
            $parsed = $respRaw | ConvertFrom-Json
            if ($parsed.error) {
                Write-Host "CDP Error: $($parsed.error | ConvertTo-Json)"
            } elseif ($parsed.result -and $parsed.result.data) {
                $pdfBase64 = $parsed.result.data
            }
        }
    }

    if (-not [string]::IsNullOrEmpty($pdfBase64)) {
        $pdfBytes = [System.Convert]::FromBase64String($pdfBase64)
        [System.IO.File]::WriteAllBytes($pdfPath, $pdfBytes)
        $mb = [Math]::Round($pdfBytes.Length / 1MB, 2)
        Write-Host "SUCCESS: PDF created with header, footer & page numbers: $pdfPath ($mb MB)"

        Copy-Item -Path $pdfPath -Destination $webPdfPath -Force
        Write-Host "Copied to Web: $webPdfPath"
    } else {
        throw "Failed to extract PDF base64 from CDP response"
    }
} finally {
    if ($ws -and $ws.State -eq [System.Net.WebSockets.WebSocketState]::Open) {
        try {
            $ws.CloseAsync([System.Net.WebSockets.WebSocketCloseStatus]::NormalClosure, "Done", [System.Threading.CancellationToken]::None).Wait()
        } catch {}
    }
    if ($proc -and -not $proc.HasExited) {
        Stop-Process -Id $proc.Id -Force
    }
}
