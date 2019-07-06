#!/bin/sh

#Environment

export PATH=/Development/brew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export BUNDLE_PREFIX=com.jamesmcgrogan
export SWIFT_SOURCE_ROOT=/Development/swift-source/swift
export LLVM_SOURCE_ROOT=/Development/swift-source/swift/llvm

#SWIFT_BUILD_SUBDIR=Xcode-RelWithDebInfoAssert
SWIFT_BUILD_SUBDIR=buildbot_osx

export SWIFT_BUILD_DIR=/Development/swift-source/swift/build/${SWIFT_BUILD_SUBDIR}/swift-macosx-x86_64
export PATH=${SWIFT_BUILD_DIR}/RelWithDebInfo/bin:$PATH
