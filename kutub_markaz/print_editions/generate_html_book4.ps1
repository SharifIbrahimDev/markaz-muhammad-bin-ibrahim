$ErrorActionPreference = 'Stop'

$scriptDir = $PSScriptRoot
$mdFile = Join-Path $scriptDir "..\manuscripts\4_al_manhal_as_safi.md"
$htmlFile = Join-Path $scriptDir "4_al_manhal_as_safi.html"
$headFile = Join-Path $scriptDir "template_head_book4.html"
$footFile = Join-Path $scriptDir "template_foot.html"

$headHtml = [System.IO.File]::ReadAllText($headFile, [System.Text.Encoding]::UTF8)
$footHtml = [System.IO.File]::ReadAllText($footFile, [System.Text.Encoding]::UTF8)
$lines = [System.IO.File]::ReadAllLines($mdFile, [System.Text.Encoding]::UTF8)

$outLines = New-Object System.Collections.Generic.List[string]

$inCode = $false
$codeLines = New-Object System.Collections.Generic.List[string]
$inUl = $false
$inOl = $false
$inTable = $false

function EndLists {
    if ($script:inUl) {
        $script:outLines.Add("</ul>")
        $script:inUl = $false
    }
    if ($script:inOl) {
        $script:outLines.Add("</ol>")
        $script:inOl = $false
    }
    if ($script:inTable) {
        $script:outLines.Add("  </tbody>")
        $script:outLines.Add("</table>")
        $script:inTable = $false
    }
}

foreach ($l in $lines) {
    $t = $l.Trim()

    if ($t.StartsWith('```')) {
        if ($inCode) {
            $joinedCode = $codeLines -join "`n"
            if ($joinedCode -match '^\s*\d+\.') {
                $script:outLines.Add('<div class="bayt-box">')
                foreach ($cl in $codeLines) {
                    $clt = $cl.Trim()
                    if ($clt.Length -gt 0) {
                        $cltFmt = $clt.Replace('...', '<span class="bayt-divider">...</span>')
                        $script:outLines.Add($cltFmt + '<br>')
                    }
                }
                $script:outLines.Add('</div>')
            } else {
                $script:outLines.Add('<div class="diagram-box"><pre>')
                foreach ($cl in $codeLines) {
                    $safe = [System.Security.SecurityElement]::Escape($cl)
                    $script:outLines.Add($safe)
                }
                $script:outLines.Add('</pre></div>')
            }
            $inCode = $false
            $codeLines.Clear()
        } else {
            EndLists
            $inCode = $true
            $codeLines.Clear()
        }
        continue
    }

    if ($inCode) {
        $codeLines.Add($l)
        continue
    }

    if ($t.Length -eq 0) {
        EndLists
        continue
    }

    if ($t -eq '---' -or $t -eq '***') {
        EndLists
        $script:outLines.Add('<div class="section-divider"><span>&#x2766; &#x2766; &#x2766;</span></div>')
        continue
    }

    if ($t.StartsWith('# ')) {
        EndLists
        $txt = $t.Substring(2).Trim()
        $script:outLines.Add('<h1 class="main-heading">' + $txt + '</h1>')
        continue
    }
    if ($t.StartsWith('## ')) {
        EndLists
        $txt = $t.Substring(3).Trim()
        $script:outLines.Add('<h2 class="section-title">' + $txt + '</h2>')
        continue
    }
    if ($t.StartsWith('### ')) {
        EndLists
        $txt = $t.Substring(4).Trim()
        $script:outLines.Add('<h3 class="sub-title">' + $txt + '</h3>')
        continue
    }
    if ($t.StartsWith('#### ')) {
        EndLists
        $txt = $t.Substring(5).Trim()
        $script:outLines.Add('<h4 class="sub-sub-title">' + $txt + '</h4>')
        continue
    }

    if ($t.StartsWith('> ')) {
        EndLists
        $q = $t.Substring(2).Trim()
        $q = $q -replace '\*\*(.+?)\*\*', '<strong>$1</strong>'
        $q = $q -replace '\*(.+?)\*', '<em>$1</em>'
        $script:outLines.Add('<blockquote class="quote-box">' + $q + '</blockquote>')
        continue
    }

    if ($t -match '^[\*\-]\s+(.+)$') {
        $item = $matches[1].Trim()
        $item = $item -replace '\*\*(.+?)\*\*', '<strong>$1</strong>'
        $item = $item -replace '\*(.+?)\*', '<em>$1</em>'
        if (-not $inUl) {
            EndLists
            $script:outLines.Add('<ul class="content-list">')
            $inUl = $true
        }
        $script:outLines.Add('  <li>' + $item + '</li>')
        continue
    }

    if ($t -match '^\d+\.\s+(.+)$') {
        $item = $matches[1].Trim()
        $item = $item -replace '\*\*(.+?)\*\*', '<strong>$1</strong>'
        $item = $item -replace '\*(.+?)\*', '<em>$1</em>'
        if (-not $inOl) {
            EndLists
            $script:outLines.Add('<ol class="content-list-ordered">')
            $inOl = $true
        }
        $script:outLines.Add('  <li>' + $item + '</li>')
        continue
    }

    if ($t.StartsWith('|') -and $t.EndsWith('|')) {
        if ($script:inUl) { $script:outLines.Add("</ul>"); $script:inUl = $false }
        if ($script:inOl) { $script:outLines.Add("</ol>"); $script:inOl = $false }

        if ($t -match '^\|[\s\-:]+(\|[\s\-:]+)+\|$') {
            continue
        }

        $rawCells = $t.Split('|')
        $cells = New-Object System.Collections.Generic.List[string]
        for ($ci = 1; $ci -lt ($rawCells.Length - 1); $ci++) {
            $cells.Add($rawCells[$ci].Trim())
        }

        if (-not $script:inTable) {
            $script:inTable = $true
            $script:outLines.Add('<table class="academic-table">')
            $script:outLines.Add('  <thead>')
            $script:outLines.Add('    <tr>')
            foreach ($cell in $cells) {
                $c = $cell -replace '\*\*(.+?)\*\*', '<strong>$1</strong>'
                $c = $c -replace '\*(.+?)\*', '<em>$1</em>'
                $c = $c -replace '`(.+?)`', '<code>$1</code>'
                $script:outLines.Add('      <th>' + $c + '</th>')
            }
            $script:outLines.Add('    </tr>')
            $script:outLines.Add('  </thead>')
            $script:outLines.Add('  <tbody>')
        } else {
            $script:outLines.Add('    <tr>')
            foreach ($cell in $cells) {
                $c = $cell -replace '\*\*(.+?)\*\*', '<strong>$1</strong>'
                $c = $c -replace '\*(.+?)\*', '<em>$1</em>'
                $c = $c -replace '`(.+?)`', '<code>$1</code>'
                $script:outLines.Add('      <td>' + $c + '</td>')
            }
            $script:outLines.Add('    </tr>')
        }
        continue
    }

    EndLists
    $p = $t -replace '\*\*(.+?)\*\*', '<strong>$1</strong>'
    $p = $p -replace '\*(.+?)\*', '<em>$1</em>'
    $p = $p -replace '`(.+?)`', '<code>$1</code>'
    $script:outLines.Add('<p>' + $p + '</p>')
}

EndLists

$body = $outLines -join "`r`n"
$full = $headHtml + "`r`n" + $body + "`r`n" + $footHtml

[System.IO.File]::WriteAllText($htmlFile, $full, [System.Text.Encoding]::UTF8)

$size = (Get-Item $htmlFile).Length
$fileLines = (Get-Content -Path $htmlFile -Encoding UTF8).Length
Write-Host "SUCCESS: Generated clean UTF-8 HTML: $htmlFile"
Write-Host "Size: $size bytes ($([Math]::Round($size / 1KB, 2)) KB)"
Write-Host "Lines: $fileLines"
