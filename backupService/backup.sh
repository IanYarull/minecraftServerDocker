#!/bin/bash

# Paths that are mapped inside the container + some variables

SOURCE_DIR="/server_files"

BACKUP_DIR="/backups"

DATE=$(date +"%Y-%m-%d_%H-%M")

ARCHIVE_NAME="minecraft_state_$DATE.tar.gz"

echo "[$(date)] Starting backup: $ARCHIVE_NAME"

# Zipping files!

tar -czvf "$BACKUP_DIR/$ARCHIVE_NAME" -C "$SOURCE_DIR" \
  data/world \
  ops.json \
  server.properties \
  whitelist.json \
  banned-ips.json \
  banned-players.json

echo "[$(date)] Cleaning up backups older than 7 days..."

find "$BACKUP_DIR" -type f -name "minecraft_state_*.tar.gz" -mtime +7 -delete

echo "[$(date)] Backup complete!"
