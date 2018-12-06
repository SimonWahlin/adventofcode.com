function Get-Frequence {
    param(
        [Parameter(valuefrompipeline)]
        [int[]]
        $Change,
        $Start = 0
    )
    begin {
        $Frequency = $Start
    }
    process {
        foreach($Value in $Change) {
            if($Value -gt 0) {
                $ValueSign = '+'
            } else {
                $ValueSign = $null
            }
            $NewFrequency = $Frequency + $Value
            Write-Verbose -Message "Current frequency is $Frequency, change of $ValueSign$Value; resulting in frequency $NewFrequency."
            $Frequency = $NewFrequency
            Write-Output -InputObject $Frequency
        }
    }
    end {
        
    }
}
$Result = $null
$Count = 0
$HashSet = New-Object -TypeName 'System.Collections.Generic.HashSet[int]'
$null = $HashSet.Add(0)
:loop
while ($true) {
    $Count = $(
        $Data = $(
            # +1, -1
            # +3, +3, +4, -2, -4
            # -6, +3, +8, +5, -6
            # +7, +7, -2, -7, -4
            # +1, -2, +3, +1
            Get-Content -Path 1.2.input
        ) 
        Get-Frequence -Change $Data -Start $Count | ForEach-Object -Process {
            if(-not $HashSet.Add($_)) {
                $Result = $_
                break loop
            } else {
                $_
            }
        } | Select-Object -Last 1
    )
}
"Result is: $Result"
