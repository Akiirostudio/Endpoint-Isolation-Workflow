function Invoke-RTEIWDeisolate {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)][string] $DeviceId,
        [Parameter(Mandatory)][ValidateSet("Null","CrowdStrike","MDE")] [string] $Vendor,
        [string] $Reason = "rollback"
    )

    $approval = Invoke-RTEIWApproval -Message "De-isolate $Vendor::$DeviceId for $Reason" -RequiresTwo:$false
    if ($approval.Decision -eq "DENY") { throw "De-isolation denied by approver(s)." }

    if ($PSCmdlet.ShouldProcess("$Vendor::$DeviceId","De-isolate")) {
        $result = Invoke-RTEIWVendorAction -Vendor $Vendor -Operation Deisolate -Params @{ DeviceId=$DeviceId }
        Write-RTEIWAudit -Action "deisolate" -Data @{ device=$DeviceId; vendor=$Vendor; approvers=$approval.Approvers; result=$result }
        return $result
    }
}
