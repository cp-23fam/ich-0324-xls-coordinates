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

    It 'A String with a number supeior to 1048576' {
        $cell = 'A1048577'

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

    It 'A String after XFD is not valid' {
        $cell = 'XFE'
        $table = StringToNumberTable -String $cell

        { NumberTableToRow -Table $table } | Should -Throw
    }
}

Describe 'Total' {
    # BeforeEach {
    #     Mock SplitCell { return ... }
    # }

    It 'D3 converts to [4, 3]' {
        $cell = 'D3'

        [hashtable] $result = ConvertFrom-XlsCoordinates -Cell $cell

        $result['Column'] | Should -Be 4
        $result['Row'] | Should -Be 3
    }

    It 'AA51 converts to [27, 51]' {
        $cell = 'AA51'

        [hashtable] $result = ConvertFrom-XlsCoordinates -Cell $cell

        $result['Column'] | Should -Be 27
        $result['Row'] | Should -Be 51
    }
}