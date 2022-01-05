#!/bin/bash
DATA_ROOT=${DATA_ROOT:-$(pwd)}
echo "Removing containers..."
docker stop $(docker ps -q -f name=ethereum) 2> /dev/null
docker rm $(docker ps -aq -f name=ethereum) 2> /dev/null
echo "Removing volumes in $DATA_ROOT..."
sudo rm -Rf $DATA_ROOT/.ether-* $DATA_ROOT/.ethash $DATA_ROOT/.bootnode
echo "Removing docker network 'ethereum'"
docker network rm ethereum > /dev/null 2>&1
