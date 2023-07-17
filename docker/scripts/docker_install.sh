#!/bin/bash
apt-get update -qq
apt-get install apt-transport-https ca-certificates gnupg lsb-release git curl iputils-ping -y
curl -fsSL https://get.docker.com -o get-docker.sh
sh ./get-docker.sh
exec "$@"