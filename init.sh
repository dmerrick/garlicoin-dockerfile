#!/bin/bash -e
# this is meant to be run inside the docker container

echo "Starting Garlicoin daemon..."
exec garlicoind -datadir=$GARLICOIN_DATA_DIR -rescan -detachdb
