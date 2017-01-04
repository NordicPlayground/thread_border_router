#!/bin/sh

# Thread Configuration
NETWORK_KEY="00112233445566778899AABBCCDDEEFF"
CHANNEL="11"
PANID="0xABCD"

rm -r /var/db/tayga
mkdir -p /var/db/tayga/
touch /var/db/tayga/dynamic.map
ip link del dev tayga-nat64

prefix48="fd00:0064:0123"
last16="4567"
prefix64=$prefix48:$last16
prefix_96=$prefix64"::/96" #zero fill for now

sed -i "/^prefix/s,.*,prefix $prefix_96," /etc/tayga.conf
sed -i "/dns64/s,.*,        dns64 $prefix_96 {," /etc/bind/named.conf

tayga --mktun
ip link set tayga-nat64 up

sleep 3

#assigns an ipv4 addr to the TAYGA interface, used for returning icmp errors
ip addr add 192.168.64.1 dev tayga-nat64

#assigns an ipv6 addr to the TAYGA interface, used for returning icmp errors
ip addr add $prefix48"::1" dev tayga-nat64
ip addr add $prefix48"::/64" dev tayga-nat64

ip route add 192.168.64.0/24 dev tayga-nat64
ip route add $prefix_96 dev tayga-nat64

echo 1 > /proc/sys/net/ipv4/conf/all/forwarding
echo 1 > /proc/sys/net/ipv6/conf/all/forwarding

iptables -F
iptables -t nat -F
iptables -t nat -I POSTROUTING 1 -o br-lan -j MASQUERADE
tayga -d&
sleep 3
stty -F /dev/ttyACM0 115200
sleep 1
wpantund -b 115200 -d&
sleep  6
wpanctl reset
sleep 3
wpanctl set Network:Key --data $NETWORK_KEY
wpanctl set NCP:Channel $CHANNEL
wpanctl setprop Network:PANID $PANID
wpanctl attach
sleep 30
wpanctl config-gateway fdff:cafe:cafe:cafe:: -d
sleep 30
wpanctl add-route fd00:0064:0123:4567::
/bin/sh /root/prefix_border_router.sh &
