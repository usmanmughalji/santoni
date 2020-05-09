#!/bin/bash

#Fire-Fox-Send Setup

if [ -e usr/local/bin/ffsend ]; then
	target=usr/local/bin/ffsend;
	echo
	echo "Fire Fox Send Already Installed";
else

wget https://raw.githubusercontent.com/usmanmughalji/build-scripts/master/ffsend
chmod a+x ./ffsend
sudo mv ./ffsend /usr/local/bin/

fi

if [ -e kernel/out/arch/arm64/boot/Image.gz-dtb ]; then
	target=kernel/out/arch/arm64/boot/Image.gz-dtb;
	echo
	echo "File Found";
	echo
	echo "Uploading File Now";
	echo
	
echo "Uploading To Fire Fox Send";
ffsend upload kernel/out/arch/arm64/boot/Image.gz-dtb
echo "Uploading Complete";
echo
echo "Uploading To File Push"
curl --upload-file kernel/out/arch/arm64/boot/Image.gz-dtb https://filepush.co/upload/Image.gz-dtb
echo "Uploading Complete";
echo
echo "Uploading To File.io"
curl -F "file=@kernel/out/arch/arm64/boot/Image.gz-dtb" https://file.io
echo
echo "Uploading Complete";
echo
echo "File Successfully Uploaded To All Respective File Hosting Servers"
else
	echo "File Not Found";

fi
