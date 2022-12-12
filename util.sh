MY_EXTERNAL_IP=`dig +short myip.opendns.com @resolver1.opendns.com`
MY_EXTERNAL_PORT=10022

ssh_passthrough() {
  # port forward to the work hourse
  /usr/sbin/iptables -t nat -I PREROUTING -i eth0 -p tcp -d ${MY_EXTERNAL_IP} --dport ${MY_EXTERNAL_PORT} -j DNAT --to 192.168.1.35:22
  /usr/sbin/iptables -t nat -I POSTROUTING -p tcp -s 192.168.1.35 --sport 22 -j SNAT --to-source ${MY_EXTERNAL_IP}:${MY_EXTERNAL_PORT}
}

