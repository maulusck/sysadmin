#!/bin/bash
set -e

SFTP_SERVER=""
SFTP_PORT=""
SFTP_USER="$(hostname)"
SFTP_IDENTITY="/root/.ssh/id_sysbak_rsa"
BAK_DIR="/srv/bak"

# exit if SFTP_SERVER is left unconfigured
[ -z "$SFTP_SERVER" ] && exit 1

# use rsync if available, fallback to scp, exit if both are not available

# rsync routine
if [ -x "$(which rsync 2>/dev/null)" ]; then

	echo "Using rsync"
	rsync -e 'ssh -p $SFTP_PORT -i $SFTP_IDENTITY' -avup --progress $BAK_DIR $SFTP_USER@$SFTP_SERVER:/

# scp routine
else if [ -x "$(which scp 2>/dev/null)" ]; then

	echo "Using scp"
	scp -r -P $SFTP_PORT -i $SFTP_IDENTITY $BAK_DIR $SFTP_USER@$SFTP_SERVER:/

# fail and quit
else
	echo "No ssh copying utility found, install scp or rsync and try again"; exit 1
fi;fi
