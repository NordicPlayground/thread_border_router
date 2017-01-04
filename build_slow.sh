#!/bin/sh
cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a
# uncomment below to launch menuconfig to adjust the configuration before the build
#make menuconfig
make V=s -j1
find ./bin -name "openwrt-*sdcard.img" -exec cp {} ../RaspPi_Thread_Border_Router_Demo.img \;

#in case the make fails tarballs need to be downloaded manually to the 'dl/' directory, e.g.:
#wget http://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.43.1/e2fsprogs-1.43.1.tar.gz -P dl/

