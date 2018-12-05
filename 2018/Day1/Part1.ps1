function Get-Frequence {
    param(
        [Parameter(valuefrompipeline)]
        [int[]]
        $Change
    )
    begin {
        $Frequency = 0
    }
    process {
        foreach($Value in $Change) {
            if($Value -lt 0) {
                $ValueSign = '+'
            } else {
                $ValueSign = $null
            }
            $NewFrequency = $Frequency + $Value
            "Current frequency is $Frequency, change of $ValueSign$Value; resulting in frequency $NewFrequency."
            $Frequency = $NewFrequency
        }
    }
}
Get-Frequence -Change +1,+1,+1
Get-Frequence -Change +1,+1,-2
Get-Frequence -Change -1,-2,-3
Get-Content -Path 1.1.txt | Get-Frequence
