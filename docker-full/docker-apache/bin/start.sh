#!/bin/bash


docker container create \
    --name apache1 \
    --net mynet \
    --publish 8081:80 \
    --init \
    image-apache

docker container cp ../context/myinit.sh apache1:/usr/bin
docker container start apache1

docker container create \
    --name apache2 \
    --net mynet \
    --publish 8082:80 \
    --init \
    image-apache

docker container cp ../context/myinit.sh apache2:/usr/bin
docker container start apache2



