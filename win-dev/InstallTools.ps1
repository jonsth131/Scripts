$GeneralTools = @(
    'cmder',
    'googlechrome',
    'firefox',
    '7zip',
    'notepadplusplus'
)

$DevTools = @(
    'git',
    'jetbrainstoolbox',
    'dotultimate',
    'vscode',
    'postman',
    'dotnet-sdk',
    'azure-cli',
    'azure-functions-core-tools',
    'microsoftazurestorageexplorer',
    'azure-cosmosdb-emulator',
    'sql-server-express',
    'azurestorageemulator',
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

Write-Host "Installing Ubuntu in WSL"
& wsl --install -d Ubuntu

Write-Host "Installing Chocolatey"
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

& choco feature enable -n allowGlobalConfirmation

Write-Host "Installing General Tools"
Install-Packages $GeneralTools

Write-Host "Installing Dev Tools"
Install-Packages $DevTools

Write-Host "Installing Security Tools"
Install-Packages $SecurityTools
