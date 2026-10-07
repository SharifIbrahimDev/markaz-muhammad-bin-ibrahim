$ErrorActionPreference = 'Stop'

$scriptDir = $PSScriptRoot
$mdFile = Join-Path $scriptDir "..\manuscripts\5_umdat_al_muwahhid.md"
$htmlFile = Join-Path $scriptDir "5_umdat_al_muwahhid.html"
$headFile = Join-Path $scriptDir "template_head_book5.html"
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

$chapCounter = 0
$currentPage = 2

$pageMap = @(
    14, 18, 22, 26, 30, 35, 39, 43, 48, 52,
    56, 60, 64, 68, 72, 76, 80, 85, 89, 94,
    98, 102, 106, 111, 115, 119, 123, 127, 131, 135,
    139, 143, 147, 151, 155, 159, 163, 167, 171, 175,
    179, 183, 187, 191, 195, 199, 203, 207, 211, 215,
    219, 223, 227, 231, 235, 239, 243, 247, 251, 255,
    259, 263, 267, 271, 275, 279, 283
)

# Strip tashkeel for clean matching
function Clean-Arabic($str) {
    return [regex]::Replace($str, '[\u064B-\u065F\u0670\u06D6-\u06DC\u06DF-\u06E8\u06EA-\u06ED]', '')
}

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

    # Pass raw HTML elements directly
    if ($t.StartsWith('<table') -or $t.StartsWith('<thead') -or $t.StartsWith('<tbody') -or `
        $t.StartsWith('<tr') -or $t.StartsWith('<th') -or $t.StartsWith('<td') -or `
        $t.StartsWith('</table') -or $t.StartsWith('</thead') -or $t.StartsWith('</tbody') -or `
        $t.StartsWith('</tr') -or $t.StartsWith('<div') -or $t.StartsWith('</div') -or `
        $t.StartsWith('<p') -or $t.StartsWith('</p') -or $t.StartsWith('<span') -or $t.StartsWith('</span')) {
        EndLists
        $script:outLines.Add($l)
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
        $cleanTxt = Clean-Arabic $txt
        
        # Calculate chapter number and page
        $thisPage = 2
        $anchorId = "sec_$script:chapCounter"
        if ($cleanTxt -match 'المدخل.*(الاول|الأول|1)') {
            $thisPage = 5
            $anchorId = "madkhal_1"
        } elseif ($cleanTxt -match 'المدخل.*(الثاني|2)') {
            $thisPage = 8
            $anchorId = "madkhal_2"
        } elseif ($cleanTxt -match 'المدخل.*(الثالث|3)') {
            $thisPage = 11
            $anchorId = "madkhal_3"
        } elseif ($cleanTxt -match 'باب|كتاب التوحيد') {
            $script:chapCounter++
            $cIdx = $script:chapCounter - 1
            if ($cIdx -lt $pageMap.Count) {
                $thisPage = $pageMap[$cIdx]
            } else {
                $thisPage = 283 + ($script:chapCounter - 67)
            }
            $anchorId = "bab_$script:chapCounter"
        } elseif ($cleanTxt -match 'الخاتمة') {
            $thisPage = 287
            $anchorId = "khatimah"
        } elseif ($cleanTxt -match 'ثبت المراجع') {
            $thisPage = 290
            $anchorId = "maraji"
        } elseif ($cleanTxt -match 'فهرس') {
            $thisPage = 293
            $anchorId = "faharis"
        }

        # Header ribbon with Arabic title and page badge
        $headerRibbon = "<div class=`"page-header-ribbon`"><span class=`"book-title`">&#x00AB;&#x0639;&#x064F;&#x0645;&#x0652;&#x062F;&#x064E;&#x0629;&#x064F; &#x0627;&#x0644;&#x0645;&#x064F;&#x0648;&#x064E;&#x062D;&#x0651;&#x0650;&#x062F;&#x0650; &#x0627;&#x0644;&#x0633;&#x0651;&#x064E;&#x062F;&#x0650;&#x064A;&#x062F;&#x0650; &#x0641;&#x0650;&#x064A; &#x0634;&#x064E;&#x0631;&#x0652;&#x062D;&#x0650; &#x0643;&#x0650;&#x062F;&#x064E;&#x0627;&#x0628;&#x0650; &#x0627;&#x0644;&#x062A;&#x0651;&#x064E;&#x0648;&#x0652;&#x062D;&#x0650;&#x064A;&#x062F;&#x0650;&#x00BB;</span><span class=`"center-tag`">&#x0645;&#x064E;&#x0631;&#x0652;&#x0643;&#x064E;&#x0632;&#x064F; &#x0645;&#x064F;&#x062D;&#x064E;&#x0645;&#x0651;&#x064E;&#x062F;&#x0650; &#x0628;&#x0652;&#x0646;&#x0650; &#x0625;&#x0650;&#x0628;&#x0652;&#x0631;&#x064E;&#x0627;&#x0647;&#x0650;&#x064A;&#x0645;&#x064E; &#x0622;&#x0644;&#x0650; &#x0627;&#x0644;&#x0634;&#x0651;&#x064E;&#x064A;&#x0652;&#x062E;&#x0650;</span><span class=`"page-tag`">&#x0627;&#x0644;&#x0635;&#x0651;&#x064E;&#x0641;&#x0652;&#x062D;&#x064E;&#x0629;&#x064F;: $thisPage</span></div>"
        $script:outLines.Add($headerRibbon)
        $script:outLines.Add("<h2 class=`"section-title`" id=`"$anchorId`">$txt</h2>")
        $script:currentPage = $thisPage
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
Write-Host "SUCCESS: Generated clean UTF-8 HTML with Running Headers & Page Badges: $htmlFile"
Write-Host "Size: $size bytes ($([Math]::Round($size / 1KB, 2)) KB)"
Write-Host "Lines: $fileLines"
