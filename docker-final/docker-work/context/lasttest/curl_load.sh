#!/bin/bash

rm -f cookies.txt

for i in {1..10}; do
    curl -s -i -c cookies.txt -d "username=admin&password=admin" \
    "http://localhost:8000/cgi-bin/vns/todo/login.sh" | grep 'SERVERID' | tee -a load_balancing_result.txt
    echo "Anfrage $i abgeschlossen"
done

echo ""
cat load_balancing_result.txt | sort | uniq -c

