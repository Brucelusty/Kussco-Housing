$ErrorActionPreference = 'Stop'

$src = 'C:\Users\Administrator\OneDrive\Desktop\Kitui Merged Today.xlsx'
$dst = 'C:\Users\Administrator\OneDrive\Desktop\Kitui Merged Today_normalized.xlsx'
$csv = 'C:\Users\Administrator\OneDrive\Desktop\Kitui Merged Today_normalized.csv'

function Split-CellValue([string]$value) {
    if ([string]::IsNullOrWhiteSpace($value)) { return @() }
    $parts = $value -split "`r?`n"
    $clean = @()
    foreach ($part in $parts) {
        $trimmed = $part.Trim()
        if ($trimmed -ne '') { $clean += $trimmed }
    }
    return $clean
}

$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false
$excel.DisplayAlerts = $false

try {
    $wb = $excel.Workbooks.Open($src)
    $ws = $wb.Worksheets.Item(1)
    $lastCol = $ws.Cells.Item(1, $ws.Columns.Count).End(-4159).Column
    $lastRow = $ws.Cells.Item($ws.Rows.Count, 1).End(-4162).Row

    $newWb = $excel.Workbooks.Add()
    $newWs = $newWb.Worksheets.Item(1)
    $newWs.Name = 'Normalized'
    $newWs.Range('A:AZ').NumberFormat = '@'

    for ($col = 1; $col -le $lastCol; $col++) {
        $newWs.Cells.Item(1, $col).Value2 = $ws.Cells.Item(1, $col).Text
    }

    $outRow = 2
    $records = New-Object System.Collections.Generic.List[object]

    for ($row = 2; $row -le $lastRow; $row++) {
        $rowParts = @()
        $maxParts = 1
        $hasData = $false

        for ($col = 1; $col -le $lastCol; $col++) {
            $text = [string]$ws.Cells.Item($row, $col).Text
            if (-not [string]::IsNullOrWhiteSpace($text)) { $hasData = $true }
            $parts = Split-CellValue $text
            if ($parts.Count -gt $maxParts) { $maxParts = $parts.Count }
            $rowParts += ,$parts
        }

        if (-not $hasData) { continue }

        for ($partIndex = 0; $partIndex -lt $maxParts; $partIndex++) {
            $obj = [ordered]@{}
            for ($col = 1; $col -le $lastCol; $col++) {
                $header = [string]$ws.Cells.Item(1, $col).Text
                if ([string]::IsNullOrWhiteSpace($header)) { $header = "Column$col" }
                while ($obj.Contains($header)) { $header = $header + '_' }

                $parts = $rowParts[$col - 1]
                $value = ''
                if ($parts.Count -eq 1) {
                    $value = [string]$parts[0]
                } elseif ($parts.Count -gt $partIndex) {
                    $value = [string]$parts[$partIndex]
                }

                $newWs.Cells.Item($outRow, $col).NumberFormat = '@'
                $newWs.Cells.Item($outRow, $col).Value2 = $value
                $obj[$header] = $value
            }
            $records.Add([pscustomobject]$obj)
            $outRow++
        }
    }

    $newWs.Columns.AutoFit() | Out-Null
    $newWb.SaveAs($dst, 51)
    $records | Export-Csv -Path $csv -NoTypeInformation -Encoding UTF8

    Write-Output ("OutputRows=" + ($outRow - 2))
    Write-Output ("ExcelFile=" + $dst)
    Write-Output ("CsvFile=" + $csv)
    Write-Output 'Preview:'
    for ($r = 2; $r -le [Math]::Min(5, $outRow - 1); $r++) {
        $preview = @(
            $newWs.Cells.Item($r, 1).Text,
            $newWs.Cells.Item($r, 2).Text,
            $newWs.Cells.Item($r, 3).Text,
            $newWs.Cells.Item($r, 4).Text,
            $newWs.Cells.Item($r, 5).Text,
            $newWs.Cells.Item($r, 6).Text,
            $newWs.Cells.Item($r, 7).Text,
            $newWs.Cells.Item($r, 8).Text,
            $newWs.Cells.Item($r, 11).Text
        ) -join ','
        Write-Output ("R$($r): $preview")
    }
}
finally {
    if ($wb) { $wb.Close($false) }
    if ($newWb) { $newWb.Close($true) }
    $excel.Quit()
}
