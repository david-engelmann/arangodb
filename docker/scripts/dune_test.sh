#!/bin/bash
#export ARANGO_HOST=$(ping -c 1 coordinator | grep -Po '(?<=\().*(?=\))' | grep -Po '.*(?=\))')
#export ARANGO_PORT=8529
whoami
echo "Inspect Docker Networks"
docker network ls
echo "Inspect arangodb-net"
docker inspect arangodb-net
dokcer network inspect arangodb-net
docker network inspect webservers -f '{{ range.Containers}}{{.IPv4Address}}{{end}}'
docker inspect webservers --format='{{range.Containers}} {{.IPv4Address}}{{":"}}{{.Name}} {{end}}'
echo "------------------------------------------"
export ARANGO_HOST=$(docker ps | grep "coordinator$" | awk '{ print $1 }')
export ARANGO_PORT=$(docker ps | grep "coordinator$" | awk '{split($12,a,"->"); print a[1] }' | awk '{split($1,a,":"); print a[2]}' )
echo "HOST NAME PASSED TO TEST b4Final"
echo $ARANGO_HOST
echo "HOST PORT PASSED TO TEST b4Final"
echo $ARANGO_PORT
ping -c 4 $ARANGO_HOST
telnet $ARANGO_HOST $ARANGO_PORT
nmap $ARANGO_HOST
nslookup $ARANGO_HOST
docker container inspect $ARANGO_HOST
echo "------------------------------------------"
export ARANGO_HOST=127.0.0.11
export ARANGO_PORT=8529
echo "HOST NAME PASSED TO TEST Final"
echo $ARANGO_HOST
echo "HOST PORT PASSED TO TEST Final"
echo $ARANGO_PORT
ping -c 4 $ARANGO_HOST
telnet $ARANGO_HOST $ARANGO_PORT
nmap $ARANGO_HOST
nslookup $ARANGO_HOST
netstat -ap
netstat -g
netstat -r
netstat -a
netstat -an
netstat -tulnp
curl -X POST "http://${ARANGO_HOST}:${ARANGO_PORT}/_open/auth" -H "Content-Type: application/json" -d "{ \"password\": \"\", \"username\": \"root\"}"
dune test 2>&1 | tee dune_runtest.log
exec "$@"
