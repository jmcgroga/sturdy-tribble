#!/bin/sh

RUNDIR=`dirname $0`

. ${RUNDIR}/build_env.sh

${RUNDIR}/build_prep.sh
${RUNDIR}/build_lite_clean.sh

if [ ! -d "${SWIFT_SOURCE_ROOT}" ]; then
    echo "${SWIFT_SOURCE_ROOT} does not exist!"
    exit 1
fi

#Clean

cd ${SWIFT_SOURCE_ROOT}
PKG_CONFIG_PATH="/Development/brew/opt/libxml2/lib/pkgconfig" utils/build-script --clean
