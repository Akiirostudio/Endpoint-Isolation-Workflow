function Start-RTEIWEvidenceCollection {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)][string] $DeviceId,
        [Parameter(Mandatory)][ValidateSet("Null","CrowdStrike","MDE")] [string] $Vendor
    )
    if ($PSCmdlet.ShouldProcess("$Vendor::$DeviceId", "Start evidence collection")) {
        $res = Invoke-RTEIWVendorAction -Vendor $Vendor -Operation Evidence -Params @{ DeviceId = $DeviceId }
        Write-RTEIWAudit -Action "evidence" -Data @{ device=$DeviceId; vendor=$Vendor; result=$res }
        return $res
    }
}
