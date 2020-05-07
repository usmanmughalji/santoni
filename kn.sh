#!/bin/bash
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
git clone https://android.googlesource.com/platform/prebuilts/gcc/darwin-x86/arm/arm-linux-androideabi-4.9
git clone https://github.com/ProtoChuz/AnyKernel3

export USE_CCACHE=1
ZIPNAME=
BOTAPI=
USERID=
CCACHE=$(command -v ccache)

make ARCH=arm64 O=out santoni_defconfig
PATH="$(pwd)/aarch64-linux-android-4.9/bin:$(pwd)/arm-linux-androideabi-4.9/bin:${PATH}" \
make -j"$(nproc --all)" O=out \
                      ARCH=arm64 \
                      CROSS_COMPILE=aarch64-elf- \
                      CROSS_COMPILE_ARM32=arm-eabi-

if [ -f out/arch/arm64/boot/Image.gz-dtb ]; then
    cd AnyKernel3 || exit
    git clean -f  > /dev/null 2>&1
    mv ../out/arch/arm64/boot/Image.gz-dtb .
    SHA=$(cat "../out/.version")
    zip -r9 "${ZIPNAME}-${SHA}".zip ./* -x README.md LICENSE > /dev/null 2>&1
    curl -F chat_id="${USERID}" -F document=@"${ZIPNAME}-${SHA}.zip" "https://api.telegram.org/bot${BOTAPI}/sendDocument" > /dev/null 2>&1
    cd ..
else
    curl -F chat_id="${USERID}" -F parse_mode="HTML" -F text="[BuildCI] Failed!" "https://api.telegram.org/bot${BOTAPI}/sendMessage" > /dev/null 2>&1
fi
