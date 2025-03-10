#!/bin/bash

LOG_DIR="tcpdump_logs"
mkdir -p $LOG_DIR

echo "Starte Netzwerkanalyse mit tcpdump..."
sudo tcpdump -i eth0 port 80 or port 443 or port 3306 or port 6379 -w $LOG_DIR/network.pcap &
TCPDUMP_PID=$!

echo "TCPDump läuft mit PID $TCPDUMP_PID - Erfassung für 60 Sekunden..."
sleep 5

echo "Teste HAProxy HTTP-Zugriffe..."
curl -X GET http://haproxy:80 > $LOG_DIR/haproxy_http_test.txt 2>&1 &
wrk -t4 -c50 -d10s http://haproxy:80 > $LOG_DIR/haproxy_loadtest.txt 2>&1 &

sleep 5

echo "Führe MariaDB-Lasttest mit sysbench durch..."
sysbench --db-driver=mysql --mysql-host=mariadb --mysql-user=dbuser --mysql-password=12345 --mysql-db=todo_app --table-size=10000 --tables=10 --threads=4 --time=30 oltp_read_write run > $LOG_DIR/mariadb_sysbench.txt 2>&1 &

sleep 5

echo "Teste Redis-Performance mit redis-benchmark..."
redis-benchmark -h redis -p 6379 -a foobared -n 100000 -t set,get > $LOG_DIR/redis_benchmark.txt 2>&1 &

sleep 5

echo "Setze und lese todos_cache in Redis..."
redis-cli -h redis -p 6379 -a foobared SET todos_cache "tcpdump_test_string" > $LOG_DIR/redis_set.txt 2>&1 &
redis-cli -h redis -p 6379 -a foobared GET todos_cache > $LOG_DIR/redis_get.txt 2>&1 &

sleep 5


echo "Warte 60 Sekunden für vollständige Datenerfassung..."
sleep 60

echo "Beende TCPDump..."
sudo kill $TCPDUMP_PID

echo "Netzwerkanalyse abgeschlossen. Logs gespeichert in $LOG_DIR"

echo "Analysiere Test-Ergebnisse aus $LOG_DIR ..."

HTTP_COUNT=$(tcpdump -r $LOG_DIR/network.pcap -nn port 80 | grep -E "GET|POST|HTTP/1.1"| wc -l)
MARIADB_COUNT=$(tcpdump -r $LOG_DIR/network.pcap -nn port 3306 | wc -l)
REDIS_COUNT=$(tcpdump -r $LOG_DIR/network.pcap -nn port 6379 | wc -l)
WEBSOCKET_COUNT=$(tcpdump -r $LOG_DIR/network.pcap -nn port 5000 | wc -l)



echo -e "Anzahl der HTTP-Anfragen (Port 80):"
echo $HTTP_COUNT
echo -e "Anzahl der MariaDB-Anfragen (Port 3306):"
echo $MARIADB_COUNT
echo -e "Anzahl der Redis-Operationen (Port 6379):"
echo $REDIS_COUNT

echo -e "HTTP-Statuscode Verteilung:"
tcpdump -r $LOG_DIR/network.pcap -nn port 80 | grep -o "HTTP/1.1 [0-9]*" | sort | uniq -c

# Fehleranalyse
echo -e "Fehleranalyse in den Logs:"
grep -i "error" $LOG_DIR/*.txt | wc -l
echo "   Fehler gefunden: $(grep -i 'error' $LOG_DIR/*.txt | wc -l)"

grep -i "timeout" $LOG_DIR/*.txt | wc -l
echo "   Timeouts: $(grep -i 'timeout' $LOG_DIR/*.txt | wc -l)"

echo "Analyse abgeschlossen."

