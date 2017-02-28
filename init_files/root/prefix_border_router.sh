#!/bin/sh
while true
do
  sleep 30
  wpanctl config-gateway fdff:cafe:cafe:cafe:: -d
  sleep 30
  wpanctl add-route fd00:0064:0123:4567::
done
