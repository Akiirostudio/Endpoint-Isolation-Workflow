function Invoke-RTEIWBatchIsolate {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string[]] $DeviceIds,
        [Parameter(Mandatory)][ValidateSet("Null","CrowdStrike","MDE")] [string] $Vendor,
        [ValidateSet("soft","hard","scoped")] [string] $Level = "soft",
        [string] $Reason = "incident-response",
        [int] $MaxPerRun = 25
    )
    if ($DeviceIds.Count -gt $MaxPerRun) { throw "Circuit breaker: requested $($DeviceIds.Count) > MaxPerRun $MaxPerRun" }
    $results = @()
    foreach ($id in $DeviceIds) {
        $res = Invoke-RTEIWIsolate -DeviceId $id -Vendor $Vendor -Level $Level -Reason $Reason -EvidenceFirst -WhatIf:$false
        $results += $res
        Start-Sleep -Milliseconds (Get-Random -Minimum 250 -Maximum 900)
    }
    return $results
}
