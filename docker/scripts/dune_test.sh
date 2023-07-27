#!/bin/bash
export ARANGO_HOST=$(ping -c 1 coordinator | grep -Po '(?<=\().*(?=\))' | grep -Po '.*(?=\))')
export ARANGO_PORT=8529
dune test 2>&1 | tee dune_runtest.log
exec "$@"
