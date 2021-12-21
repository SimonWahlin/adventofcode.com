$instructions = Get-Content -Path 'input.txt' 

$Bits = $instructions | ForEach-Object -Process {
    [System.Convert]::ToInt32($_,2)
}

$BitCount = $instructions[0].Length

$Gamma = 0
$Epsilon = 0
for ($i = 0; $i -lt $BitCount; $i++) {
    $Mask = 1 -shl $i
    $Counter = 1
    foreach($entry in $Bits) {
        if($entry -band $Mask) {
            $Counter++
        }
        else {
            $Counter--
        }
    }
    if($Counter -ge 0) {
        $Gamma = $Gamma -bor $Mask
    }
    else {
        $Epsilon = $Epsilon -bor $Mask
    }
}

$answer1 = $gamma * $epsilon
Write-Output $answer1

