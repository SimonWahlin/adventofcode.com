$instructions = Get-Content -Path 'input.txt'

class BingoBoard {
    [int[][]] $Board
    [string] $Key
    [bool] $HasWon
    [int] $Score

    [bool] Test() {
        for ($x = 0; $x -lt 5; $x++) {
            [int[]]$Line = $this.Board[$x] | Where-Object { $_ -ge 0 }
            if ($Line.Count -eq 0) {
                $this.HasWon = $true
                return $true
            }

            $Col = $this.Board | ForEach-Object -Process { 
                $_ | Select-Object -Index $x 
            } | Where-Object { $_ -ge 0 }

            if ($Col.Count -eq 0) {
                $this.HasWon = $true
                return $true
            }
        }
        return $false
    }

    [void] MarkNumber ([int]$Number) {
        for ($x = 0; $x -lt 5; $x++) {
            for ($y = 0; $y -lt 5; $y++) {
                if ($this.Board[$x][$y] -eq $Number) {
                    $this.Board[$x][$y] = $this.Board[$x][$y] * -1 - 1
                }
            }
        }
    }

    [int] GetPoints() {
        $Points = $this.Board | Foreach-Object {$_} | Where-Object {$_ -ge 0} | Measure-Object -Sum | Select-Object -ExpandProperty Sum
        return $Points
    }

    BingoBoard ([string[]] $Lines) {
        if ($Lines -notmatch '^(\s{0,2}\d{1,2}){5}$' -or $Lines.Count -ne 5) {
            throw "Invalid input!"
        }
          
        [int[][]]$NewBoard = foreach ($line in $Lines) {
            , [int[]]($line.trim() -split '\s+')
        }
        $this.Board = $NewBoard

        $this.Key = -join ($NewBoard | ForEach-Object { $_ })
    }
}

$BingoNumbers = ($instructions[0] -split ',') -as [int[]]

$Boards = [System.Collections.Hashtable]::Synchronized(@{})

for ($i = 2; $i -lt $instructions.Count; $i = $i + 6) {
    $BoardInput = $instructions[$i..($i + 4)]
    $NewBoard = [BingoBoard]::new($BoardInput)
    $Boards[$NewBoard.Key] = $NewBoard
}

$WinningBoards = for ($BingoNum = 0; $BingoNum -lt $BingoNumbers.Count; $BingoNum++) {
    Write-Host "Nuber: $BingoNum"
    foreach($key in $Boards.Keys) {
        if(-not $Boards[$key].HasWon) {
            $Boards[$key].MarkNumber($BingoNumbers[$BingoNum])
            if($Boards[$key].Test()) {
                Write-Host "We have a winner!"
                $Points = $Boards[$key].GetPoints()
                $Score = $BingoNumbers[$BingoNum] * $Points
                $Boards[$key].Score = $Score
                Write-Output $Boards[$key]
            }
        }
    } 
}

$WinningBoards[0].Score