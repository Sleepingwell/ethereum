#!/bin/bash
NODE_NAME=$1
NODE_NAME=${NODE_NAME:-"miner1"}
ETHERBASE=${ETHERBASE:-"0xb2fca8c69b5c77a2a246868548ada96441f065c2"}
./runnode.sh $NODE_NAME --mine --miner.threads=1 --miner.etherbase="$ETHERBASE"
