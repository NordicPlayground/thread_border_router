#!/bin/sh
git clone https://github.com/openwrt/openwrt.git
cd openwrt/
git checkout cb9d25245f78609d8b3413263509774af12ea537
cp ../init_files/feeds.conf ./feeds.conf
mkdir -p ./files/etc/init.d/
mkdir -p ./files/etc/config/
mkdir -p ./files/root/
cp ../kernel_patches/* ./target/linux/brcm2708/patches-4.4/
cp ../init_files/tayga.conf ./files/etc/
cp ../init_files/wpantund.conf ./files/etc/
cp ../init_files/start_demo.sh ./files/root/
cp ../init_files/prefix_demo.sh ./files/root/
cp ../init_files/demo ./files/etc/init.d/
cp ../init_files/network ./files/etc/config/
cp ../init_files/firewall ./files/etc/config/
chmod 755 ./files/etc/init.d/demo
chmod 755 ./files/root/start_demo.sh
chmod 755 ./files/root/prefix_demo.sh
./scripts/feeds update -a
./scripts/feeds install -a
cp ../init_files/.config .config
cp .config ./files/root/
