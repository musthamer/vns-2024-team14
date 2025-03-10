#!/bin/bash

read -p "Geben Sie die gewünschte Laufzeit für tcpdump in Sekunden ein: " DURATION

if ! [[ "$DURATION" =~ ^[0-9]+$ ]]; then
    echo "Fehler: Bitte geben Sie eine gültige Zahl ein!"
    exit 1
fi

LOG_DIR="tcpdump_logs"
mkdir -p $LOG_DIR

echo "Starte Netzwerkanalyse mit tcpdump für $DURATION Sekunden..."
sudo tcpdump -i eth0 port 80 or port 3306 or port 6379 -w $LOG_DIR/network.pcap &

TCPDUMP_PID=$!

sleep $DURATION

echo "Beende TCPDump nach $DURATION Sekunden..."
sudo kill $TCPDUMP_PID

echo "Netzwerkanalyse abgeschlossen. Logs gespeichert in $LOG_DIR"

echo "Analysiere erfasste Daten..."

TCP_COUNT=$(tcpdump -r $LOG_DIR/network.pcap -nn port 80 | wc -l)
MYSQL_COUNT=$(tcpdump -r $LOG_DIR/network.pcap -nn port 3306 | wc -l)
REDIS_COUNT=$(tcpdump -r $LOG_DIR/network.pcap -nn port 6379 | wc -l)


echo " Anzahl der TCP-Anfragen (Port 80):"
echo "   $TCP_COUNT"

echo " Anzahl der MariaDB-Anfragen (Port 3306):"
echo "   $MYSQL_COUNT"

echo " Anzahl der Redis-Operationen (Port 6379):"
echo "   $REDIS_COUNT"



echo -e "HTTP-Statuscode Verteilung:"
tcpdump -r $LOG_DIR/network.pcap -nn port 80 | grep -o "HTTP/1.1 [0-9]*" | sort | uniq -c

echo -e "Fehleranalyse in den Logs:"
grep -i "error" $LOG_DIR/*.txt | wc -l
echo "   Fehler gefunden: $(grep -i 'error' $LOG_DIR/*.txt | wc -l)"

grep -i "timeout" $LOG_DIR/*.txt | wc -l
echo "   Timeouts: $(grep -i 'timeout' $LOG_DIR/*.txt | wc -l)"

echo "Analyse abgeschlossen."
