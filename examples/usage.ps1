# Store Slack webhook secret once (example)
# Set-Secret -Name RS_SLACK_WEBHOOK -Secret "https://hooks.slack.com/services/XXX/YYY/ZZZ"

# Simulate isolate
& "$PSScriptRoot/../scripts/redshield.ps1" -Command isolate -DeviceId "host-123" -Vendor Null -Level soft -Reason "IOC:1234"

# Check state
& "$PSScriptRoot/../scripts/redshield.ps1" -Command state -DeviceId "host-123" -Vendor Null

# De-isolate
& "$PSScriptRoot/../scripts/redshield.ps1" -Command deisolate -DeviceId "host-123" -Vendor Null -Reason "Cleaned"
