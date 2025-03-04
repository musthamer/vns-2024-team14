#!/bin/bash


# Session-Stickiness Test mit Cookies
echo "Überprüfung der Session-Stickiness mit HAProxy..."
docker exec -ti work curl -v -b cookies.txt -c cookies.txt http://haproxy:80 | grep "Apache" > haproxy_session_test.txt

echo "Session-Test abgeschlossen. Ergebnisse in haproxy_session_test.txt"

echo "Mehrere Anfragen zur Überprüfung der Stickiness..."
docker exec -ti work bash -c 'for i in {1..10}; do curl -b cookies.txt http://haproxy:80 | grep "Apache"; done' > haproxy_sticky_test_1.txt
docker exec -ti work bash -c 'for i in {1..10}; do curl -b cookies.txt http://haproxy:80 | grep "Apache"; done' > haproxy_sticky_test_2.txt

echo "Test mit manuell gesetztem Cookie (SERVERID=apache1) zur Validierung der Stickiness..."
docker exec -ti work bash -c 'for i in {1..10}; do curl -b "SERVERID=apache1" http://haproxy:80 | grep "Apache"; done' >> haproxy_sticky_test_apache1.txt

echo "Session-Stickiness Tests abgeschlossen. Ergebnisse in haproxy_sticky_test_1.txt, haproxy_sticky_test_2.txt und haproxy_sticky_test_apache1.txt"

