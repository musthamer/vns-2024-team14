#!/usr/bin/env bash

# Lese POST-Daten
read -r POST_DATA

# Extrahiere Parameter
NAME=$(echo "$POST_DATA" | sed -n 's/.*name=\([^&]*\).*$/\1/p')
EMAIL=$(echo "$POST_DATA" | sed -n 's/.*email=\([^&]*\).*$/\1/p')
PASSWORD=$(echo "$POST_DATA" | sed -n 's/.*password=\([^&]*\).*$/\1/p')
CONFIRM_PASSWORD=$(echo "$POST_DATA" | sed -n 's/.*confirm_password=\([^&]*\).*$/\1/p')

# Dekodiere URL-kodierte Zeichen
NAME=$(printf '%b' "${NAME//%/\\x}")
EMAIL=$(printf '%b' "${EMAIL//%/\\x}")
PASSWORD=$(printf '%b' "${PASSWORD//%/\\x}")
CONFIRM_PASSWORD=$(printf '%b' "${CONFIRM_PASSWORD//%/\\x}")

# Überprüfe Passwörter
if [ "$PASSWORD" != "$CONFIRM_PASSWORD" ]; then
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><p>Fehler: Passwörter stimmen nicht überein.</p></body></html>"
  exit 1
fi

# Generiere Salt (16 Zeichen)
SALT=$(openssl rand -hex 8)

# Hash das Passwort mit Salt
HASHED_PASSWORD=$(echo -n "$PASSWORD" | openssl passwd -1 -salt "$SALT" -stdin)

# Füge Benutzer in die Datenbank ein
mariadb --defaults-file=my.cnf -e "INSERT INTO users (name, email, password, salt) VALUES ('$NAME', '$EMAIL', '$HASHED_PASSWORD', '$SALT');"

# Erstelle für den Benutzer eine eigene ToDo-Tabelle
# Erzeuge einen eindeutigen Tabellennamen anhand eines Hashes der E-Mail-Adresse
EMAIL_HASH=$(echo -n "$EMAIL" | md5sum | awk '{print $1}')
TABLE_NAME="todos_${EMAIL_HASH}"

mariadb --defaults-file=my.cnf -e "CREATE TABLE ${TABLE_NAME} (
  id INT AUTO_INCREMENT PRIMARY KEY,
  task VARCHAR(255) NOT NULL,
  details TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);"

# Weiterleitung zur Login-Seite
echo "Content-type: text/html"
echo "Status: 303 See Other"
echo "Location: https://informatik.hs-bremerhaven.de/docker-celakkoeprue-web/cgi-bin/vns/login/login.sh"
echo ""

