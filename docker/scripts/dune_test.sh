#!/bin/bash
#export ARANGO_HOST=$(ping -c 1 coordinator | grep -Po '(?<=\().*(?=\))' | grep -Po '.*(?=\))')
#export ARANGO_PORT=8529
docker ps
#export ARANGO_HOST=$(docker ps | grep "coordinator$" | awk '{split($12,a,"->"); print a[1] }' | awk '{split($1,a,":"); print a[1]}' )
#export ARANGO_PORT=$(docker ps | grep "coordinator$" | awk '{split($12,a,"->"); print a[1] }' | awk '{split($1,a,":"); print a[2]}' )
echo "HOST NAME PASSED TO TEST"
echo $ARANGO_HOST
echo "HOST PORT PASSED TO TEST"
echo $ARANGO_PORT
telnet $ARANGO_HOST $ARANGO_PORT
nmap $ARANGO_HOST
netstat -ap
netstat -g
netstat -r
netstat -a
netstat -an
netstat -tulnp
dune test 2>&1 | tee dune_runtest.log
exec "$@"
