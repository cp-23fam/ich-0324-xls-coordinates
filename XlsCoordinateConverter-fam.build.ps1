Task Test {
    $config = New-PesterConfiguration
    $config.Run.Path = ".\XlsCoordinateConverter-fam.Tests.ps1"
    $config.CodeCoverage.Enabled = $true
    
    $config.CodeCoverage.Path = ".\XlsCoordinateConverter-fam.ps1"
    $config.CodeCoverage.CoveragePercentTarget = 100
    $config.CodeCoverage.OutputPath = 'coverage.xml'

    Invoke-Pester -Configuration $config
}