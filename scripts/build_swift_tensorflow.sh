#!/bin/sh
set -e

RUNDIR=`dirname $0`
EXTRA_BUILD_SCRIPT_PARAMS="$@"

. ${RUNDIR}/build_env.sh

${RUNDIR}/build_prep.sh
${RUNDIR}/build_lite_clean.sh

if [ ! -d "${SWIFT_SOURCE_ROOT}" ]; then
    echo "${SWIFT_SOURCE_ROOT} does not exist!"
    exit 1
fi

#Pull

cd ${SWIFT_SOURCE_ROOT}

#Checkout
git checkout tensorflow
git pull
set +e
git branch -d tensorflow_jrm
set -e
git checkout -b tensorflow_jrm b495095b1e0a6fd46e0f81d53f23dd7a771a980c

#Update

cd ${SWIFT_SOURCE_ROOT}/..
./swift/utils/update-checkout --clone --scheme tensorflow

#Build

set +e
cd ${SWIFT_SOURCE_ROOT}
PKG_CONFIG_PATH="/Development/brew/opt/libxml2/lib/pkgconfig" utils/build-script --release-debuginfo --enable-tensorflow ${EXTRA_BUILD_SCRIPT_PARAMS} $@

#Incremental builds after full build with ninja

cd ${SWIFT_BUILD_DIR}
ninja swift
ninja swift-stdlib

#Building toolchains

cd ${SWIFT_SOURCE_ROOT}
./utils/build-toolchain-tensorflow $BUNDLE_PREFIX

set -e

cd /Development/scripts
${RUNDIR}/build_test.sh

cd /Development/scripts
${RUNDIR}/build_tar.sh swift-source

