[int[]]$readings = Get-Content -Path 'input.txt'
$Count = 0
for ($i = 3; $i -lt $readings.Count; $i++) {
    $previousSum = $readings[$i-3] + $readings[$i-2] + $readings[$i-1]
    $currentSum = $readings[$i-2] + $readings[$i-1] + $readings[$i]

    if($currentSum -gt $previousSum) {
        $Count++
    }
}

$Count