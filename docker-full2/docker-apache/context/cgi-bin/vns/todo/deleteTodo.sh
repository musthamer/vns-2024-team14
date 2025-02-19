#!/usr/bin/env bash

read -r QUERY_STRING

# Parameter extrahieren: ID und Tabellenname
ID=$(echo "$QUERY_STRING" | sed -n 's/.*id=\([0-9]*\).*/\1/p')
TABLE=$(echo "$QUERY_STRING" | sed -n 's/.*table=\([^&]*\).*/\1/p')

# URL-dekodieren
ID=$(printf '%b' "$ID")
TABLE=$(printf '%b' "$TABLE")

# Überprüfen, ob ID vorhanden ist
if [ -z "$ID" ]; then
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Keine ID angegeben.</p></body></html>"
  exit 1
fi

# Überprüfen, ob der Tabellenname vorhanden ist
if [ -z "$TABLE" ]; then
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Kein Tabellenname angegeben.</p></body></html>"
  exit 1
fi

# Sicherheitscheck: Der Tabellenname muss dem Muster "todos_" gefolgt von 32 hexadezimalen Zeichen entsprechen
if [[ ! "$TABLE" =~ ^todos_[0-9a-f]{32}$ ]]; then
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Ungültiger Tabellenname.</p></body></html>"
  exit 1
fi

# Lösche den Eintrag mit der angegebenen ID aus der benutzerspezifischen Tabelle
mariadb --defaults-file=my.cnf -e "DELETE FROM ${TABLE} WHERE id=${ID};"

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

