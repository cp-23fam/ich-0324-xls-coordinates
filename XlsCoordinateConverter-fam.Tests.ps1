BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Split Cell' {
    It 'The separaction return the correct number of letter with the corect row' {
        $cell = 'A2'
        $result = SplitCell -Cell $cell
        
        $result.Count | Should -Be 2
        $result[0] | Should -BeOfType String
        $result[1] | Should -BeOfType int
    }

    It 'A string with no number throws an argument error' {
        $cell = 'TATA'
        { SplitCell -Cell $cell } | Should -Throw
    }

    It 'A string with no letters throws an argument error' {
        $cell = '123'
        { SplitCell -Cell $cell } | Should -Throw
    }

}
Describe 'String to table' {
    It 'The returned table is the same length as the String length' {
        $cell = 'DAB'
        $table = StringToNumberTable -String $cell
        $result = $table.Length

        $result | Should -Be $cell.Length
    }
    
    It 'The returnde table has the right value' {
        $cell = 'DAB'
        $result = StringToNumberTable -String $cell
    
        $result | Should -Be @(4, 1, 2)
    }

    It 'A lowercase string gets converted to uppercase and runs no error' {
        $cell = 'dab'
        $result = StringToNumberTable -String $cell
    
        $result | Should -Be @(4, 1, 2)
    }
}
Describe 'Table to Row' {
    It 'The Converted value is correct' {
        $cell = 'DAB'
        $table = StringToNumberTable -String $cell

        $result = NumberTableToRow -Table $table

        $result | Should -Be 2732
    }
}