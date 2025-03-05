#!/bin/bash
# Dynamisches TCPDump-Testskript mit Laufzeitwahl und erweiterter Analyse

# Benutzer nach der gewünschten Laufzeit fragen
read -p "Geben Sie die gewünschte Laufzeit für tcpdump in Sekunden ein: " DURATION

# Prüfen, ob die Eingabe eine Zahl ist
if ! [[ "$DURATION" =~ ^[0-9]+$ ]]; then
    echo "Fehler: Bitte geben Sie eine gültige Zahl ein!"
    exit 1
fi

LOG_DIR="tcpdump_logs"
mkdir -p $LOG_DIR

echo "Starte Netzwerkanalyse mit tcpdump für $DURATION Sekunden..."
sudo tcpdump -i eth0 port 8000 or port 443 or port 3306 or port 6379 -w $LOG_DIR/network.pcap &
TCPDUMP_PID=$!

# Warten, solange die Benutzerzeit angibt
sleep $DURATION

# TCPDump beenden
echo "Beende TCPDump nach $DURATION Sekunden..."
sudo kill $TCPDUMP_PID

echo "Netzwerkanalyse abgeschlossen. Logs gespeichert in $LOG_DIR"

# Kurze Analyse der Ergebnisse
echo "Analysiere erfasste Daten..."

# Anzahl der Pakete für verschiedene Protokolle zählen
HTTP_COUNT=$(tcpdump -r $LOG_DIR/network.pcap -nn port 8000 | wc -l)
MYSQL_COUNT=$(tcpdump -r $LOG_DIR/network.pcap -nn port 3306 | wc -l)
REDIS_COUNT=$(tcpdump -r $LOG_DIR/network.pcap -nn port 6379 | wc -l)

echo " Anzahl der HTTP-Anfragen (Port 8000):"
echo "   $HTTP_COUNT"

echo " Anzahl der MariaDB-Anfragen (Port 3306):"
echo "   $MYSQL_COUNT"

echo " Anzahl der Redis-Operationen (Port 6379):"
echo "   $REDIS_COUNT"


# HTTP-Statuscode Verteilung analysieren
echo "📌 HTTP-Statuscode Verteilung:"
tcpdump -r $LOG_DIR/network.pcap -nn port 80 | grep -o "HTTP/1.1 [0-9]\+" | sort | uniq -c

# Fehleranalyse
ERRORS=$(grep -c "ERROR" "$LOG_DIR/"*.txt)
TIMEOUTS=$(grep -c "timeout" "$LOG_DIR/"*.txt)
echo "📌 Fehleranalyse"
echo "   Fehler gefunden: $ERRORS"
echo "   Timeouts: $TIMEOUTS"

echo "Analyse abgeschlossen."

