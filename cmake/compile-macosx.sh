#!/bin/bash

# Compile cmake
curl -LOk \
    http://www.cmake.org/files/v3.3/cmake-3.3.0-rc2.tar.gz
tar xvzf \
    cmake-3.3.0-rc2.tar.gz

cd    cmake-3.3.0/
./bootstrap
make      
make install
