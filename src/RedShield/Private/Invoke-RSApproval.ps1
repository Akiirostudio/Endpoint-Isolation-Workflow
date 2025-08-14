function Invoke-RSApproval {
    param(
        [Parameter(Mandatory)][string] $Message,
        [Parameter(Mandatory)][bool]   $RequiresTwo
    )
    $cfg        = Get-RSConfig
    $approval   = $cfg.approvals
    $webhookUrl = Get-Secret -Name "RS_SLACK_WEBHOOK" -ErrorAction SilentlyContinue
    if (-not $webhookUrl) { throw "Slack webhook secret RS_SLACK_WEBHOOK not found in vault." }
    $payload = @{ text = $Message } | ConvertTo-Json -Depth 5
    try { Invoke-RestMethod -Method Post -Uri $webhookUrl -Body $payload -ContentType "application/json" | Out-Null } catch {}
    $deadline = (Get-Date).AddSeconds([int]$approval.timeoutSeconds)
    Write-Host "Awaiting approval until $deadline ..."
    $decision = $null
    while ((Get-Date) -lt $deadline -and -not $decision) {
        $input = Read-Host "Type APPROVE / DENY / SOFT"
        if ($input -match "^(APPROVE|DENY|SOFT)$") { $decision = $Matches[1] }
    }
    if (-not $decision) { $decision = ($approval.autoSoftIfTimeout ? "SOFT" : "DENY") }
    $approvers = @("on-call-analyst")
    if ($RequiresTwo -and $decision -eq "APPROVE") { $approvers += "duty-manager" }
    [pscustomobject]@{
        Decision  = $decision
        Approvers = $approvers
        Timestamp = Get-Date
    }
}
