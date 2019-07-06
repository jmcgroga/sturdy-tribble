#!/bin/sh

RUNDIR=`dirname $0`

. ${RUNDIR}/build_env.sh

# Testing

pushd ${SWIFT_SOURCE_ROOT}
find . -name \*.tar.gz -exec rm {} \;
popd
