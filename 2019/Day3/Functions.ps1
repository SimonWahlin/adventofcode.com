function Resolve-WirePath {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]
        $DirectionString
    )
    $Directions = $DirectionString.Trim() -split ','
    $Path = New-Object -TypeName 'System.Collections.Generic.HashSet[string]'
    $Cordinates = 0, 0
    foreach ($Instruction in $Directions) {
    
        try {
            [char]$Direction, [int]$Count = $Instruction -split '(?<=\D)'
        }
        catch {
            $Message ="Invalid instruction: $Instruction"
            Write-Error -Message $Message -TargetObject $Instruction -ErrorAction Stop
        }

        

        if ($Direction -in 'U', 'D') {
            $index = 0
        }
        else {
            $index = 1
        }

        for ($i = 0; $i -lt $Count; $i++) {
            if ($Direction -in 'D', 'L') {
                $Cordinates[$index]--
            }
            else {
                $Cordinates[$index]++
            }
            $null = $Path.Add($Cordinates -join ',')
        }
    }
    Write-Output -InputObject $Path
}

function Compare-WirePath {
    [CmdletBinding()]
    param (
        # [System.Collections.Generic.HashSet[string]]
        [System.Collections.Generic.HashSet`1[[System.String]]]
        $ReferencePath,
        # [System.Collections.Generic.HashSet[string]]
        [System.Collections.Generic.HashSet`1[[System.String]]]
        $DifferencePath
    )
    $NewSet = New-Object -TypeName 'System.Collections.Generic.HashSet[string]' -ArgumentList $ReferencePath
    $NewSet.IntersectWith($DifferencePath)
    return $NewSet
}

function Select-ClosestWireIntersection {
    [CmdletBinding()]
    param (
        [string]
        $ReferencePathDirection,
        [string]
        $DifferencePathDirection
    )
    $Path1 = Resolve-WirePath -Directions $ReferencePathDirection
    $Path2 = Resolve-WirePath -Directions $DifferencePathDirection

    $Crossings = Compare-WirePath -ReferencePath $Path1 -DifferencePath $Path2

    $ClosestDistance = [int]::MaxValue
    foreach($Point in $Crossings) {
        $Values = [int[]]($Point -split ',')
        $Distance = [Math]::Abs($Values[0]) + [Math]::Abs($Values[1])
        if($Distance -lt $ClosestDistance) {
            $ClosestDistance = $Distance
        }
    }
    if($ClosestDistance -lt [int]::MaxValue) {
        return $ClosestDistance
    }
}