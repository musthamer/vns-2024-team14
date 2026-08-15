#!/usr/bin/env bash
REDIS_HOST="redis"
REDIS_PORT="6379"
REDIS_PASSWORD="foobared"

session_id=$(echo "$HTTP_COOKIE" | sed -n 's/.*session_id=\([^;]*\).*/\1/p')
session_user=""
if [ -n "$session_id" ]; then
  session_user=$(redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" -a "$REDIS_PASSWORD" GET "session:$session_id" 2>/dev/null)
fi
if [ -z "$session_user" ]; then
  echo "Status: 303 See Other"
  echo "Location: /index.html"
  echo "Content-type: text/html"
  echo ""
  exit 0
fi

# Lese POST-Daten
POST_DATA="$(cat)"

extract_param() {
  local key="$1"
  echo "$POST_DATA" | tr '&' '\n' | awk -F'=' -v k="$key" '$1 == k {sub($1"=", ""); print; exit}'
}

url_decode() {
  local raw="$1"
  raw="${raw//+/ }"
  printf '%b' "${raw//%/\\x}"
}

sql_escape() {
  echo "$1" | sed "s/'/''/g"
}

# Extrahiere die Parameter aus den POST-Daten
ID="$(extract_param id)"
TASK="$(url_decode "$(extract_param task)")"
DETAILS="$(url_decode "$(extract_param details)")"

if ! [[ "$ID" =~ ^[0-9]+$ ]]; then
  echo "Status: 400 Bad Request"
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Ungültige ID.</p></body></html>"
  exit 1
fi

TASK_ESCAPED="$(sql_escape "$TASK")"
DETAILS_ESCAPED="$(sql_escape "$DETAILS")"

# Überprüfe, ob alle Parameter vorhanden sind
if [ -z "$ID" ] || [ -z "$TASK" ] || [ -z "$DETAILS" ]; then
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Ungültige oder fehlende Parameter.</p></body></html>"
  exit 1
fi

# Aktualisiere die Aufgabe in der todos-Tabelle
mariadb --defaults-file=my.cnf -e "UPDATE todos SET task='$TASK_ESCAPED', details='$DETAILS_ESCAPED' WHERE id=$ID;"

# Überprüfe, ob das Update erfolgreich war
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
  echo "<html><body><p>Fehler: Aktualisierung der Aufgabe mit ID ${ID} fehlgeschlagen.</p></body></html>"
fi
