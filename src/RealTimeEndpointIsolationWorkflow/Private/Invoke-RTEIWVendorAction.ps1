function Invoke-RSVendorAction {
    param(
        [Parameter(Mandatory)][string] $Vendor,
        [Parameter(Mandatory)][ValidateSet("Isolate","Deisolate","State","Evidence")] [string] $Operation,
        [Parameter(Mandatory)][hashtable] $Params
    )
    $modulePath = Join-Path $PSScriptRoot "..\Connectors\${Vendor}.ps1"
    if (-not (Test-Path $modulePath)) { throw "Connector for vendor \"$Vendor\" not found." }
    . $modulePath
    switch ($Operation) {
        "Isolate"   { return Invoke-"$Vendor"-Isolate  @Params }
        "Deisolate" { return Invoke-"$Vendor"-Deisolate @Params }
        "State"     { return Get-"$Vendor"-IsolationState @Params }
        "Evidence"  { return Start-"$Vendor"-EvidenceCollection @Params }
    }
}
