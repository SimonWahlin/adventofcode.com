[cmdletbinding()]
param(
    [switch]$Sharp
)

if ($Sharp) {
    [int[]]$data = (Get-Content -Path 'input.txt') -split ','
}
else {
    [int[]]$data = (Get-Content -Path 'testinput.txt') -split ','
}
$data = $data | Sort-Object
$result = @{}
$crabs = @{}
$data | % {
    $crabs[$_]++
}
foreach ($pos in 0..$data[-1]) {
    $totalcost = 0
    foreach ($key in $crabs.Keys) {
        $cost = 0
        $steps = [math]::Abs($key - $pos)
        for ($i = 1; $i -le $steps; $i++) {
            $cost += $i
        }
        # Write-Host "$Key to $pos = $cost"
        $totalcost += $cost * $crabs[$key]
    }
    $result[$pos] = $totalcost
}

$result.GetEnumerator() | Sort-Object -Property Value -Top 1