#!/bin/bash

# Redis-Konfiguration
REDIS_HOST="redis"
REDIS_PORT="6379"
REDIS_PASSWORD="foobared"

if [ "$REQUEST_METHOD" = "POST" ]; then
  read -r POST_DATA

  # Benutzername und Passwort aus dem POST-String extrahieren
  USERNAME=$(echo "$POST_DATA" | sed -n 's/.*username=\([^&]*\).*/\1/p')
  PASSWORD=$(echo "$POST_DATA" | sed -n 's/.*password=\([^&]*\).*/\1/p')

  # Überprüfen, ob Benutzer existiert (z.B. in MariaDB)
  RESULT=$(mariadb --defaults-file=my.cnf -e "
    SELECT name FROM users
    WHERE name = '$USERNAME'
      AND password = '$PASSWORD';
  ")

  if [ -n "$RESULT" ]; then
    # Erzeuge eine Session-ID, z.B. mit uuidgen oder openssl
    SESSION_ID=$(uuidgen)

    # Session in Redis speichern (SETEX: Key, TTL in Sekunden, Wert)
    redis_result=$(redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" -a "$REDIS_PASSWORD" SETEX "session:$SESSION_ID" 3600 "$USERNAME")

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
echo "Content-type: text/html"
echo ""
echo "<html>
<head><title>Login Failed</title></head>
<body>
  <h1>Login fehlgeschlagen</h1>
  <a href='/index.html'>Erneut versuchen</a>
</body>
</html>"
