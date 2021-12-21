$instructions = Get-Content -Path 'input.txt'

$depth = 0
$position = 0
$aim = 0

foreach($instruction in $instructions) {
    [string]$command, [int]$count = $instruction -split ' '
    switch ($command) {
        'forward' { 
            $position += $count
            $depth += $aim * $count
        }
        'down' { $aim += $count}
        'up' { $aim -= $count}
        Default {}
    }
}

$product = $depth * $position
return $product