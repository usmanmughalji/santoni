#!/bin/bash

git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 --depth=1
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 --depth=1

rm -rf out
make mrproper
PATH="aarch64-linux-android-4.9/bin:arm-linux-androideabi-4.9/bin:$PATH"
make O=out ARCH=arm64 land_defconfig
make -j$(nproc --all) O=out \
  ARCH=arm64 \
  CROSS_COMPILE=aarch64-linux-android- \
  CROSS_COMPILE_ARM32=arm-linux-androideabi-
