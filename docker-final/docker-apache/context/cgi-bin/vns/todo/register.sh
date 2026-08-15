#!/usr/bin/env bash

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

render_error() {
  local msg="$1"
  echo "Status: 400 Bad Request"
  echo "Content-type: text/html"
  echo ""
  echo "<html><body><h1>Registrierung fehlgeschlagen</h1><p>$msg</p><a href='/index.html?error=register'>Zurueck</a></body></html>"
  exit 1
}

if [ "$REQUEST_METHOD" != "POST" ]; then
  echo "Status: 303 See Other"
  echo "Location: /index.html"
  echo "Content-type: text/html"
  echo ""
  exit 0
fi

USERNAME="$(url_decode "$(extract_param username)")"
PASSWORD="$(url_decode "$(extract_param password)")"
CONFIRM_PASSWORD="$(url_decode "$(extract_param confirm_password)")"

if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ] || [ -z "$CONFIRM_PASSWORD" ]; then
  render_error "Bitte alle Felder ausfuellen."
fi

if ! [[ "$USERNAME" =~ ^[A-Za-z0-9_\-]{3,30}$ ]]; then
  render_error "Der Benutzername ist ungueltig (3-30 Zeichen, a-z, 0-9, _, -)."
fi

if [ ${#PASSWORD} -lt 6 ] || [ ${#PASSWORD} -gt 64 ]; then
  render_error "Das Passwort muss zwischen 6 und 64 Zeichen lang sein."
fi

if [ "$PASSWORD" != "$CONFIRM_PASSWORD" ]; then
  render_error "Die Passwoerter stimmen nicht ueberein."
fi

USERNAME_ESCAPED="$(sql_escape "$USERNAME")"
PASSWORD_ESCAPED="$(sql_escape "$PASSWORD")"

EXISTS=$(mariadb --defaults-file=my.cnf -N -B -e "SELECT COUNT(*) FROM users WHERE name='$USERNAME_ESCAPED';" 2>/dev/null)
if [ "$EXISTS" != "0" ]; then
  render_error "Benutzername existiert bereits."
fi

mariadb --defaults-file=my.cnf -e "INSERT INTO users (name, password) VALUES ('$USERNAME_ESCAPED', '$PASSWORD_ESCAPED');" 2>/dev/null
if [ $? -ne 0 ]; then
  render_error "Speichern in der Datenbank fehlgeschlagen."
fi

echo "Status: 303 See Other"
echo "Location: /index.html?registered=1"
echo "Content-type: text/html"
echo ""
