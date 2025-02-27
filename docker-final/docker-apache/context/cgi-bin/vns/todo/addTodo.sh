#!/usr/bin/env bash
REDIS_HOST="redis"
REDIS_PORT="6379"
REDIS_PASSWORD="foobared"
# POST-Daten lesen
read -r POST_DATA

# Parameter extrahieren
TASK=$(echo "$POST_DATA" | sed -n 's/.*task=\([^&]*\).*/\1/p')
DETAILS=$(echo "$POST_DATA" | sed -n 's/.*details=\([^&]*\).*/\1/p')

# URL-dekodieren mit sed
TASK=$(echo -e "$(echo "$TASK" | sed 's/+/ /g; s/%/\\x/g')")
DETAILS=$(echo -e "$(echo "$DETAILS" | sed 's/+/ /g; s/%/\\x/g')")

# Überprüfen, ob alle Parameter vorhanden sind
if [ -z "$TASK" ] || [ -z "$DETAILS" ]; then
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Ungültige oder fehlende Parameter.</p></body></html>"
  exit 1
fi

# Aufgabe in die todos-Tabelle einfügen
mariadb --defaults-file=my.cnf -e "INSERT INTO todos (task, details) VALUES ('$TASK', '$DETAILS');"

# Überprüfen, ob das Einfügen erfolgreich war
if [ $? -eq 0 ]; then
  # Redis-Cache invalidieren
  redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" -a "$REDIS_PASSWORD" del "todos_cache" >/dev/null
  
  echo "Content-type: text/html"
  echo "Status: 303 See Other"
  echo "Location: table3.sh"
  echo ""
else
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Einfügen der Aufgabe fehlgeschlagen.</p></body></html>"
fi
