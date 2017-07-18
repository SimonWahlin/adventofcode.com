enum Bearing {
    North = 0
    East = 1
    South = 2
    West = 3
}

class Location
{
    [Int] $Long
    [Int] $Lat
    [Bearing] $Bearing

    hidden [string] $MovePattern = '^(L|R)\d+$'
    
    Location () {
        $this.Long = 0
        $this.Lat = 0
        $this.Bearing = 0
    }

    [void] Move ([string] $Move) {
        $NewBearing = 0
        $Direction = $Move.Substring(0,1)
        $Distance = $Move.SubString(1,$Move.Length-1)
        if($Move -notmatch $this.MovePattern) {
            throw 'Invalid move'
        }
        else {
            switch ($Direction) {
                'L' {
                    $NewBearing = ([Bearing].GetEnumNames().Count + $this.Bearing - 1) % [Bearing].GetEnumNames().Count
                }

                'R' {
                    $NewBearing = ([Bearing].GetEnumNames().Count + $this.Bearing + 1) % [Bearing].GetEnumNames().Count
                }
            }
            $this.Bearing = [Bearing]($NewBearing % 4)
            Switch([int]$this.Bearing) {
                0 {$this.Long = $this.Long + $Distance}
                1 {$this.Lat = $this.Lat + $Distance}
                2 {$this.Long = $this.Long - $Distance}
                3 {$this.Lat = $this.Lat - $Distance}
            }
        }
    }

    [Int] GetDistance () {
        return [Math]::Abs($this.Long) + [Math]::Abs($this.Lat)
    }
}

$Game = [Location]::new()
$Indata = 'R2, L1, R2, R1, R1, L3, R3, L5, L5, L2, L1, R4, R1, R3, L5, L5, R3, L4, L4, R5, R4, R3, L1, L2, R5, R4, L2, R1, R4, R4, L2, L1, L1, R190, R3, L4, R52, R5, R3, L5, R3, R2, R1, L5, L5, L4, R2, L3, R3, L1, L3, R5, L3, L4, R3, R77, R3, L2, R189, R4, R2, L2, R2, L1, R5, R4, R4, R2, L2, L2, L5, L1, R1, R2, L3, L4, L5, R1, L1, L2, L2, R2, L3, R3, L4, L1, L5, L4, L4, R3, R5, L2, R4, R5, R3, L2, L2, L4, L2, R2, L5, L4, R3, R1, L2, R2, R4, L1, L4, L4, L2, R2, L4, L1, L1, R4, L1, L3, L2, L2, L5, R5, R2, R5, L1, L5, R2, R4, R4, L2, R5, L5, R5, R5, L4, R2, R1, R1, R3, L3, L3, L4, L3, L2, L2, L2, R2, L1, L3, R2, R5, R5, L4, R3, L3, L4, R2, L5, R5'
$Indata = $Indata -split ', '
foreach($Move in $Indata) {$Game.Move($Move)}
$Game
''
'Shortest distance is: {0}' -f $Game.GetDistance()

