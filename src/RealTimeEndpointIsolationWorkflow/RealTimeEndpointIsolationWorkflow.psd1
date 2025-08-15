@{
    RootModule        = "RealTimeEndpointIsolationWorkflow.psm1"
    ModuleVersion     = "0.1.0"
    GUID              = "ef5f1c0b-2a0e-4b2f-9d55-8cb8ee0f3b74"
    Author            = "Security Engineering"
    CompanyName       = "Real-Time Endpoint Isolation Workflow"
    Copyright         = "(c) 2025 Real-Time Endpoint Isolation Workflow"
    Description       = "Vendor-agnostic endpoint isolation orchestration."
    PowerShellVersion = "7.0"
    FunctionsToExport = @("Invoke-RTEIWIsolate","Invoke-RTEIWDeisolate","Get-RTEIWIsolationState","Start-RTEIWEvidenceCollection")
    NestedModules     = @()
    PrivateData       = @{}
}
