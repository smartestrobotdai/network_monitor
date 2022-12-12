WORKING_DIR=/root/script
source ./util.sh

block_domain() {
  nslookup $1 |grep -A100 'Non-authoritative answer:'|grep Address:|egrep '([0-9]{1,3}\.){3}[0-9]+' | awk '{printf("/usr/sbin/iptables -t nat -I POSTROUTING  -d %s -o eth0 -j ACCEPT\n", $2)}'|sh
}

block_ip() {
  echo $1 | awk '{printf("/usr/sbin/iptables -t nat -I POSTROUTING  -d %s -o eth0 -j ACCEPT\n", $1)}'|sh
}

allow_ip() {
  echo $1 | awk '{printf("/usr/sbin/iptables -t nat -I POSTROUTING  -d %s -o eth0 -j MASQUERADE\n", $1)}'|sh
}

whitelist_domain() {
  nslookup $1 |grep -A100 'Non-authoritative answer:'|grep Address:|egrep '([0-9]{1,3}\.){3}[0-9]+' | awk '{printf("/usr/sbin/iptables -t nat -I POSTROUTING  -d %s -o eth0 -j MASQUERADE\n", $2)}'|sh
}


/usr/sbin/iptables -t nat -F
/usr/sbin/iptables -t nat -X

/usr/sbin/iptables -t nat -A POSTROUTING  -o eth0 -j MASQUERADE
block_domain t.co
block_domain twitter.com
block_domain www.whatsapp.com
block_domain g.whatsapp.net
block_domain dit.whatsapp.net
block_domain sgminorshort.wechat.com
block_domain sglong.wechat.com
block_domain sgshort.wechat.com
block_domain dns.weixin.qq.com
#block_domain www.youtube.com

#twitter:
block_ip 104.244.42.0/24
block_ip 108.157.212.243

#wechat:
block_ip 162.62.115.0/24

#spotify
#block_ip 124.65.199.104
#block_ip 108.157.214.0/24
#block_ip 185.151.204.0/24
#block_ip 57.74.98.34
#block_ip 35.186.224.0/24

#messenger
block_domain messenger.com
block_domain facebook.com

#whitelist R document
whitelist_domain rdocumentation.org
whitelist_domain coursera.org

# port forward
ssh_passthrough

cd -
