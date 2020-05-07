#!/bin/bash

wget https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/+archive/a9b70fc1b59747d1334677e539b2ef4c752a59a1.tar.gz
wget https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/+archive/8b7055200549a33a449f53b16731e377789e7834.tar.gz

tar -xzf a9b70fc1b59747d1334677e539b2ef4c752a59a1.tar.gz
tar -xzf 8b7055200549a33a449f53b16731e377789e7834.tar.gz

rm -rf out
make mrproper
PATH="$(pwd)/aarch64-linux-android-4.9/bin:$(pwd)/arm-linux-androideabi-4.9/bin:${PATH}" \
make O=out ARCH=arm64 santoni_defconfig
make -j$(nproc --all) O=out \
  ARCH=arm64 \
  CROSS_COMPILE=aarch64-linux-android- \
  CROSS_COMPILE_ARM32=arm-linux-androideabi-
