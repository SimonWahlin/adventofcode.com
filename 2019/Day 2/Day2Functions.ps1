function Invoke-IntCode {
    [CmdletBinding()]
    param (
        [int[]]$Memory
    )
    $InstructionPointer = 0
    $Parametercount = 1
    while ($InstructionPointer -lt $Memory.Length) {
        if ($Memory[$InstructionPointer] -eq 99) {
            Write-Verbose -Message "Opcode 99 encountered at position $InstructionPointer, program finnished."
            break
        }
        else {
            switch ($Memory[$InstructionPointer]) {
                1 {
                    $Parametercount = 4
                    $ResultIndex = 3
                    $Action = { param([int[]]$params) $Memory[$params[1]] + $Memory[$params[2]] }
                }
                2 {
                    $Parametercount = 4
                    $ResultIndex = 3
                    $Action = { param([int[]]$params) $Memory[$params[1]] * $Memory[$params[2]] }
                }
                default {
                    throw 'Unknown opcode!'
                }
            }
            $Opcode = $Memory[$InstructionPointer..($InstructionPointer + ($Parametercount - 1))]
            $Result = & $Action $Opcode
            $Memory[$OpCode[$ResultIndex]] = $Result
            $InstructionPointer = $InstructionPointer + $Parametercount
        }
    }
    return $Memory[0]
}

function Invoke-Computer {
    param(
        [int[]]$InitialMemory,
        [int]$Verb,
        [int]$Noun
    )
    $ProgramMemory = $InitialMemory.Clone()
    $ProgramMemory[1] = $Noun
    $ProgramMemory[2] = $Verb
    $Result = Invoke-IntCode -Memory $ProgramMemory
    return $Result
}