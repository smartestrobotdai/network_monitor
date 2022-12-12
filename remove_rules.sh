
WORKING_DIR=/root/script

cd $WORKING_DIR
source ./util.sh

IPTABLES=/usr/sbin/iptables

$IPTABLES -t nat -F
$IPTABLES -t nat -X

$IPTABLES -t nat -A POSTROUTING  -o eth0 -j MASQUERADE
ssh_passthrough

cd -
