$instructions = Get-Content -Path 'input.txt' 


function Get-PowerConsumption {
    param(
        [string[]]$Instructions
    )
    $Bits = $Instructions | ForEach-Object -Process {
        [System.Convert]::ToInt32($_,2)
    }

    $BitCount = $Instructions[0].Length

    $Gamma = 0
    $Epsilon = 0
    for ($i = 0; $i -lt $BitCount; $i++) {
        $Mask = 1 -shl $i
        $Counter = 0
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
    return $Gamma,$Epsilon
}

$Gamma, $Epsilon = Get-PowerConsumption -Instructions $instructions
$answer1 = $Gamma * $Epsilon
Write-Output $answer1

#################################

# Calculate number of bits in string
$BitCount = $Instructions[0].Length

# Set oxygen and co2 to same input as instructions
$Oxygen = $CO2 = $Instructions

# Loop over each 
for ($i = $BitCount-1; $i -ge 0; $i--) {
    $Mask = 1 -shl $i
    if($Oxygen.Count -gt 1) {
        $Gamma, $Epsilon = Get-PowerConsumption -Instructions $Oxygen
        $OxygenFilter = $Gamma -band $Mask
        $Oxygen = $Oxygen.Where{([System.Convert]::ToInt32($_,2) -band $Mask) -eq $OxygenFilter}
    }
    if($CO2.Count -gt 1) {
        $Gamma, $Epsilon = Get-PowerConsumption -Instructions $CO2
        $CO2Filter = $Epsilon -band $Mask
        $CO2 = $CO2.Where{([System.Convert]::ToInt32($_,2) -band $Mask) -eq $CO2Filter}
    }
}
$answer2 = ([System.Convert]::ToInt32($Oxygen,2)) * ([System.Convert]::ToInt32($CO2,2))
Write-Output $answer2

