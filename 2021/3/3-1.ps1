$instructions = Get-Content -Path 'input.txt'

$BitTable = @{}

$BitCount = $instructions[0].Length
foreach($number in 0..($BitCount-1)) {
    $BitTable[$number] = @()
}
foreach($string in $instructions) {
    foreach($number in 0..($BitCount-1)) {
        $BitTable[$number] += [int][string]$string[$number]
    }
}

$BitTable['gamma'] = @()
$BitTable['epsilon'] = @()
foreach($number in 0..($BitCount-1)) {
    $CountOf1 = $BitTable[$number].Where{$_ -eq 1}
    
    if($CountOf1.Count*2 -gt $BitTable[$number].Count) {
        $BitTable['gamma'] += 1
        $BitTable['epsilon'] += 0
    }
    else {
        $BitTable['gamma'] += 0
        $BitTable['epsilon'] += 1
    }
}

$gamma = -join $BitTable['gamma']
$epsilon = -join $BitTable['epsilon']
[System.Convert]::ToInt32($gamma,2) * [System.Convert]::ToInt32($epsilon,2)