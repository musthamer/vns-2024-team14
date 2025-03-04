#!/bin/bash

url="http://haproxy:80"
anfragen=100

echo "Starte curl Lasttest mit $anfragen Anfragen..."
for i in $(seq 1 $anfragen); do
  curl -s -o /dev/null -w "%{http_code}\n" $url &
done
wait
echo "Test abgeschlossen!"
