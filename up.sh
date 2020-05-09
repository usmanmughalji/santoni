#!/bin/bash


if [ -e kernel/out/arch/arm64/boot/Image.gz-dtb ]; then
	target=kernel/out/arch/arm64/boot/Image.gz-dtb;
	echo
	echo "File Found";
	echo
	echo "Uploading File Now"
	echo
	
curl --upload-file kernel/out/arch/arm64/boot/Image.gz-dtb https://filepush.co/upload/Image.gz-dtb
echo
curl -F "file=@kernel/out/arch/arm64/boot/Image.gz-dtb" https://file.io
echo
echo "File Uploaded Successfully"
else
	echo "File Not Found";

fi
