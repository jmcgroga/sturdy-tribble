#!/bin/sh
set -e

RUNDIR=`dirname $0`

. ${RUNDIR}/build_env.sh

${RUNDIR}/build_prep.sh
${RUNDIR}/build_lite_clean.sh

if [ ! -d "${SWIFT_SOURCE_ROOT}" ]; then
    echo "${SWIFT_SOURCE_ROOT} does not exist!"
    exit 1
fi

#Pull

cd ${SWIFT_SOURCE_ROOT}
git pull

# Checkout
git checkout master

#Update

cd ${SWIFT_SOURCE_ROOT}/..
./swift/utils/update-checkout --clone

#Build

cd ${SWIFT_SOURCE_ROOT}
PKG_CONFIG_PATH="/Development/brew/opt/libxml2/lib/pkgconfig" utils/build-script --release-debuginfo --xcode $@

#Incremental builds after full build with ninja

cd ${SWIFT_BUILD_DIR}
ninja swift
ninja swift-stdlib

#Building toolchains

cd ${SWIFT_SOURCE_ROOT}
./utils/build-toolchain $BUNDLE_PREFIX

cd /Development/scripts
${RUNDIR}/build_test.sh

if [ $? -ne 0 ]; then
    exit $?
fi

cd /Development/scripts
${RUNDIR}/build_tar.sh swift-source

