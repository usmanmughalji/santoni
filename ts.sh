#!/bin/bash

cd

git clone https://github.com/usmanmughalji/santoni-msm-4.9.git --single-branch --branch 4.9r1 kernel

git clone https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9.git -b lineage-17.1 kernel/gcc-64 --depth=1
git clone https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9.git -b lineage-17.1 kernel/gcc-32 --depth=1

cd kernel

rm -rf out

make O=out clean && make O=out mrproper
make O=out ARCH=arm64 santoni_defconfig

make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CROSS_COMPILE="$(pwd)/gcc-64/bin/aarch64-linux-android-" \
                      CROSS_COMPILE_ARM32="$(pwd)/gcc-32/bin/arm-linux-androideabi-"
