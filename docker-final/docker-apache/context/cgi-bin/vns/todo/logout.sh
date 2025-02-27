#!/bin/bash
REDIS_HOST="redis"
REDIS_PORT="6379"
REDIS_PASSWORD="foobared"

# Session-ID aus dem Cookie extrahieren
SESSION_ID=$(echo "$HTTP_COOKIE" | grep -o 'session_id=[^;]*' | cut -d'=' -f2)

# Session aus Redis löschen
if [ -n "$SESSION_ID" ]; then
  redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" -a "$REDIS_PASSWORD" DEL "session:$SESSION_ID" >/dev/null
fi

# Cookie löschen und Weiterleitung zur Login-Seite
echo "Content-type: text/html"
echo "Set-Cookie: session_id=; expires=Thu, 01 Jan 1970 00:00:00 GMT; Path=/"
echo "Status: 303 See Other"
echo "Location: /index.html"
echo ""
