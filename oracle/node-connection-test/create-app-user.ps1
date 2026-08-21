[CmdletBinding()]
param(
    [Parameter()]
    [ValidatePattern('^[A-Za-z][A-Za-z0-9_]{0,29}$')]
    [string]$AppUser = 'APP_USER'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function ConvertFrom-SecureValue {
    param(
        [Parameter(Mandatory)]
        [Security.SecureString]$SecureValue
    )

    return [Net.NetworkCredential]::new('', $SecureValue).Password
}

$databaseSecret = $null
$walletSecret = $null
$applicationSecret = $null
$originalLocation = Get-Location

try {
    Set-Location -LiteralPath $PSScriptRoot

    $env:DB_USER = 'ADMIN'
    $env:APP_DB_USER = $AppUser.ToUpperInvariant()

    $databaseSecret = Read-Host -Prompt '请输入 ADMIN 数据库密码' -AsSecureString
    $env:DB_PASSWORD = ConvertFrom-SecureValue $databaseSecret

    $walletSecret = Read-Host -Prompt '请输入 Wallet 密码' -AsSecureString
    $env:DB_WALLET_PASSWORD = ConvertFrom-SecureValue $walletSecret

    $applicationSecret = Read-Host -Prompt "请为 $($env:APP_DB_USER) 设置密码" -AsSecureString
    $env:APP_DB_PASSWORD = ConvertFrom-SecureValue $applicationSecret

    npm run create-user
    if ($LASTEXITCODE -ne 0) {
        throw "创建数据库用户失败，npm 退出码：$LASTEXITCODE"
    }
}
finally {
    Remove-Item Env:DB_USER -ErrorAction SilentlyContinue
    Remove-Item Env:DB_PASSWORD -ErrorAction SilentlyContinue
    Remove-Item Env:DB_WALLET_PASSWORD -ErrorAction SilentlyContinue
    Remove-Item Env:APP_DB_USER -ErrorAction SilentlyContinue
    Remove-Item Env:APP_DB_PASSWORD -ErrorAction SilentlyContinue

    $databaseSecret = $null
    $walletSecret = $null
    $applicationSecret = $null

    Set-Location -LiteralPath $originalLocation
}
