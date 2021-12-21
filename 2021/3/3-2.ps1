$instructions = Get-Content -Path 'input.txt'

function Get-BitTable {
    param(
        [string[]]$InputData
    )
    $BitTable = @{}

    $BitCount = $InputData[0].Length
    foreach ($number in 0..($BitCount - 1)) {
        $BitTable[$number] = @()
    }
    foreach ($string in $InputData) {
        foreach ($number in 0..($BitCount - 1)) {
            $BitTable[$number] += [int][string]$string[$number]
        }
    }

    $BitTable['gamma'] = @()
    $BitTable['epsilon'] = @()

    $EqualCount = 0
    foreach ($number in 0..($BitCount - 1)) {
        $CountOf1 = $BitTable[$number].Where{ $_ -eq 1 }
    
        if ($CountOf1.Count * 2 -gt $BitTable[$number].Count) {
            $BitTable['gamma'] += 1
            $BitTable['epsilon'] += 0
        }
        elseif ($CountOf1.Count * 2 -eq $BitTable[$number].Count) {
            $EqualCount++
            $BitTable['gamma'] += 1
            $BitTable['epsilon'] += 0
        }
        else {
            $BitTable['gamma'] += 0
            $BitTable['epsilon'] += 1
        }
    }

    Write-Output $BitTable
}

$BitTable = Get-BitTable -InputData $instructions
$gamma = -join $BitTable['gamma']
$epsilon = -join $BitTable['epsilon']
$EqualCount
[System.Convert]::ToInt32($gamma, 2) * [System.Convert]::ToInt32($epsilon, 2)

#################################

$Oxygen = $instructions
$BitCount = $instructions[0].Length
foreach($position in 0..($BitCount-1)) {
    $BitTable = Get-Bittable -InputData $Oxygen
    if($Oxygen.count -gt 1) {
        $Oxygen = $Oxygen.where{
            [int][string]$_[$position] -eq $BitTable['gamma'][$position]
        }
        
    }
}

$CO2 = $instructions
foreach($position in 0..($BitCount-1)) {
    $BitTable = Get-Bittable -InputData $CO2
    if($CO2.count -gt 1) {
        $CO2 = $CO2.where{
            [int][string]$_[$position] -eq $BitTable['epsilon'][$position]
        }
    }
}

$Oxygen
$CO2
[System.Convert]::ToInt32($Oxygen, 2) * [System.Convert]::ToInt32($CO2, 2)
