#!/bin/bash

whitelist_domain() {
  nslookup $1 |grep -A100 'Non-authoritative answer:'|grep Address:|egrep '([0-9]{1,3}\.){3}[0-9]+' | awk '{printf("/usr/sbin/iptables -t nat -I POSTROUTING  -d %s -o eth0 -j MASQUERADE\n", $2)}'|sh
}

allow_ip() {
  echo $1 | awk '{printf("/usr/sbin/iptables -t nat -I POSTROUTING  -d %s -o eth0 -j MASQUERADE\n", $1)}'|sh
}


/usr/sbin/iptables -t nat -F
/usr/sbin/iptables -t nat -X
allow_ip 104.199.65.124
allow_ip 108.157.214.0/24
allow_ip 185.151.204.0/24
allow_ip 57.74.98.34
allow_ip 35.186.224.0/24
allow_ip 13.32.121.0/24
allow_ip 35.201.74.116
whitelist_domain spotify.com
whitelist_domain sonos.com
whitelist_domain yahoo.com
echo "block all"
