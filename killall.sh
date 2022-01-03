#!/bin/sh
docker stop $(docker ps -q -f name=ethereum) 2> /dev/null
docker rm $(docker ps -aq -f name=ethereum) 2> /dev/null
