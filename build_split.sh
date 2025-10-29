#!/bin/bash

# Exit on error
set -e

# Build tools in release mode
echo "Configuring and building tools in release mode..."
mkdir -p out/release/tools
cd out/release/tools
cmake -G Ninja \
      -DCMAKE_BUILD_TYPE=Release \
      -DFILAMENT_BUILD_LIBS=ON \
      -DFILAMENT_BUILD_FILAMENT=ON \
      -DFILAMENT_BUILD_TOOLS=ON \
      -DIMPORT_EXECUTABLES=$(pwd)/../../../out/release/tools/imported-executables.cmake \
      ../../../
ninja -j8 matc cmgen resgen uberz
cd ../../..

# Build filament and libs in debug mode
echo "Configuring and building filament and libs in debug mode..."
mkdir -p out/debug/filament
cd out/debug/filament
cmake -G Ninja \
      -DCMAKE_BUILD_TYPE=Debug \
      -DFILAMENT_BUILD_LIBS=ON \
      -DFILAMENT_BUILD_FILAMENT=ON \
      -DFILAMENT_BUILD_TOOLS=OFF \
      ../../../
ninja -j8
cd ../../..

echo "Build complete. Tools are in out/release/tools, filament and libs are in out/debug/filament."
