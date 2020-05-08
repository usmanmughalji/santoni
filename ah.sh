#!/bin/bash

cd Desktop

rm -rf kernel toolchain

mkdir kernel && cd kernel

git clone --single-branch --branch 4.9r1 https://github.com/usmanmughalji/santoni-msm-4.9/

cd ..

mkdir toolchain && cd toolchain

git clone https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9.git
git clone https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9.git

mv android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9 aarch64-linux-android
mv android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9 arm-linux-androideabi

cd ..

cd kernel/santoni-msm-4.9

export CROSS_COMPILE="/root/Desktop/toolchain/aarch64-linux-android/bin/aarch64-linux-android-"
export CROSS_COMPILE_ARM32="/root/Desktop/toolchain/arm-linux-androideabi/bin/arm-linux-androideabi-"

rm -rf out

make mrproper && make clean 
make O=out ARCH=arm64 santoni_defconfig

make -j$(nproc --all) O=out \
                      ARCH=arm64
