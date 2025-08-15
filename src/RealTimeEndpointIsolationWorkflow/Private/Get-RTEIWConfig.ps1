function Get-RTEIWConfig {
    param([string]$Path = (Join-Path (Resolve-Path "$PSScriptRoot/..").Path "config"))
    Import-Module powershell-yaml -ErrorAction Stop
    $cfg = @{
        policy     = (Get-Content (Join-Path $Path "policy.yml") -Raw | ConvertFrom-Yaml)
        connectors = (Get-Content (Join-Path $Path "connectors.yml") -Raw | ConvertFrom-Yaml)
        approvals  = (Get-Content (Join-Path $Path "approvals.yml") -Raw | ConvertFrom-Yaml)
    }
    return $cfg
}
