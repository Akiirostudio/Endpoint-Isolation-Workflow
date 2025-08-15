function Invoke-RTEIWIsolate {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)][string] $DeviceId,
        [Parameter(Mandatory)][ValidateSet("Null","CrowdStrike","MDE")] [string] $Vendor,
        [ValidateSet("soft","hard","scoped")] [string] $Level = "soft",
        [string] $Reason = "incident-response",
        [switch] $EvidenceFirst
    )

    $ctx = @{
        device       = $DeviceId
        vendor       = $Vendor
        level        = $Level
        reason       = $Reason
        site         = "default"
        criticality  = "high"
        batchPercent = 1
        concurrent   = 1
    }
    $decision = Invoke-RTEIWPolicy -Context $ctx
    $needTwo  = [bool]$decision.RequiresTwo

    if ($EvidenceFirst -or $decision.EvidenceFirst) {
        Start-RTEIWEvidenceCollection -DeviceId $DeviceId -Vendor $Vendor | Out-Null
    }

    $approval = Invoke-RTEIWApproval -Message "Isolate $Vendor::$DeviceId as $Level for $Reason" -RequiresTwo:$needTwo
    if ($approval.Decision -eq "DENY") { throw "Isolation denied by approver(s)." }
    if ($approval.Decision -eq "SOFT") { $Level = "soft" }

    if ($PSCmdlet.ShouldProcess("$Vendor::$DeviceId", "Isolate ($Level)")) {
        $result = Invoke-RTEIWVendorAction -Vendor $Vendor -Operation Isolate -Params @{ DeviceId=$DeviceId; Level=$Level }
        Write-RTEIWAudit -Action "isolate" -Data @{ device=$DeviceId; vendor=$Vendor; level=$Level; approvers=$approval.Approvers; result=$result }
        return $result
    }
}
