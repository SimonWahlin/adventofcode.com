Context 'Day 2' {
    BeforeAll {
        . ./Day2Functions.ps1
    }

    Describe 'Step 1' {
        It 'Passes examples' {
            Invoke-IntCode -Memory 1, 0, 0, 0, 99 | Should -be 2
            Invoke-IntCode -Memory 2, 3, 0, 3, 99 | Should -be 2
            Invoke-IntCode -Memory 2, 4, 4, 5, 99, 0 | Should -be 2
            Invoke-IntCode -Memory 1, 1, 1, 4, 99, 5, 6, 0, 99 | Should -be 30
        }

        It 'Solves the problem' {
            $InputData = (Get-Content -Path ./input.txt)
            $InputArray = [int[]]($InputData -replace '\s' -split ',')
            $InputArray[1] = 12
            $InputArray[2] = 2
            $Script:Step1Answer = Invoke-IntCode -Memory $InputArray
            $Step1Answer | Should -Not -BeNullOrEmpty
        }
    }

    Describe 'Step 2' {
        It 'Solves the problem' {
            $InputData = (Get-Content -Path ./input.txt)
            $InitialMemory = [int[]]($InputData -replace '\s' -split ',')
            $Target = 19690720
            :outer foreach ($Verb in 0..99) {
                foreach ($Noun in 0..99) {
                    $Result = Invoke-Computer -InitialMemory $InitialMemory -Verb $Noun -Noun $Verb
                    if ($Result -eq $Target) {
                        # Write-Output "Verb: $Verb, Noun: $Noun"
                        $Script:Step2Answer = "$Verb$Noun"
                        break outer
                    }
                }
            }
            $Script:Step2Answer | Should -Not -BeNullOrEmpty
        }
    }
}

Write-Host "Step1Answer is: $Script:Step1Answer" -ForegroundColor Magenta
Write-Host "Step2Answer is: $Script:Step2Answer" -ForegroundColor Magenta






$Answer