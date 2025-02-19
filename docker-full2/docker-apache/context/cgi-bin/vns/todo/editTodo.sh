#!/usr/bin/env bash

# Lese die QUERY_STRING-Umgebungsvariable
read -r QUERY_STRING

# Extrahiere die Parameter aus der QUERY_STRING
ID=$(echo "$QUERY_STRING" | sed -n 's/^.*id=\([0-9]*\).*$/\1/p')
TASK=$(echo "$QUERY_STRING" | sed -n 's/^.*task=\([^&]*\).*$/\1/p')
DETAILS=$(echo "$QUERY_STRING" | sed -n 's/^.*details=\([^&]*\).*$/\1/p')
TABLE=$(echo "$QUERY_STRING" | sed -n 's/^.*table=\([^&]*\).*$/\1/p')

# Dekodiere URL-kodierte Zeichen
TASK=$(printf '%b' "${TASK//%/\\x}")
DETAILS=$(printf '%b' "${DETAILS//%/\\x}")
TABLE=$(printf '%b' "${TABLE//%/\\x}")

# Überprüfe, ob alle Parameter vorhanden sind
if [ -z "$ID" ] || [ -z "$TASK" ] || [ -z "$DETAILS" ] || [ -z "$TABLE" ]; then
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Ungültige oder fehlende Parameter.</p></body></html>"
  exit 1
fi

# Sicherheitscheck: Der Tabellenname muss dem Muster "todos_" gefolgt von 32 hexadezimalen Zeichen entsprechen
if [[ ! "$TABLE" =~ ^todos_[0-9a-f]{32}$ ]]; then
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Ungültiger Tabellenname.</p></body></html>"
  exit 1
fi

# Aktualisiere die Aufgabe in der benutzerspezifischen Tabelle
mariadb --defaults-file=my.cnf -e "UPDATE ${TABLE} SET task='$TASK', details='$DETAILS' WHERE id=$ID;"

# Überprüfe, ob das Update erfolgreich war
if [ $? -eq 0 ]; then
  echo "Content-type: text/html"
  echo "Status: 303 See Other"
  echo "Location: table3.sh?table=$TABLE"
  echo ""
else
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Aktualisierung der Aufgabe mit ID ${ID} fehlgeschlagen.</p></body></html>"
fi

