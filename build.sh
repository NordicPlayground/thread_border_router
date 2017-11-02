#!/bin/sh
cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a
# uncomment below to launch menuconfig to adjust the configuration before the build
#make menuconfig
make V=s -j4
find ./bin -name "openwrt-*sdcard.img" -exec cp {} ../RaspPi_Thread_Border_Router_Demo.img \;
cd ..
zip RaspPi_Thread_Border_Router_Demo.zip RaspPi_Thread_Border_Router_Demo.img NXP_EXPLORE-NFC-WW_LICENSE.pdf OpenWRT_LICENSE.txt RaspberryPi_Border_Router_LICENSE.txt Paho_MQTT-SN_Eclipse_Distribution_LICENSE.txt
#in case the make fails tarballs need to be downloaded manually to the 'dl/' directory, e.g.:
#wget http://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.43.1/e2fsprogs-1.43.1.tar.gz -P dl/

