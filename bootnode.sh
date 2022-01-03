#!/bin/sh
#
# Runs a bootnode with ethereum official "alltools" image.
#
docker stop ethereum-bootnode 2> /dev/null
docker rm ethereum-bootnode 2> /dev/null
IMGNAME="ethereum/client-go:alltools-latest"
DATA_ROOT=${DATA_ROOT:-$(pwd)}

# generate bootnode key if needed
mkdir -p $DATA_ROOT/.bootnode
if [ ! -f $DATA_ROOT/.bootnode/boot.key ]; then
    echo "$DATA_ROOT/.bootnode/boot.key not found, generating..."
    docker run --rm \
        -v $DATA_ROOT/.bootnode:/opt/bootnode \
        $IMGNAME bootnode -genkey /opt/bootnode/boot.key
    echo "...done!"
fi

# creates ethereum network
[ ! "$(docker network ls | grep ethereum)" ] && docker network create ethereum

docker run -d --name ethereum-bootnode \
    -v $DATA_ROOT/.bootnode:/opt/bootnode \
    --network ethereum \
    $IMGNAME bootnode \
        -verbosity 3 \
        -nodekey /opt/bootnode/boot.key \
        "$@"
