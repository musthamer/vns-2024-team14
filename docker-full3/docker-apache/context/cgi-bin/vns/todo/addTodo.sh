#!/usr/bin/env bash

read -r POST_DATA

# Parameter extrahieren
TASK=$(echo "$POST_DATA" | sed -n 's/.*task=\([^&]*\).*$/\1/p')
DETAILS=$(echo "$POST_DATA" | sed -n 's/.*details=\([^&]*\).*$/\1/p')
TABLE=$(echo "$POST_DATA" | sed -n 's/.*table=\([^&]*\).*$/\1/p')

# URL-dekodieren
TASK=$(printf '%b' "${TASK//%/\\x}")
DETAILS=$(printf '%b' "${DETAILS//%/\\x}")
TABLE=$(printf '%b' "${TABLE//%/\\x}")

# Überprüfen, ob alle Parameter vorhanden sind
if [ -z "$TASK" ] || [ -z "$DETAILS" ] || [ -z "$TABLE" ]; then
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Ungültige oder fehlende Parameter.</p></body></html>"
  exit 1
fi

# Sicherheitscheck: Der Tabellenname muss dem Muster "todos_" gefolgt von 32 hexadezimalen Zeichen entsprechen.
if [[ ! "$TABLE" =~ ^todos_[0-9a-f]{32}$ ]]; then
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Ungültiger Tabellenname.</p></body></html>"
  exit 1
fi

# Aufgabe in die benutzerspezifische Tabelle einfügen
mariadb --defaults-file=my.cnf -e "INSERT INTO ${TABLE} (task, details) VALUES ('$TASK', '$DETAILS');"

if [ $? -eq 0 ]; then
  echo "Content-type: text/html"
  echo "Status: 303 See Other"
  echo "Location: table3.sh"
  echo ""
else
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Einfügen der Aufgabe fehlgeschlagen.</p></body></html>"
fi

