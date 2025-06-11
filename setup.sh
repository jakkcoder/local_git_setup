#!/usr/bin/env bash
set -e

# Find the partition with the most free space
best_mount=$(df --output=avail,target -x tmpfs -x devtmpfs | tail -n +2 | sort -nr | head -1 | awk '{print $2}')
gitea_data_path="$best_mount/gitea-data"

# Create the directory if needed
mkdir -p "$gitea_data_path"
chown 1000:1000 "$gitea_data_path"
chmod 750 "$gitea_data_path"

# Replace placeholder in docker-compose.yml
sed "s|__GITEA_DATA_PATH__|$gitea_data_path|g" docker-compose.yml > docker-compose.generated.yml

echo "✅ Gitea data will be stored in: $gitea_data_path"
echo "🚀 Starting Gitea container..."
docker-compose -f docker-compose.generated.yml up -d
