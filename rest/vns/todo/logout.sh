#!/usr/bin/env bash

# Session-ID aus dem Cookie extrahieren
session_id=$(echo "$HTTP_COOKIE" | sed -n 's/.*session_id=\([^;]*\).*/\1/p')

# Falls eine Session existiert, lösche sie aus der Datenbank
if [ -n "$session_id" ]; then
  mariadb --defaults-file=my.cnf -e "DELETE FROM sessions WHERE session_id='${session_id}';"
fi

# Setze den Session-Cookie zurück (lösche ihn) und leite zur Login-Seite weiter
echo "Set-Cookie: session_id=deleted; Path=/; Expires=Thu, 01 Jan 1970 00:00:00 GMT; HttpOnly; SameSite=Lax"
echo "Content-type: text/html"
echo "Status: 303 See Other"
echo "Location: https://informatik.hs-bremerhaven.de/docker-celakkoeprue-web/cgi-bin/vns/login/login.sh"
echo ""

