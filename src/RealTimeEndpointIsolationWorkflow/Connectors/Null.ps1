function Invoke-Null-Isolate { param([Parameter(Mandatory)][string]$DeviceId,[string]$Level) return [pscustomobject]@{ vendor="Null"; device=$DeviceId; level=$Level; status="simulated-isolated" } }
function Invoke-Null-Deisolate { param([Parameter(Mandatory)][string]$DeviceId) return [pscustomobject]@{ vendor="Null"; device=$DeviceId; status="simulated-deisolated" } }
function Get-Null-IsolationState { param([Parameter(Mandatory)][string]$DeviceId) return [pscustomobject]@{ vendor="Null"; device=$DeviceId; state="simulated" } }
function Start-Null-EvidenceCollection { param([Parameter(Mandatory)][string]$DeviceId) return [pscustomobject]@{ vendor="Null"; device=$DeviceId; evidence="simulated-collected" } }
