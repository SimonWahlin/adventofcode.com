$instructions = Get-Content -Path 'input.txt'

$depth = 0
$position = 0

foreach($instruction in $instructions) {
    [string]$command, [int]$count = $instruction -split ' '
    switch ($command) {
        'forward' { $position += $count }
        'down' { $depth += $count}
        'up' { $depth -= $count}
        Default {}
    }
}

$product = $depth * $position
return $product