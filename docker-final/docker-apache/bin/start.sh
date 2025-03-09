#!/bin/bash

# Schleife zur Erstellung der Container
for i in {1..3}; do
    port=$((8080 + i))
    docker container create \
        --name apache$i \
        --net mynet \
        --publish $port:80 \
        --init \
        --cpus=1 \
        image-apache

    docker container cp context/myinit.sh apache$i:/usr/bin
    docker container start apache$i

done
