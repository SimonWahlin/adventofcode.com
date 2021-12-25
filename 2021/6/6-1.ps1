[cmdletbinding()]
param(
    [switch]$Sharp,
    [int]$Days = 256
)

if($Sharp) {
    $data = (Get-Content -Path 'input.txt') -split ','
}
else {
    $data = (Get-Content -Path 'testinput.txt') -split ','
}
$fishes = New-Object -TypeName 'System.Collections.ArrayList'
foreach($num in $data) {
    $null = $fishes.add([int]$num)
}
Write-Host "count: $($fishes.count)"
for($day = 0; $day -lt $Days; $day++) {
    $newFishes = 0
    for ($i = 0; $i -lt $fishes.Count; $i++) {
        if($fishes[$i] -eq 0) {
            $newFishes++
            $fishes[$i] = 6
        }
        else {
            $fishes[$i] = $fishes[$i]-1
        }
    }
    for ($newFish = 0; $newFish -lt $newFishes; $newFish++) {
        $null = $fishes.add(8)
    }
}
$fishes.Count
