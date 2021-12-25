[cmdletbinding()]
param(
    [switch]$Sharp,
    [int]$Days = 256
)

if ($Sharp) {
    $data = (Get-Content -Path 'input.txt') -split ','
}
else {
    $data = (Get-Content -Path 'testinput.txt') -split ','
}

$fishes = @{}
0..8 | ForEach-Object { $fishes[$_] = [UInt64]0 }
foreach ($num in $data) {
    $fishes[[int]$num]++
}
$Count = $(
    $fishes.values | 
        Measure-Object -Sum | 
        ForEach-Object Sum
)
Write-Host "count: $Count"

for ($day = 0; $day -lt $Days; $day++) {
    $newFishes = $fishes[0]
    foreach ($i in 0..7) {
        $fishes[$i] = $fishes[$i + 1]
    }
    $fishes[8] = $newFishes
    $fishes[6] += $newFishes
    $Count = $($fishes.values | Measure-Object -Sum | ForEach-Object Sum)
    Write-Host "count: $Count"
}

$Count = $(
    $fishes.values | 
        Measure-Object -Sum | 
        ForEach-Object Sum
)
Write-Host "count: $Count"

