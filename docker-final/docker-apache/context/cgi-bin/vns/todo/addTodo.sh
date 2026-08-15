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

# POST-Daten lesen
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

# Parameter extrahieren
TASK="$(url_decode "$(extract_param task)")"
DETAILS="$(url_decode "$(extract_param details)")"

TASK_ESCAPED="$(sql_escape "$TASK")"
DETAILS_ESCAPED="$(sql_escape "$DETAILS")"

# Überprüfen, ob alle Parameter vorhanden sind
if [ -z "$TASK" ] || [ -z "$DETAILS" ]; then
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Ungültige oder fehlende Parameter.</p></body></html>"
  exit 1
fi

# Aufgabe in die todos-Tabelle einfügen
mariadb --defaults-file=my.cnf -e "INSERT INTO todos (task, details) VALUES ('$TASK_ESCAPED', '$DETAILS_ESCAPED');"

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
