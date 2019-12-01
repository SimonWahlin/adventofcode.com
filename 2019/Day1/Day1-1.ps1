[cmdletbinding()]
param(
    [parameter(ValueFromPipeline)]
    [int[]]$Mass
)
begin {
    function Get-FuelRequirement {
        param(
            [Parameter(Mandatory)]
            [int]$Mass
        )
        [math]::Floor($Mass / 3) - 2
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

