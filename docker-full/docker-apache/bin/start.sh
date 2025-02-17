#!/bin/bash
name=apache1
port=8081
docker container create \
  --name "$name" \
  --net mynet \
  --publish "$port":80 \
  --init \
  image-apache1

docker container cp context/myinit.sh "$name":/usr/bin
docker container start "$name"
