#!/bin/bash


echo "Starte Load-Balancing Test für HAProxy..."

docker exec -ti work wrk -t4 -c50 -d10s http://haproxy:80 > haproxy_loadtest.txt

echo "Load-Balancing Test abgeschlossen. Ergebnisse in haproxy_loadtest.txt"

