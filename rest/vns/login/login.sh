#!/usr/bin/env bash

login_status="not_logged_in"
message=""

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
    result=$(mysql --defaults-file=my.cnf -e "SELECT password, salt FROM users WHERE email = '${email}';" -s -N)
    hashed_password=$(echo "$result" | awk '{print $1}')
    salt=$(echo "$result" | awk '{print $2}')

    if [ -z "$hashed_password" ]; then
      message="Fehler: Benutzer nicht gefunden."
    else
      # Hash das eingegebene Passwort mit dem gespeicherten Salt
      input_hash=$(echo -n "$password" | openssl passwd -1 -salt "$salt" -stdin)

      # Vergleiche Hashes
      if [ "$input_hash" == "$hashed_password" ]; then
        # Generiere eine Session-ID
        session_id=$(uuidgen)

        # Setze Ablaufzeit (z. B. 1 Stunde)
        expires_at=$(date -d "+1 hour" +"%Y-%m-%d %H:%M:%S")

        # Speichere die Session in der Datenbank
        mysql --defaults-file=my.cnf -e "INSERT INTO sessions (session_id, email, expires_at) VALUES ('$session_id', '$email', '$expires_at');"

        # Setze login_status, aber gib hier noch keine Header aus!
        login_status="logged_in"
      else
        message="Fehler: Falsches Passwort."
      fi
    fi
  fi
fi

if [ "$login_status" == "logged_in" ]; then
  # Nur die finalen Redirect-Header ausgeben und dann beenden
  echo "Set-Cookie: session_id=$session_id; Path=/; HttpOnly; SameSite=Lax"
  echo "Status: 303 See Other"
  echo "Location: https://informatik.hs-bremerhaven.de/docker-celakkoeprue-web/cgi-bin/vns/todo/table3.sh"
  echo ""  # Leere Zeile: Ende der Header
  exit 0
else
  # Falls Login nicht erfolgreich: HTML-Seite anzeigen
  echo "Content-type: text/html"
  echo ""
  cat header.html
  . notloggedin.sh
  cat footer.html
fi

