Import-Module (Join-Path $PSScriptRoot "..\src\RedShield") -Force

Describe "RedShield Module" {
  It "imports the module" {
    (Get-Module RedShield) | Should -Not -BeNullOrEmpty
  }
  It "simulates isolate via Null connector" {
    $res = Invoke-RSIsolate -DeviceId "host-abc" -Vendor Null -Level soft -Reason "test" -EvidenceFirst
    $res.status | Should -Be "simulated-isolated"
  }
  It "simulates de-isolate via Null connector" {
    $res = Invoke-RSDeisolate -DeviceId "host-abc" -Vendor Null -Reason "test"
    $res.status | Should -Be "simulated-deisolated"
  }
}
