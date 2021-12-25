[cmdletbinding()]
param(
    [switch]$Sharp
)
if($Sharp) {
    $instructions = Get-Content -Path 'input.txt'
}
else {
    $instructions = Get-Content -Path 'testinput.txt'
}

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
    Write-Verbose ($pos -join ' ')
    switch($true) {
        {$x1 -eq $x2} {$StepX = 0}
        {$x1 -lt $x2} {$StepX = 1}
        {$x1 -gt $x2} {$StepX = -1}
        {$y1 -eq $y2} {$StepY = 0}
        {$y1 -lt $y2} {$StepY = 1}
        {$y1 -gt $y2} {$StepY = -1}
    }
    Write-Verbose "Walking X=$StepX, Y=$StepY"
    while($x1-ne$x2 -or $y1-ne$y2) {
        Write-Verbose "Marking $x1,$y1"
        $chart[$x1][$y1] = $chart[$x1][$y1] + 1
        $x1 = $x1 + $StepX
        $y1 = $y1 + $StepY
    }
    Write-Verbose "Marking $x1,$y1"
    $chart[$x1][$y1] = $chart[$x1][$y1] + 1
}
Write-Host "Found: $($chart.count) rows"
remove-item '.\output.txt' -ErrorAction Ignore
$chart | % { "$_" | Out-File 'output.txt' -Append}
$chart | % {$_} | Where-Object {$_ -ge 2} | Measure-Object | 
    Select-Object -ExpandProperty Count