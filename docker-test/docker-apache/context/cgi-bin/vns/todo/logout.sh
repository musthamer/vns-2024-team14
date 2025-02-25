#!/bin/bash

SESSION_ID=$(echo "$HTTP_COOKIE" | grep -o 'session_id=[^;]*' | cut -d'=' -f2)

if [ -n "$SESSION_ID" ]; then
  END_SESSION=$(mariadb --defaults-file=my.cnf -sN -e "SELECT QUOTE('$SESSION_ID')")
  mariadb --defaults-file=my.cnf -e "
    DELETE FROM sessions 
    WHERE session_id = $END_SESSION"
fi

echo "Content-type: text/html"
echo "Set-Cookie: session_id=; HttpOnly;"
echo "Status: 303 See Other"
echo "Location: /index.html"
echo ""
