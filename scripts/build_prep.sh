#!/bin/sh
set -e

RUNDIR=`dirname $0`
BREW_REQS="cmake ninja libxml2 zsync"

#Environment

. ${RUNDIR}/build_env.sh

#Local Homebrew

cd /Development

if [ ! -d "brew" ]; then
    git clone https://github.com/Homebrew/brew.git
else
    echo "Homebrew already installed"
fi

brew update

set +e
java -version

if [ $? -ne 0 ]; then
    brew cask install homebrew/cask-versions/adoptopenjdk8
fi

bazel version

if [ $? -ne 0 ]; then
    brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/24d823e09c11165f9e9ff443ceac0b3959ca42d6/Formula/bazel.rb
fi

set +e
brew install ${BREW_REQS} || brew upgrade ${BREW_REQS}
set -e
java -version
bazel version
brew list ${BREW_REQS} > /dev/null 2>&1

#Setup 

if [ ! -d "swift-source" ]; then
    mkdir swift-source
    cd swift-source

    #Clone
    git clone https://github.com/apple/swift.git
else
    echo "swift-source already exists"
fi
