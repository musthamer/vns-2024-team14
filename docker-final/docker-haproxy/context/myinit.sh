#!/bin/bash

# Log-Datei in ein existierendes Verzeichnis verschieben
log=/var/log/docker.log
echo "HAProxy-Container gestartet: $(date)" >> "$log"

# Funktion für sauberes Herunterfahren
function onexit {
  echo "HAProxy-Container wird heruntergefahren: $(date)" >> "$log"
  service haproxy stop
  exit
}

# Trap für SIGTERM (z. B. bei `docker stop`)
trap onexit SIGTERM

# HAProxy-Service starten
echo "Starte HAProxy..." >> "$log"
service haproxy start

# HAProxy-Status anzeigen
echo "HAProxy-Status:" >> "$log"
service haproxy status >> "$log"

# Container am Leben halten
echo "HAProxy-Container läuft: $(date)" >> "$log"
while true; do
  echo "$(date +%FT%T) ping" >> "$log"
  sleep 10
done
