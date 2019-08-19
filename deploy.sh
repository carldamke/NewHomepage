#!/usr/bin/env bash

cd "${BASH_SOURCE%/*}" || exit

echo "Deploying site..."

if lftp -c "open --password $PASSWORD ftp://$USER@$HOST:$PORT; mirror -c -e -R -L . -x .htaccess $TARGET"; then
	echo "Page deployed!"
else
	echo "Error while deploying."
	exit 1
fi

echo "Refreshing cache..."

if curl -X PURGE $PURGE_URL; then
	echo "Refreshed cache."
else
	echo "Cache refresh error."
	exit 1
fi