param(
  [ValidateSet("isolate","deisolate","state","evidence","batch-isolate")] [string]$Command,
  [string]$DeviceId,
  [string]$Vendor = "Null",
  [ValidateSet("soft","hard","scoped")] [string]$Level = "soft",
  [string] $Reason = "incident-response",
  [string[]]$DeviceList
)
Import-Module (Join-Path $PSScriptRoot "../src/RealTimeEndpointIsolationWorkflow") -Force
switch ($Command) {
  "isolate"       { Invoke-RTEIWIsolate -DeviceId $DeviceId -Vendor $Vendor -Level $Level -Reason $Reason -EvidenceFirst | Format-List }
  "deisolate"     { Invoke-RTEIWDeisolate -DeviceId $DeviceId -Vendor $Vendor -Reason $Reason | Format-List }
  "state"         { Get-RTEIWIsolationState -DeviceId $DeviceId -Vendor $Vendor | Format-List }
  "evidence"      { Start-RTEIWEvidenceCollection -DeviceId $DeviceId -Vendor $Vendor | Format-List }
  "batch-isolate" { Invoke-RTEIWBatchIsolate -DeviceIds $DeviceList -Vendor $Vendor -Level $Level -Reason $Reason | Format-List }
  default         { Write-Error "Unknown command: $Command" }
}
