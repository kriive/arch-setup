#!/usr/bin/env bash
# Exit on failure or pipefail
set -e -o pipefail

BACKUP_PATH=${BACKUP_PATH:="$HOME"}
BACKUP_TAG=${BACKUP_TAG:="automatic.backup"}
RESTIC_EXCLUDE=${RESTIC_EXPLUDE:="$HOME/.restic"}

# How many backups to keep.
RETENTION_DAYS=${RETENTION_DAYS:=14}
RETENTION_WEEKS=${RETENTION_WEEKS:=16}
RETENTION_MONTHS=${RETENTION_MONTHS:=18}
RETENTION_YEARS=${RETENTION_YEARS:=3}

# Metadata
BUCKET_URL=${BUCKET_URL:=unset}
BUCKET_NAME=${BUCKET_NAME:=unset}
RESTIC_REPO="s3:$BUCKET_URL/$BUCKET_NAME"

export AWS_ACCESS_KEY_ID="$(secret-tool lookup service wasabi-access-key)"
export AWS_SECRET_ACCESS_KEY="$(secret-tool lookup service wasabi-secret-key)"
export RESTIC_PASSWORD="$(secret-tool lookup application restic)"

restic -r "$RESTIC_REPO" unlock

restic -r "$RESTIC_REPO" \
       backup \
       --verbose \
       --one-file-system \
       --tag "$BACKUP_TAG" \
       --exclude-file="$HOME/.restic" \
       "$BACKUP_PATH"

# Remove old Backups
restic -r "$RESTIC_REPO" \
       forget \
       --verbose \
       --tag "$BACKUP_TAG" \
       --prune \
       --keep-daily "$RETENTION_DAYS" \
       --keep-weekly "$RETENTION_WEEKS" \
       --keep-monthly "$RETENTION_MONTHS" \
       --keep-yearly "$RETENTION_YEARS"

echo "Backup done!"
