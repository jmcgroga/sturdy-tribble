#!/bin/sh
set -e

RUNDIR=`dirname $0`

. ${RUNDIR}/build_env.sh

# Testing

${LLVM_SOURCE_ROOT}/utils/lit/lit.py -sv -vv --param swift_site_config=${SWIFT_BUILD_DIR}/test-macosx-x86_64/lit.site.cfg ${SWIFT_SOURCE_ROOT}/test/Parse/
exit $?
