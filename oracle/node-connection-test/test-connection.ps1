[CmdletBinding()]
param(
    [Parameter()]
    [ValidatePattern('^[A-Za-z][A-Za-z0-9_]{0,29}$')]
    [string]$DatabaseUser = 'APP_USER',

    [Parameter()]
    [string]$Dsn = 'your_adb_tp',

    [Parameter()]
    [string]$WalletDirectory = $env:DB_WALLET_DIR
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
$originalLocation = Get-Location

try {
    if ([string]::IsNullOrWhiteSpace($WalletDirectory)) {
        throw '请通过 -WalletDirectory 或 DB_WALLET_DIR 指定 Wallet 目录。'
    }
    if (-not (Test-Path -LiteralPath $WalletDirectory -PathType Container)) {
        throw "Wallet 目录不存在：$WalletDirectory"
    }

    foreach ($walletFile in @('tnsnames.ora', 'ewallet.pem')) {
        $walletPath = Join-Path $WalletDirectory $walletFile
        if (-not (Test-Path -LiteralPath $walletPath -PathType Leaf)) {
            throw "缺少 Wallet 文件：$walletPath"
        }
    }

    Set-Location -LiteralPath $PSScriptRoot

    $env:DB_USER = $DatabaseUser.ToUpperInvariant()
    $env:DB_DSN = $Dsn
    $env:DB_WALLET_DIR = (Resolve-Path -LiteralPath $WalletDirectory).Path

    $databaseSecret = Read-Host -Prompt "请输入 $($env:DB_USER) 数据库密码" -AsSecureString
    $env:DB_PASSWORD = ConvertFrom-SecureValue $databaseSecret

    $walletSecret = Read-Host -Prompt '请输入 Wallet 密码' -AsSecureString
    $env:DB_WALLET_PASSWORD = ConvertFrom-SecureValue $walletSecret

    npm test
    if ($LASTEXITCODE -ne 0) {
        throw "数据库连接测试失败，npm 退出码：$LASTEXITCODE"
    }
}
finally {
    Remove-Item Env:DB_USER -ErrorAction SilentlyContinue
    Remove-Item Env:DB_PASSWORD -ErrorAction SilentlyContinue
    Remove-Item Env:DB_WALLET_PASSWORD -ErrorAction SilentlyContinue
    Remove-Item Env:DB_DSN -ErrorAction SilentlyContinue
    Remove-Item Env:DB_WALLET_DIR -ErrorAction SilentlyContinue

    $databaseSecret = $null
    $walletSecret = $null

    Set-Location -LiteralPath $originalLocation
}
