. .\Functions.ps1


$ReferencePathDirection = $Path1Directions
$DifferencePathDirection = $Path2Directions

$InputData = @(
            @'
R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83
'@,
            @'
R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7
'@
        )

        $Path1Directions, $Path2Directions = $InputData[0] -Split "`n"

$Path1 = Resolve-WirePath -Directions $ReferencePathDirection
$Path2 = Resolve-WirePath -Directions $DifferencePathDirection

$Crossings = Compare-WirePath -ReferencePath $Path1 -DifferencePath $Path2

$Cordinate = $Crossings[0]
for ($i = 0; $i -lt $Path1.Count; $i++) {
    if($Path1[$i] -eq $Cordinate) {
        break
    }
}
$i