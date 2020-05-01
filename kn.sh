#!/bin/bash
git clone https://github.com/arter97/arm64-gcc --depth=1
git clone https://github.com/arter97/arm32-gcc --depth=1
git clone https://github.com/ProtoChuz/AnyKernel3

export USE_CCACHE=1
ZIPNAME=
BOTAPI=
USERID=
CCACHE=$(command -v ccache)

make ARCH=arm64 O=out santonidefconfig
PATH="$(pwd)/arm64-gcc/bin:$(pwd)/arm32-gcc/bin:${PATH}" \
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
