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

POST_DATA="$(cat)"

extract_param() {
  local key="$1"
  echo "$POST_DATA" | tr '&' '\n' | awk -F'=' -v k="$key" '$1 == k {sub($1"=", ""); print; exit}'
}

# Parameter extrahieren: ID
ID="$(extract_param id)"

# Überprüfen, ob ID vorhanden ist
if [ -z "$ID" ]; then
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Keine ID angegeben.</p></body></html>"
  exit 1
fi

if ! [[ "$ID" =~ ^[0-9]+$ ]]; then
  echo "Status: 400 Bad Request"
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Ungültige ID.</p></body></html>"
  exit 1
fi

# Lösche den Eintrag mit der angegebenen ID aus der todos-Tabelle
mariadb --defaults-file=my.cnf -e "DELETE FROM todos WHERE id=${ID};"

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
  echo "<html><body><p>Fehler: Löschen der ID ${ID} fehlgeschlagen.</p></body></html>"
fi
