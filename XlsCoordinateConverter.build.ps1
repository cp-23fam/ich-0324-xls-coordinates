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
    If (!(Test-Path -Path './build')) {
        New-Item './build' -ItemType Directory
    }
    
    Copy-Item -Path './XlsCoordinateConverter.ps1' -Destination './build/XlsCoordinateConverter-fam.psm1' -Force
    Add-Content -Path './build/XlsCoordinateConverter-fam.psm1' -Value 'Export-ModuleMember -Function ConvertFrom-XlsCoordinates'
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
    Import-Module './build/XlsCoordinateConverter-fam'
}

Task Publish {
    get-content .env | ForEach-Object {
        $name, $value = $_.split('=')
        set-content env:\$name $value
    }

    $APIKey = $Env:API_KEY
    Write-Host $APIKey
    Publish-Module -Path './build' -NuGetApiKey $APIKey
}

Task . TestAndAnalyse, Build, Release