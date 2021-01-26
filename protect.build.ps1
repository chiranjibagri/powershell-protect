$Output = "$PSScriptRoot\output"

task Clean {
    Remove-Item -Path $Output -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$PSScriptRoot\publish" -Force -Recurse -ErrorAction SilentlyContinue
}

task Build {
    & "$PSScriptRoot\nuget.exe" restore

    $path = .\vswhere -latest -requires Microsoft.Component.MSBuild -find MSBuild\**\Bin\MSBuild.exe | select-object -first 1
    & $path .\AmsiProvider.sln /p:Configuration=Release /p:Platform=x64

    New-Item -Path "$Output\x64" -ItemType Directory
    Copy-Item "$PSScriptRoot\Engine\bin\Release\net462\x64\Engine.dll" "$Output\x64"
    Copy-Item "$PSScriptRoot\x64\Release\AmsiProvider.dll" "$Output\x64"
    Copy-Item "$PSScriptRoot\Engine\bin\Release\net462\*.dll" "$Output"

    Push-Location "$Output"
    Start-Process "$PSScriptRoot\PowerShellProtect\Obfuscar.Console.exe" -ArgumentList "$PSScriptRoot\PowerShellProtect\obfuscar.xml" -Wait -NoNewWindow
    Remove-Item "$Output\PowerShellProtect.dll" -Force
    Move-Item "$Output\obfuscated\PowerShellProtect.dll" "$Output\PowerShellProtect.dll" 
    Remove-Item "$Output\obfuscated" -Recurse
    Pop-Location

    & $path .\AmsiProvider.sln /p:Configuration=Release /p:Platform=x86

    New-Item -Path "$Output\x86" -ItemType Directory
    Copy-Item "$PSScriptRoot\Engine\bin\Release\net462\x86\Engine.dll" "$Output\x86"
    Copy-Item "$PSScriptRoot\Release\AmsiProvider.dll" "$Output\x86"

    Copy-Item "$PSScriptRoot\PowerShellProtect.psd1" $Output
    Copy-Item "$PSScriptRoot\PowerShellProtect.psm1" $Output
    Copy-Item "$PSScriptRoot\Engine\Configuration\config.xml" $Output
}

task Test {
    $Pester = Get-Module -Name Pester -ListAvailable
    if (-not $Pester)
    {
        Install-Module Pester -Scope CurrentUser -Force
    }

    Invoke-Pester -Path "$PSScriptRoot\tests"
}

task Publish {
    New-Item -ItemType Directory -Path "$PSScriptRoot\publish\PowerShellProtect"
    Copy-Item -Path "$output\*" -Destination "$PSScriptRoot\publish\PowerShellProtect" -Recurse -Container
    Publish-Module -Path "$PSScriptRoot\publish\PowerShellProtect" -NuGetApiKey $Env:PowerShellGalleryKey
}

task . Clean, Build