[cmdletbinding()]
param(
    [parameter(ValueFromPipeline)]
    [Int64[]]$Mass
)
begin {
    $ErrorActionPreference = 'stop'
    function Get-FuelRequirement {
        param(
            [Parameter(Mandatory)]
            [Int64]$Mass
        )
        $Sum = $fuel = [math]::Floor($Mass / 3) - 2
        while($fuel -gt 0) {
            $fuel = [math]::Floor($fuel / 3) - 2
            if($fuel -gt 0) {
                $Sum += $fuel
            }
        }
        Write-Output $Sum
    }
    $Sum = 0
}
process {
    foreach($value in $Mass) {
        $Sum += Get-FuelRequirement -Mass $value
    }
}

end {
    Write-Output $Sum
}

