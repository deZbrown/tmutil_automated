#!/bin/bash

# Check if the user has provided the number of backups to keep as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <number of backups to keep>"
    echo "Example: $0 6"
    exit 1
fi

# Number of backups to keep
keep="$1"

# Fetch the latest backup to exclude from deletion
latest=$(sudo tmutil latestbackup)
echo "Latest backup is: $latest"

# Extract the mount point from tmutil destination info
mountpoint=$(tmutil destinationinfo | awk -F": " '/Mount Point/ {print $2}')
echo "Mountpoint is: $mountpoint"

# Get all backups except the latest
backups=$(sudo tmutil listbackups | grep -v "$(basename "$latest")")

# Calculate how many backups to delete
total_backups=$(echo "$backups" | wc -l | xargs)
delete_count=$(($total_backups - $keep))

if [ $delete_count -gt 0 ]; then
    # Get the oldest backups to delete, skipping the number of latest ones we want to keep
    backups_to_delete=$(echo "$backups" | head -n $delete_count)

    # Iterate through backups to delete
    echo "$backups_to_delete" | while read -r backup_path; do
        timestamp=$(basename "$backup_path" .backup)
        echo "Attempting to delete backup with timestamp: $timestamp"
        sudo tmutil delete -d "$mountpoint" -t "$timestamp"
        echo "Command run: sudo tmutil delete -d '$mountpoint' -t '$timestamp'"
    done
else
    echo "No backups need to be deleted, as the total count of backups ($total_backups) is less than or equal to the number to keep ($keep)."
fi

