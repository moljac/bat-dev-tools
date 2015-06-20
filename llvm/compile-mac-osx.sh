#!/bin/bash

UNAME=`uname -a`
# Linux raspberrypi 3.18.7-v7+ #755 SMP PREEMPT Thu Feb 12 17:20:48 GMT 2015 armv7l GNU/Linux

if [[ $UNAME == *"raspberrypi"* ]]
then
    sudo apt-get -y install \
        subversion
fi

# 1 Remember that you were warned twice about reading the documentation.
#    Checkout LLVM:

export DIR_CURRENT=`pwd`

echo DIR_CURRENT=$DIR_CURRENT

mkdir llvm-root

cd $DIR_CURRENT
cd llvm-root
svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm

# Checkout Clang:

cd $DIR_CURRENT; pwd
cd llvm-root
cd llvm/tools
svn co http://llvm.org/svn/llvm-project/cfe/trunk clang

# Checkout Compiler-RT:

cd $DIR_CURRENT; pwd
cd llvm-root
cd llvm/projects
svn co http://llvm.org/svn/llvm-project/compiler-rt/trunk compiler-rt


# Get the Test Suite Source Code [Optional]
cd $DIR_CURRENT; pwd
cd llvm-root
cd llvm/projects
svn co http://llvm.org/svn/llvm-project/test-suite/trunk test-suite


# Configure and build LLVM and Clang:

# The usual build uses CMake. If you would rather use autotools, see Building LLVM with autotools.

cd $DIR_CURRENT; pwd
cd llvm-root
cd llvm/projects
svn co http://llvm.org/svn/llvm-project/test-suite/trunk test-suite

# cd where you want to build llvm
cd $DIR_CURRENT; pwd
cd llvm-root
mkdir build
cd build

# 
# default(CMAKE_INSTALL_PREFIX)=/usr/local/
# 
#  14160 Sep 29  2014 /usr/bin/clang
#  14160 Sep 29  2014 /usr/bin/clang++
#  7 Jun 11 07:44 /usr/bin/llvm-g++ -> clang++
#  5 Jun 11 07:44 /usr/bin/llvm-gcc -> clang

pwd
cmake \
    -G "Unix Makefiles" \
    -DLLVM_ENABLE_LIBCXX=true \
    -DLLVM_BUILD_32_BITS=true \
    -CMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
     ..

# Some common generators are:

# Unix Makefiles — for generating make-compatible parallel makefiles.

#Ninja — for generating Ninja <http://martine.github.io/ninja/>
# build files.

#Visual Studio — for generating Visual Studio projects and
# solutions.

# Xcode — for generating Xcode projects.

make -j2
