#!/bin/bash

docker run -d --name apache1-haproxy --network mynet httpd:2.4
docker run -d --name apache2-haproxy --network mynet httpd:2.4

name=haproxy
port=8000
echo running "$name" "$port"
docker container create \
	--name "$name" \
	--network mynet \
	--init \
	-p $port:80 \
	image-haproxy
docker container cp context/myinit.sh $name:/usr/bin
docker container cp context/haproxy.cfg $name:/etc/haproxy/
docker container start $name
