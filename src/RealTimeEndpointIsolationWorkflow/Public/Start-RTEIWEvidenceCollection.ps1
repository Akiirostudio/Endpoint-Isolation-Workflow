function Start-RSEvidenceCollection {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $DeviceId,
        [Parameter(Mandatory)][ValidateSet("Null","CrowdStrike","MDE")] [string] $Vendor
    )
    $res = Invoke-RSVendorAction -Vendor $Vendor -Operation Evidence -Params @{ DeviceId = $DeviceId }
    Write-RSAudit -Action "evidence" -Data @{ device=$DeviceId; vendor=$Vendor; result=$res }
    return $res
}
