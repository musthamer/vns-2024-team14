#!/usr/bin/env bash

# Lese die POST-Daten
read -r POST_DATA

# Extrahiere die Parameter
NAME=$(echo "$POST_DATA" | sed -n 's/.*name=\([^&]*\).*$/\1/p')
EMAIL=$(echo "$POST_DATA" | sed -n 's/.*email=\([^&]*\).*$/\1/p')
PASSWORD=$(echo "$POST_DATA" | sed -n 's/.*password=\([^&]*\).*$/\1/p')
CONFIRM_PASSWORD=$(echo "$POST_DATA" | sed -n 's/.*confirm_password=\([^&]*\).*$/\1/p')

# Dekodiere URL-kodierte Zeichen
NAME=$(printf '%b' "${NAME//%/\\x}")
EMAIL=$(printf '%b' "${EMAIL//%/\\x}")
PASSWORD=$(printf '%b' "${PASSWORD//%/\\x}")
CONFIRM_PASSWORD=$(printf '%b' "${CONFIRM_PASSWORD//%/\\x}")

# Überprüfe, ob alle Parameter vorhanden sind
if [ -z "$NAME" ] || [ -z "$EMAIL" ] || [ -z "$PASSWORD" ] || [ -z "$CONFIRM_PASSWORD" ]; then
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Ungültige oder fehlende Parameter.</p></body></html>"
  exit 1
fi

# Überprüfe, ob die Passwörter übereinstimmen
if [ "$PASSWORD" != "$CONFIRM_PASSWORD" ]; then
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Die Passwörter stimmen nicht überein.</p></body></html>"
  exit 1
fi

# Passwort hashen (mit bcrypt)
HASHED_PASSWORD=$(echo -n "$PASSWORD" | openssl passwd -1 -stdin)

# Füge den Benutzer in die Datenbank ein
mariadb --defaults-file=my.cnf -e "INSERT INTO users (name, email, password) VALUES ('$NAME', '$EMAIL', '$HASHED_PASSWORD');"

# Überprüfe, ob das Einfügen erfolgreich war
if [ $? -eq 0 ]; then
  echo "Content-type: text/html"
  echo "Status: 303 See Other"
  echo "Location: https://informatik.hs-bremerhaven.de/docker-celakkoeprue-web/cgi-bin/vns/login/login.sh"
  echo ""
else
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Registrierung fehlgeschlagen.</p></body></html>"
fi
