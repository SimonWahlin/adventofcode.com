[int[]]$readings = Get-Content -Path 'input.txt'
$Count = 0
for ($i = 1; $i -lt $readings.Count; $i++) {
    if($readings[$i] -gt $readings[$i-1]) {
        $Count++
    }
}

$Count