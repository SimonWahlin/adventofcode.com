Context 'Day 3' {
    It 'Solves examples' {
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
        $Answer = Select-ClosestWireIntersection -ReferencePathDirection $Path1Directions -DifferencePathDirection $Path2Directions
        
        $Answer | Should -Be 159

        $Path1Directions, $Path2Directions = $InputData[1] -Split "`n"
        $Answer = Select-ClosestWireIntersection -ReferencePathDirection $Path1Directions -DifferencePathDirection $Path2Directions
        
        $Answer | Should -Be 135
    }
        
    It 'Solves Part1' {
        $InputData = Get-Content -Path ./input.txt -Raw
            
        $Path1Directions, $Path2Directions = $InputData -Split "`n"
        $Answer = Select-ClosestWireIntersection -ReferencePathDirection $Path1Directions -DifferencePathDirection $Path2Directions
        $Answer | Should -Not -BeNullOrEmpty
    }

    It 'Solves Part2 examples' {
        
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
        $Answer = Select-ClosestWireIntersection -ReferencePathDirection $Path1Directions -DifferencePathDirection $Path2Directions -MinimizeDelay
        
        $Answer | Should -Be 610

        $Path1Directions, $Path2Directions = $InputData[1] -Split "`n"
        $Answer = Select-ClosestWireIntersection -ReferencePathDirection $Path1Directions -DifferencePathDirection $Path2Directions -MinimizeDelay
        
        $Answer | Should -Be 410
    }

    
}