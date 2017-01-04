# thread_border_router build system
## Prerequisites:
1. Linux based host, Debian Linux has been tested.
2. At least 25GiB of free hard drive space.
3. Internet connection to access remote repositories.

The following packages need to be installed on a host linux operating system to build the OpenWrt based image:
build-essential 
subversion 
libncurses5-dev 
libssl-dev 
zlib1g-dev 
gawk 
gcc-multilib 
flex 
git-core 
gettext 
gcc 
binutils 
bzip2 
python 
perl 
make 
unzip 
libz-dev 
tftp 
git 
shtool 
autogen 
automake 
libtool 
autotools-dev

For a debian based host it is sufficient to run the following command:
su -c 'apt-get -y install build-essential subversion libncurses5-dev libssl-dev zlib1g-dev gawk gcc-multilib flex git-core gettext gcc binutils bzip2 python perl make unzip libz-dev tftp git shtool autogen automake libtool autotools-dev'


## Building image:
1. Execute ./init_build script.
2. Execute build script. You can choose between ./build.sh uses 4 jobs and ./build_slow that builds one thing at the time.

Please note that build can take up to few hours depending on your computer and network connection performance.
After that the image file openwrt-brcm2708-bcm2710-rpi-3-ext4-sdcard.img will be copied to the current directory.

Image file RaspPi_Thread_Border_Router_Demo.img will be created in the current directory.

## Flashing image to the card:
Later it can be flashed to the sdcard with the disk dump utility:

dd if=RaspPi_Thread_Border_Router_Demo.img of=/dev/sdX bs=2M conv=fsync

Where sdx is the sdcard device name, which can be seen in dmesg after inserting a card into the card reader.
On Windows Win32DiskImager can be used.

## Troubleshooting:
Below are listed the most common issues causing the build to fail.

###1. Source download failure.
In case the make fails tarballs need to be downloaded manually to the 'dl/' directory, e.g.:

SHELL= flock /home/pisz/repo/release_multifile/thread_openwrt_build/openwrt/tmp/.vpnc-0.5.3.r550.tar.gz.flock -c '	 echo "Checking out files from the svn repository..."; mkdir -p /home/pisz/repo/release_multifile/thread_openwrt_build/openwrt/tmp/dl && cd /home/pisz/repo/release_multifile/thread_openwrt_build/openwrt/tmp/dl && rm -rf vpnc-0.5.3.r550 && [ \! -d vpnc-0.5.3.r550 ] && ( svn help export | grep -q trust-server-cert && svn export --non-interactive --trust-server-cert -r550 http://svn.unix-ag.uni-kl.de/vpnc/trunk/ vpnc-0.5.3.r550 || svn export --non-interactive -r550 http://svn.unix-ag.uni-kl.de/vpnc/trunk/ vpnc-0.5.3.r550 ) && echo "Packing checkout..." && 	tar czf /home/pisz/repo/release_multifile/thread_openwrt_build/openwrt/tmp/dl/vpnc-0.5.3.r550.tar.gz vpnc-0.5.3.r550 && mv /home/pisz/repo/release_multifile/thread_openwrt_build/openwrt/tmp/dl/vpnc-0.5.3.r550.tar.gz /home/pisz/repo/release_multifile/thread_openwrt_build/openwrt/dl/ && rm -rf vpnc-0.5.3.r550; '
Checking out files from the svn repository...
svn: E120108: Unable to connect to a repository at URL 'http://svn.unix-ag.uni-kl.de/vpnc/trunk'
svn: E120108: Error running context: The server unexpectedly closed the connection.
svn: E120108: Unable to connect to a repository at URL 'http://svn.unix-ag.uni-kl.de/vpnc/trunk'
svn: E120108: Error running context: The server unexpectedly closed the connection.
Makefile:94: recipe for target '/home/pisz/repo/release_multifile/thread_openwrt_build/openwrt/dl/vpnc-0.5.3.r550.tar.gz' failed
make[3]: *** [/home/pisz/repo/release_multifile/thread_openwrt_build/openwrt/dl/vpnc-0.5.3.r550.tar.gz] Error 1
make[3]: Leaving directory '/home/pisz/repo/release_multifile/thread_openwrt_build/openwrt/feeds/packages/net/vpnc'
package/Makefile:196: recipe for target 'package/feeds/packages/vpnc/compile' failed
make[2]: *** [package/feeds/packages/vpnc/compile] Error 2

Solution:

wget https://librecmc.org/librecmc/downloads/sources/v1.3.4/vpnc-0.5.3.r550.tar.gz -P openwrt/dl/


###2. Build failed - please re-run with -j1 to see the real error message.
Please rerun the build with -j1 parameter.

execute ./build_slow

or run serial build manually:

cd ./openwrt
make -j1 V=s

Also rebuilding a single package is possible:
make package/PACKAGE_NAME/{clean,compile} -j1 V=s

e.g. make package/gettext-full/{clean,compile} -j1 V=s

