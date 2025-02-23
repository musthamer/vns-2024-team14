#!/usr/bin/env bash

read -r QUERY_STRING

# Parameter extrahieren: ID
ID=$(echo "$QUERY_STRING" | sed -n 's/.*id=\([0-9]*\).*/\1/p')

# URL-dekodieren mit sed
ID=$(echo -e "$(echo "$ID" | sed 's/+/ /g; s/%/\\x/g')")

# Überprüfen, ob ID vorhanden ist
if [ -z "$ID" ]; then
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Keine ID angegeben.</p></body></html>"
  exit 1
fi

# Lösche den Eintrag mit der angegebenen ID aus der todos-Tabelle
mariadb --defaults-file=my.cnf -e "DELETE FROM todos WHERE id=${ID};"

if [ $? -eq 0 ]; then
  echo "Content-type: text/html"
  echo "Status: 303 See Other"
  echo "Location: table3.sh"
  echo ""
else
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Löschen der ID ${ID} fehlgeschlagen.</p></body></html>"
fi
