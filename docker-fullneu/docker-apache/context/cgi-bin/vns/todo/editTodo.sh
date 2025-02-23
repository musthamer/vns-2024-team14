#!/usr/bin/env bash

# Lese die QUERY_STRING-Umgebungsvariable
read -r QUERY_STRING

# Extrahiere die Parameter aus der QUERY_STRING
ID=$(echo "$QUERY_STRING" | sed -n 's/^.*id=\([0-9]*\).*$/\1/p')
TASK=$(echo "$QUERY_STRING" | sed -n 's/^.*task=\([^&]*\).*$/\1/p')
DETAILS=$(echo "$QUERY_STRING" | sed -n 's/^.*details=\([^&]*\).*$/\1/p')

# URL-dekodieren mit sed
TASK=$(echo -e "$(echo "$TASK" | sed 's/+/ /g; s/%/\\x/g')")
DETAILS=$(echo -e "$(echo "$DETAILS" | sed 's/+/ /g; s/%/\\x/g')")

# Überprüfe, ob alle Parameter vorhanden sind
if [ -z "$ID" ] || [ -z "$TASK" ] || [ -z "$DETAILS" ]; then
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Ungültige oder fehlende Parameter.</p></body></html>"
  exit 1
fi

# Aktualisiere die Aufgabe in der todos-Tabelle
mariadb --defaults-file=my.cnf -e "UPDATE todos SET task='$TASK', details='$DETAILS' WHERE id=$ID;"

# Überprüfe, ob das Update erfolgreich war
if [ $? -eq 0 ]; then
  echo "Content-type: text/html"
  echo "Status: 303 See Other"
  echo "Location: table3.sh"
  echo ""
else
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Aktualisierung der Aufgabe mit ID ${ID} fehlgeschlagen.</p></body></html>"
fi
