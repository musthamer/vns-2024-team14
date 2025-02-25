#!/bin/bash

if [ "$REQUEST_METHOD" = "POST" ]; then
  read -r POST_DATA

  USERNAME=$(echo "$POST_DATA" | sed -n 's/.*username=\([^&]*\).*/\1/p')
  PASSWORD=$(echo "$POST_DATA" | sed -n 's/.*password=\([^&]*\).*/\1/p')

  RESULT=$(mariadb --defaults-file=my.cnf -e "
    SELECT name FROM users
    WHERE name = '$USERNAME'
      AND password = '$PASSWORD';
  ")

  if [ -n "$RESULT" ]; then
    SESSION_ID=$(uuidgen)
    mariadb --defaults-file=my.cnf -e "
      INSERT INTO sessions (session_id, name, expires_at)
      VALUES ('$SESSION_ID', '$USERNAME', DATE_ADD(NOW(), INTERVAL 1 HOUR));"

    echo "Set-Cookie: session_id=$SESSION_ID; Path=/; HttpOnly; SameSite=Lax"
    echo "Status: 303 See Other"
    echo "Location: /cgi-bin/vns/todo/table3.sh"
    echo ""
    exit 0
  fi
fi


echo "Content-type: text/html"
echo ""
echo "<html>
<head><title>Login Failed</title></head>
<body>
  <h1>Login fehlgeschlagen</h1>
  <a href='/index.html'>Erneut versuchen</a>
</body>
</html>"
