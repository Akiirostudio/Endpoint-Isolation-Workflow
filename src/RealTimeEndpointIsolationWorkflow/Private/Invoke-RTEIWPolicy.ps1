function Invoke-RTEIWPolicy {
    param([Parameter(Mandatory)][hashtable] $Context)
    $cfg    = Get-RTEIWConfig
    $policy = $cfg.policy

    $allowedLevels = @("soft","hard","scoped")
    if ($Context.level -notin $allowedLevels) { throw "Invalid isolation level: $($Context.level)" }

    $site   = $Context.site ?? "default"
    $siteCfg = $policy.sites[$site]
    if (-not $siteCfg) { $siteCfg = $policy.sites.default }

    if ($Context.batchPercent -gt $siteCfg.maxBatchPercent) { throw "Blast-radius exceeded for site $site" }
    if ($Context.concurrent   -gt $siteCfg.maxConcurrent)   { throw "Concurrent isolation cap exceeded for site $site" }

    $requiresTwo = $Context.criticality -eq "critical" -or $Context.level -eq "hard"

    [pscustomobject]@{
        ApprovedBy     = @()
        RequiresTwo    = $requiresTwo
        Site           = $site
        SoftFallback   = $siteCfg.softFallback
        EvidenceFirst  = $siteCfg.evidenceFirst
        TimeoutSeconds = $policy.approvalTimeoutSeconds
    }
}
