# Get drive with most free space
$drive = Get-PSDrive -PSProvider FileSystem | Sort-Object Free -Descending | Select-Object -First 1
$localPath = "$($drive.Name):\gitea-data"
$dockerPath = "/$($drive.Name.ToLower())/gitea-data"

# Create directory if it doesn't exist
if (-Not (Test-Path $localPath)) {
  New-Item -ItemType Directory -Path $localPath | Out-Null
}

# Replace placeholder in docker-compose.yml
$composeTemplate = Get-Content "docker-compose.yml"
$composeGenerated = $composeTemplate -replace "__GITEA_DATA_PATH__", $dockerPath
$composeGenerated | Set-Content "docker-compose.generated.yml"

Write-Host "✅ Gitea data will be stored in: $localPath"
Write-Host "🚀 Starting Gitea container..."
docker-compose -f docker-compose.generated.yml up -d
