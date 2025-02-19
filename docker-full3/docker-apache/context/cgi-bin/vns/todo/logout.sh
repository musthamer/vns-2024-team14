#!/usr/bin/env bash

# Redis-Konfiguration
REDIS_HOST="redis"
REDIS_PORT="6379"
export REDISCLI_AUTH="foobared"

# Session-ID aus Cookie extrahieren (robuster mit awk)
session_id=$(echo "$HTTP_COOKIE" | grep -o 'session_id=[^;]*' | cut -d'=' -f2)
# Session löschen, falls vorhanden
if [ -n "$session_id" ]; then
  redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" DEL "session:$session_id" >/dev/null
fi
echo "Content-type: text/html"  # Muss zuerst kommen
echo "Status: 303 See Other"     # Status vor Location
echo "Location: ../login/login.sh"
echo "Set-Cookie: session_id=; Path=/; Expires=Thu, 01 Jan 1970 00:00:00 GMT; HttpOnly"
echo ""  # Leerzeile nicht vergessen!
exit 0
