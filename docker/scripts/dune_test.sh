#!/bin/bash
#export ARANGO_HOST=$(ping -c 1 coordinator | grep -Po '(?<=\().*(?=\))' | grep -Po '.*(?=\))')
#export ARANGO_PORT=8529
echo "Inspect Docker Networks"
docker network ls
#export ARANGO_HOST=$(docker ps | grep "coordinator$" | awk '{split($12,a,"->"); print a[1] }' | awk '{split($1,a,":"); print a[1]}' )
#export ARANGO_PORT=$(docker ps | grep "coordinator$" | awk '{split($12,a,"->"); print a[1] }' | awk '{split($1,a,":"); print a[2]}' )
export ARANGO_HOST=172.18.0.0
export ARANGO_PORT=8000
echo "HOST NAME PASSED TO TEST 1"
echo $ARANGO_HOST
echo "HOST PORT PASSED TO TEST 1"
echo $ARANGO_PORT
telnet $ARANGO_HOST $ARANGO_PORT
nmap $ARANGO_HOST
nslookup $ARANGO_HOST
echo "------------------------------------------"
export ARANGO_HOST=127.0.0.11
export ARANGO_PORT=44347
echo "HOST NAME PASSED TO TEST 2"
echo $ARANGO_HOST
echo "HOST PORT PASSED TO TEST 2"
echo $ARANGO_PORT
telnet $ARANGO_HOST $ARANGO_PORT
nmap $ARANGO_HOST
nslookup $ARANGO_HOST
echo "------------------------------------------"
export ARANGO_HOST=coordinator
export ARANGO_PORT=8000
echo "HOST NAME PASSED TO TEST 3"
echo $ARANGO_HOST
echo "HOST PORT PASSED TO TEST 3"
echo $ARANGO_PORT
telnet $ARANGO_HOST $ARANGO_PORT
nmap $ARANGO_HOST
nslookup $ARANGO_HOST
echo "------------------------------------------"
export ARANGO_HOST=coordinator
export ARANGO_PORT=8000
echo "HOST NAME PASSED TO TEST 4"
echo $ARANGO_HOST
echo "HOST PORT PASSED TO TEST 4"
echo $ARANGO_PORT
telnet $ARANGO_HOST $ARANGO_PORT
nmap $ARANGO_HOST
nslookup $ARANGO_HOST
netstat -ap
netstat -g
netstat -r
netstat -a
netstat -an
netstat -tulnp
dune test 2>&1 | tee dune_runtest.log
exec "$@"
