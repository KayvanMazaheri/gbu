#!/bin/bash
# set -x
CURRENT_DIR=$(pwd)
TIMESTAMP=$(date +"%Y-%m-%dT%I:%M:%S")
BACKUP_DIR="$CURRENT_DIR/gbu.$TIMESTAMP"
mkdir $BACKUP_DIR
ALL_REPOS=$(find $CURRENT_DIR -name ".git")

for REPO in $ALL_REPOS; do
    REPO_DIR=$(dirname $REPO)
    REPO_NAME=$(basename $REPO_DIR)
	BACKUP_PATH="$BACKUP_DIR/$REPO_NAME.gbu"
    cd $REPO_DIR
    git bundle create $BACKUP_PATH --all
    cd -
done
