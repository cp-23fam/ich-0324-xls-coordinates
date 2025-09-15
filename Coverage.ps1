$config = New-PesterConfiguration
$config.Run.Path = ".\XlsCoordinateConverter-fam.Tests.ps1"
$config.CodeCoverage.Enabled = $true

Invoke-Pester -Configuration $config
