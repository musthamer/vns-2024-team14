#!/usr/bin/env bash

login_status="not_logged_in"
message=""

# Redis-Konfiguration
REDIS_HOST="redis"
REDIS_PORT="6379"
REDIS_PASSWORD="foobared"
export REDISCLI_AUTH="$REDIS_PASSWORD"  # Passwort als Umgebungsvariable

if [ "$REQUEST_METHOD" == "POST" ]; then
  # Lese POST-Daten
  read -r input_data

  # Extrahiere E-Mail und Passwort
  email=$(echo "$input_data" | sed -n 's/.*email=\([^&]*\).*$/\1/p')
  password=$(echo "$input_data" | sed -n 's/.*password=\([^&]*\).*$/\1/p')

  # Dekodiere URL-kodierte Zeichen
  email=$(printf '%b' "${email//%/\\x}")
  password=$(printf '%b' "${password//%/\\x}")

  # Überprüfe Eingaben
  if [ -z "$email" ] || [ -z "$password" ]; then
    message="Fehler: Bitte E-Mail und Passwort eingeben."
  else
    # Hole Hash und Salt aus der Datenbank
    result=$(mysql --defaults-file=my.cnf -e "SELECT password, salt FROM users WHERE email = '${email}';" -s -N 2>/dev/null)
    hashed_password=$(echo "$result" | awk '{print $1}')
    salt=$(echo "$result" | awk '{print $2}')

    if [ -z "$hashed_password" ]; then
      message="Fehler: Benutzer nicht gefunden."
    else
      # Hash das eingegebene Passwort mit dem gespeicherten Salt
      input_hash=$(echo -n "$password" | openssl passwd -1 -salt "$salt" -stdin 2>/dev/null)

      if [ "$input_hash" == "$hashed_password" ]; then
        # Generiere eine Session-ID (mit Fallback)
        session_id=$(uuidgen 2>/dev/null || openssl rand -hex 16)
        echo "Debug: Generierte Session-ID: $session_id" >&2

        # Session in Redis speichern
        redis_response=$(redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" SETEX "session:$session_id" 3600 "$email" 2>&1)
        echo "Debug: Redis-Response: $redis_response" >&2

        if [ "$redis_response" == "OK" ]; then
          login_status="logged_in"
        else
          message="Fehler: Session konnte nicht gespeichert werden."
        fi
      else
        message="Fehler: Falsches Passwort."
      fi
    fi
  fi
fi

if [ "$login_status" == "logged_in" ]; then
  echo "Set-Cookie: session_id=$session_id; Path=/; HttpOnly; SameSite=Lax"
  echo "Status: 303 See Other"
  echo "Location: ../todo/table3.sh"
  echo ""
  exit 0
else
  echo "Content-type: text/html"
  echo ""
  cat header.html
  [ -n "$message" ] && echo "<div class='error'>$message</div>"
  . notloggedin.sh
  cat footer.html
fi
