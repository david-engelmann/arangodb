#!/bin/bash
apt-get update -qq
apt-get install apt-transport-https ca-certificates gnupg lsb-release git curl iputils-ping telnet nmap net-tools dnsutils -y
apt-get upgrade -y
apt-get install --reinstall -y iptables
dpkg -S /lib/modules/$(uname -r)/kernel/net/ipv4/netfilter/ip_tables.ko
curl -fsSL https://get.docker.com -o get-docker.sh
sh ./get-docker.sh
exec "$@"
