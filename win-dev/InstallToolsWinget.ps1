$GeneralTools = @(
    'Microsoft.WindowsTerminal',
    'Google.Chrome',
    'Mozilla.Firefox',
    '7zip.7zip',
    'Notepad++.Notepad++'
)

$DevTools = @(
    'Git.Git',
    'JetBrains.Toolbox',
    'Microsoft.VisualStudioCode',
    'Postman.Postman',
    'Microsoft.dotnet',
    'Microsoft.AzureCLI',
    'Microsoft.AzureFunctionsCoreTools',
    'Microsoft.AzureStorageExplorer',
    'Microsoft.AzureCosmosEmulator',
    'Microsoft.SQLServer.2019.Express',
    'Docker.DockerDesktop',
    'OpenJS.NodeJS',
    'Yarn.Yarn'
)

$SecurityTools = @(
    'OWASP.ZAP',
    'PortSwigger.BurpSuite.Community'
)

function Invoke-Winget {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string] $PackageName
    )

    & winget install -e --id $PackageName
}

function Install-Packages {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string[]] $Packages
    )

    foreach ($item in $Packages) {
        Invoke-Winget $item
    }
}

Write-Host "Installing Ubuntu in WSL"
& wsl --install -d Ubuntu

Write-Host "Installing General Tools"
Install-Packages $GeneralTools

Write-Host "Installing Dev Tools"
Install-Packages $DevTools
& npm install azurite -g
& dotnet tool install Nuke.GlobalTool --global

Write-Host "Installing Security Tools"
Install-Packages $SecurityTools
