[cmdletbinding()]
param()
$instructions = Get-Content -Path 'input.txt'

$MaxX = 0
$MaxY = 0
[int[][]]$positions = foreach($line in $instructions) {
    $p1,$p2 = $line -split ' -> '
    $x1,$y1 = $p1 -split ',' -as [int[]]
    $x2,$y2 = $p2 -split ',' -as [int[]]
    $maxX = $maxX, $x1, $x2 | Sort-Object -Bottom 1
    $maxY = $maxY,$y1,$y2 | Sort-Object -Bottom 1
    Write-Output (,@($x1,$y1,$x2,$y2))
}

[int[][]]$chart = New-Object -TypeName int[][] ($maxX+1),($maxY+1)
Write-Verbose $chart.count

foreach($pos in $positions) {
    $x1,$y1,$x2,$y2 = $pos
    # Write-Verbose "$pos"
    # Write-Verbose $x1
    # Write-Verbose $y1
    # Write-Verbose $x2
    # Write-Verbose $y2
    if($x1 -eq $x2) {
        Write-Verbose "Walking Y"
        Write-Verbose "$pos"
        if($y1 -lt $y2) {
            $step = 1
        }
        else {
            $step = -1
        }
        while($y1 -ne $y2) {
            Write-Verbose "Marking $x1,$y1"
            $chart[$x1][$y1] = $chart[$x1][$y1] + 1
            $y1 = $y1 + $step
        }
        Write-Verbose "Marking $x1,$y1"
        $chart[$x1][$y1]++
    }
    elseif ($y1 -eq $y2) {
        Write-Verbose "Walking X"
        Write-Verbose "$pos"
        if($x1 -lt $x2) {
            $step = 1
        }
        else {
            $step = -1
        }
        Write-Verbose "Stepping: $Step"
        while($x1 -ne $x2) {
            Write-Verbose "Marking $x1,$y1"
            $chart[$x1][$y1]++
            $x1 = $x1 + $step
        }
        Write-Verbose "Marking $x1,$y1"
        $chart[$x1][$y1]++
    }

}
Write-Host "Found: $($chart.count) rows"
remove-item '.\output.txt' -ErrorAction Ignore
$chart | % { "$_" | Out-File 'output.txt' -Append}
$chart | % {$_} | Where-Object {$_ -ge 2} | Measure-Object | 
    Select-Object -ExpandProperty Count