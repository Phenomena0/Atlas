$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$atlasRoot = Join-Path $repoRoot "atlas"

Write-Host "Starting deployment of Atlas workload plane"
$unraidHost = "192.168.4.55"

Write-Host "Ensuring Alloy config directory exists on Unraid..."
ssh root@$unraidHost "mkdir -p /mnt/user/appdata/alloy"

Write-Host "Copying Alloy config to Unraid host..."
scp $atlasRoot\workload-plane\log\configs\alloy\config.alloy root@${unraidHost}:/mnt/user/appdata/alloy/config.alloy

docker --context unraid compose `
  -f "$atlasRoot\workload-plane\core.yml" `
  -f "$atlasRoot\workload-plane\automation\automation.yml" `
  -f "$atlasRoot\workload-plane\download\download.yml" `
  -f "$atlasRoot\workload-plane\log\log.yml" `
  -f "$atlasRoot\workload-plane\media\media.yml" `
  up -d
Write-Host "Workload plane services deployed."


Write-Host "Starting deployment of Atlas control plane"

docker --context unraid compose `
  -f "$atlasRoot\control-plane\core.yml" `
  -f "$atlasRoot\control-plane\alert\alert.yml" `
  -f "$atlasRoot\control-plane\monitor\monitor.yml" `
  -f "$atlasRoot\control-plane\observe\observe.yml" `
  -f "$atlasRoot\control-plane\log\log.yml" `
  --env-file "$atlasRoot\control-plane\env\.env" `
  --env-file "$atlasRoot\control-plane\env\.secrets.env" `
  up -d
Write-Host "Control plane services deployed."
