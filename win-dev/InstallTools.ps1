$GeneralTools = @(
    'cmder',
    'googlechrome',
    'firefox',
    'microsoft-windows-terminal',
    '7zip',
    'notepadplusplus',
    'jre8'
)

$DevTools = @(
    'git',
    'jetbrains-toolbox',
    'jetbrains-rider',
    'vscode',
    'postman',
    'dotnet-sdk',
    'azure-cli',
    'azure-functions-core-tools',
    'microsoftazurestorageexplorer',
    'azure-cosmosdb-emulator',
    'docker-desktop',
    'nodejs',
    'yarn'
)

$SecurityTools = @(
    'zap',
    'burp-suite-free-edition'
)

function Invoke-Choco {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string] $PackageName
    )

    & choco install $PackageName
}

function Install-Packages {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string[]] $Packages
    )

    foreach ($item in $Packages) {
        Invoke-Choco $item
    }
}

Write-Host "Installing Debian in WSL"
& wsl --install -d Debian

$testchoco = powershell choco -v
if(-not($testchoco)){
    Write-Host "Seems Chocolatey is not installed, installing now"
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else{
    Write-Host "Chocolatey Version $testchoco is already installed"
}

& choco feature enable -n allowGlobalConfirmation

Write-Host "Installing General Tools"
Install-Packages $GeneralTools

Write-Host "Installing Dev Tools"
Install-Packages $DevTools

Write-Host "Installing Security Tools"
Install-Packages $SecurityTools
