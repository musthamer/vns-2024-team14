#!/bin/bash

duration="30s"
threads=2
connections=50
url="http://haproxy:80"

echo "Starte wrk Lasttest für $url mit $connections Verbindungen für $duration..."
wrk -t$threads -c$connections -d$duration $url
