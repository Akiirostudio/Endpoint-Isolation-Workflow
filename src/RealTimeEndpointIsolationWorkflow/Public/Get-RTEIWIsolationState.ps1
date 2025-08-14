function Get-RSIsolationState {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $DeviceId,
        [Parameter(Mandatory)][ValidateSet("Null","CrowdStrike","MDE")] [string] $Vendor
    )
    $res = Invoke-RSVendorAction -Vendor $Vendor -Operation State -Params @{ DeviceId = $DeviceId }
    Write-RSAudit -Action "state" -Data @{ device=$DeviceId; vendor=$Vendor; result=$res }
    return $res
}
