#!/bin/sh
git clone https://github.com/openwrt/openwrt.git
cd openwrt/
git checkout cb9d25245f78609d8b3413263509774af12ea537
cp ../kernel_patches/* ./target/linux/brcm2708/patches-4.4/
cp ../init_files/feeds.conf ./feeds.conf
cp -r ../init_files/etc ./files
cp -r ../init_files/root ./files
cp -r ../init_files/usr ./files
chmod 755 ./files/etc/init.d/thread_border_router
chmod 755 ./files/usr/local/sbin/thread_border_router
chmod 755 ./files/usr/local/sbin/create_subnet64.py
./scripts/feeds update -a
./scripts/feeds install -a
cp ../init_files/root/.config .config
