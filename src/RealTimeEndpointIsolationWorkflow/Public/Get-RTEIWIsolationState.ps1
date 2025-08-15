function Get-RTEIWIsolationState {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $DeviceId,
        [Parameter(Mandatory)][ValidateSet("Null","CrowdStrike","MDE")] [string] $Vendor
    )
    $res = Invoke-RTEIWVendorAction -Vendor $Vendor -Operation State -Params @{ DeviceId = $DeviceId }
    Write-RTEIWAudit -Action "state" -Data @{ device=$DeviceId; vendor=$Vendor; result=$res }
    return $res
}
