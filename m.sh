#!/bin/bash

git clone https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9.git
git clone https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9.git

mv android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9 aarch64-linux-android
mv android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9 arm-linux-androideabi

rm -rf out
make mrproper
PATH="$(pwd)/aarch64-linux-android/bin:$(pwd)/arm-linux-androideabi/bin:${PATH}" \
make O=out ARCH=arm64 santoni_defconfig
make -j$(nproc --all) O=out \
  ARCH=arm64 \
  CROSS_COMPILE=aarch64-linux-android- \
  CROSS_COMPILE_ARM32=arm-linux-androideabi-
