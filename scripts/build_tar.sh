#!/bin/sh

DIRECTORY=$1

if [ ! -d "/Development/zsync" ]; then
    mkdir -p /Development/zsync
fi

cd /Development/zsync
tar cvjf ${DIRECTORY}.tar.bz2 -C /Development ${DIRECTORY}
