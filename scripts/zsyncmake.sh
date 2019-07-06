#!/bin/sh

DIRECTORY=$1

if [ ! -d "/Development/zsync" ]; then
    mkdir -p /Development/zsync
fi

cd /Development/zsync
tar cf - -C /Development ${DIRECTORY} | zsyncmake -z -u http://10.0.1.19:8000/${DIRECTORY}.tar.gz -f ${DIRECTORY}.tar
