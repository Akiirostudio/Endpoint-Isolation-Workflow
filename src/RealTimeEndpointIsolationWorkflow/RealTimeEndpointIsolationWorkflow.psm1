# RealTimeEndpointIsolationWorkflow.psm1 — auto-load module components
Get-ChildItem -Path $PSScriptRoot/Private -Filter *.ps1 -Recurse | ForEach-Object {. $_.FullName}
Get-ChildItem -Path $PSScriptRoot/Public -Filter *.ps1 -Recurse | ForEach-Object {. $_.FullName}
Get-ChildItem -Path $PSScriptRoot/Connectors -Filter *.ps1 -Recurse | ForEach-Object {. $_.FullName}
Get-ChildItem -Path $PSScriptRoot/Actions -Filter *.ps1 -Recurse | ForEach-Object {. $_.FullName}
