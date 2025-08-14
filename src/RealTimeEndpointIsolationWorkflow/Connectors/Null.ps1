function Invoke-Null-Isolate { param([Parameter(Mandatory)][string]$DeviceId,[string]$Level) return [pscustomobject]@{ vendor="Null"; device=$DeviceId; level=$Level; status="simulated-isolated" } }
