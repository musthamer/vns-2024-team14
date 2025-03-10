#!/bin/bash

rm -f cookies.txt  # Alte Cookie-Datei löschen
curl -s -i -c cookies.txt -d "username=admin&password=admin" \
"http://haproxy:80/cgi-bin/vns/todo/login.sh"

SERVERID=$(grep 'SERVERID' cookies.txt | cut -f7)
echo "SERVERID → $SERVERID"

for i in {1..10}; do
  curl -s -b cookies.txt "http://haproxy:80/cgi-bin/vns/todo/table3.sh" > /dev/null
  echo "Anfrage $i → SERVERID=$SERVERID"
done

