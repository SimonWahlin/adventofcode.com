[cmdletbinding()]
param(
    [switch]$Sharp,
    [int]$Days = 256
)

if($Sharp) {
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
foreach($pos in 0..$data[-1]) {
    $cost = 0
    foreach($key in $crabs.Keys) {
        $cost += [math]::Abs($key-$pos) * $crabs[$key]
    }
    $result[$pos] = $cost
}

$result.GetEnumerator() | Sort-Object -Property Value -Top 1