param(
  [ValidateSet("isolate","deisolate","state","evidence","batch-isolate")] [string]$Command,
  [string]$DeviceId,
  [string]$Vendor = "Null",
  [ValidateSet("soft","hard","scoped")] [string]$Level = "soft",
  [string]$Reason = "incident-response",
  [string[]]$DeviceList
)
Import-Module (Join-Path $PSScriptRoot "..\src\RedShield") -Force

switch ($Command) {
  "isolate"       { Invoke-RSIsolate -DeviceId $DeviceId -Vendor $Vendor -Level $Level -Reason $Reason -EvidenceFirst | Format-List }
  "deisolate"     { Invoke-RSDeisolate -DeviceId $DeviceId -Vendor $Vendor -Reason $Reason | Format-List }
  "state"         { Get-RSIsolationState -DeviceId $DeviceId -Vendor $Vendor | Format-List }
  "evidence"      { Start-RSEvidenceCollection -DeviceId $DeviceId -Vendor $Vendor | Format-List }
  "batch-isolate" { Invoke-RSBatchIsolate -DeviceIds $DeviceList -Vendor $Vendor -Level $Level -Reason $Reason | Format-List }
  default         { Write-Error "Unknown command: $Command" }
}
