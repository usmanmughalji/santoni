#!/bin/bash

rm -rf out
make mrproper
PATH="aarch64-linux-android-4.9/bin:arm-linux-androideabi-4.9/bin:$PATH"
make O=out ARCH=arm64 santoni_defconfig
make -j$(nproc --all) O=out \
  ARCH=arm64 \
  CROSS_COMPILE=aarch64-linux-android- \
  CROSS_COMPILE_ARM32=arm-linux-androideabi-
