function Write-RTEIWAudit {
    param(
        [Parameter(Mandatory)][string]    $Action,
        [Parameter(Mandatory)][hashtable] $Data
    )
    $logDir = Join-Path (Resolve-Path "$PSScriptRoot/..").Path "logs"
    if (-not (Test-Path $logDir)) { New-Item -ItemType Directory -Path $logDir | Out-Null }

    $line = [pscustomobject]@{ ts = (Get-Date).ToString("o"); action = $Action; data = $Data } | ConvertTo-Json -Depth 8
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($line)
    $ms    = [System.IO.MemoryStream]::new($bytes)
    $hash  = (Get-FileHash -InputStream $ms -Algorithm SHA256).Hash
    $entry = "{0} {1}" -f $hash, $line
    Add-Content -Path (Join-Path $logDir "audit.log") -Value $entry
}
