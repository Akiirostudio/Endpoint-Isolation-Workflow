function Invoke-MDE-Isolate { param([string]$DeviceId,[string]$Level) $device = $DeviceId; $level = $Level; throw "NotImplemented: MDE isolate for device $device with level $level" }

function Invoke-MDE-Deisolate { param([string]$DeviceId) $device = $DeviceId; throw "NotImplemented: MDE de-isolate for device $device" }

function Get-MDE-IsolationState { param([string]$DeviceId) $device = $DeviceId; throw "NotImplemented: MDE state check for device $device" }

function Start-MDE-EvidenceCollection { [CmdletBinding(SupportsShouldProcess)] param([string]$DeviceId) $device = $DeviceId; if ($PSCmdlet.ShouldProcess("$device", "Start evidence collection")) { throw "NotImplemented: MDE evidence collection for device $device" } }
