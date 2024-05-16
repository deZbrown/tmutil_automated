# Delete Old Time Machine Backups Script

This Bash script is commonly used to manage and automate the deletion of old backups in Time Machine on macOS systems. By specifying the number of backups you wish to retain, the script handles the removal of older backups beyond this limit, ensuring optimal storage management without manual intervention.

## Usage

To use the script, simply pass the number of backups you wish to keep as an argument. For example:

```bash
./delete_old_backups.sh 6
```

This command will retain the 6 most recent backups and delete any older ones.

## How It Works

1. **Check Input**: The script starts by verifying that a valid number of backups to keep has been provided.
2. **Identify Latest Backup**: Fetches the latest backup to ensure it is not deleted.
3. **Determine Mount Point**: Extracts the mount point from Time Machine's destination info.
4. **List All Backups**: Gathers a list of all backup snapshots, excluding the latest.
5. **Delete Old Backups**: Calculates which backups are older than the threshold set by the user and deletes them.

## Example Command

Here is an example command that shows how the script would delete an old backup, assuming the mount point is `/Volumes/Seagate Basic` and the timestamp of the backup to delete is `2023-01-03-224339`:

```bash
sudo tmutil delete -d '/Volumes/Seagate Basic' -t '2023-01-03-224339'
```

For more detailed usage and troubleshooting, refer to the inline comments within the script.