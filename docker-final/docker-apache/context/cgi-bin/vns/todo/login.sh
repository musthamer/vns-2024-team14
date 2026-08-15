#!/bin/bash

# Redis-Konfiguration
REDIS_HOST="redis"
REDIS_PORT="6379"
REDIS_PASSWORD="foobared"

if [ "$REQUEST_METHOD" = "POST" ]; then
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

  # Benutzername und Passwort aus dem POST-String extrahieren
  USERNAME="$(url_decode "$(extract_param username)")"
  PASSWORD="$(url_decode "$(extract_param password)")"

  if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ]; then
    echo "Status: 400 Bad Request"
    echo "Content-type: text/html"
    echo ""
    echo "<html><body><h1>Fehlende Login-Daten</h1></body></html>"
    exit 1
  fi

  USERNAME_ESCAPED="$(sql_escape "$USERNAME")"
  PASSWORD_ESCAPED="$(sql_escape "$PASSWORD")"

  # Überprüfen, ob Benutzer existiert (z.B. in MariaDB)
  RESULT=$(mariadb --defaults-file=my.cnf -N -B -e "
    SELECT name FROM users
    WHERE name = '$USERNAME_ESCAPED'
      AND password = '$PASSWORD_ESCAPED'
    LIMIT 1;
  " 2>/dev/null)

  if [ "$RESULT" = "$USERNAME" ]; then
    # Erzeuge eine Session-ID, z.B. mit uuidgen oder openssl
    SESSION_ID=$(uuidgen)

    # Session in Redis speichern (SETEX: Key, TTL in Sekunden, Wert)
    redis_result=$(redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" -a "$REDIS_PASSWORD" SETEX "session:$SESSION_ID" 3600 "$USERNAME" 2>/dev/null)

    if [ "$redis_result" = "OK" ]; then
      # Setze das Cookie und leite weiter
      echo "Set-Cookie: session_id=$SESSION_ID; Path=/; HttpOnly; SameSite=Lax"
      echo "Status: 303 See Other"
      echo "Location: /cgi-bin/vns/todo/table3.sh"
      echo ""
      exit 0
    else
      # Fehler beim Speichern in Redis
      echo "Content-type: text/html"
      echo ""
      echo "<html><body><h1>Fehler beim Speichern der Session in Redis</h1></body></html>"
      exit 1
    fi
  fi
fi

# Falls der Login fehlgeschlagen ist:
echo "Status: 303 See Other"
echo "Location: /index.html?error=login"
echo "Content-type: text/html"
echo ""
