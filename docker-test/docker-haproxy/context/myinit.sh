#!/bin/bash
log=/var/www/html/docker.log
echo starte >> $log

trap onexit SIGTERM 

function onexit {
  #shutdown ...
  service haproxy stop
  exit
}
# start services
service haproxy start

echo "HAProxy-Konfiguration:"
cat /etc/haproxy/haproxy.cfg

# Zeige HAProxy-Status
service haproxy status

while true; do
	echo "$(date +%FT%T) ping" >> $log
  read -t 1 </dev/fd/1 
done
