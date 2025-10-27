param(
    $Configuration = 'Release',
    $Version = 'Minor',
    $SkipTests = $false,
    $SkipAnalyse = $false
)

Task TestAndAnalyse {

    $config = New-PesterConfiguration
    $config.Run.Path = "./XlsCoordinateConverter.Tests.ps1"
    $config.CodeCoverage.Enabled = $true
    
    $config.CodeCoverage.Path = "./XlsCoordinateConverter.ps1"
    $config.CodeCoverage.CoveragePercentTarget = 100
    $config.CodeCoverage.OutputPath = 'coverage.xml'

    If (!$SkipTests) {
        Invoke-Pester -Configuration $config
    }

    If (!$SkipAnalyse) {
        Invoke-ScriptAnalyzer ./XlsCoordinateConverter.ps1 > Analyser.log
    }
}

Task Build {
    If (!(Test-Path -Path ./build)) {
        New-Item './build' -ItemType Directory
    }
    
    Copy-Item -Path './XlsCoordinateConverter.ps1' -Destination './build/XlsCoordinateConverter-fam.psm1' -Force
}

Task Release {
    [Version] $ModuleVersion = (Get-Module -Name XlsCoordinateConverter-fam).Version

    switch ($Version) {
        'Major' { $New = [Version]::new($ModuleVersion.Major + 1, 0, 0) }
        'Minor' { $New = [Version]::new($ModuleVersion.Major, $ModuleVersion.Minor + 1, 0) }
        'Patch' { $New = [Version]::new($ModuleVersion.Major, $ModuleVersion.Minor, $ModuleVersion.Build + 1) }
    }
    
    Update-ModuleManifest -Path './XlsCoordinateConverter.psd1' -ModuleVersion $New
    Copy-Item -Path './XlsCoordinateConverter.psd1' -Destination './build/XlsCoordinateConverter-fam.psd1' -Force
    Remove-Module 'XlsCoordinateConverter-fam'
    Import-Module './build/XlsCoordinateConverter-fam'
}

Task Publish {
    $APIKey = 'YOUR-API-KEY'
    Publish-Module -Path './build' -NuGetApiKey $APIKey
}

Task . TestAndAnalyse, Build, Release