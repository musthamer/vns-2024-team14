#!/usr/bin/env bash

echo "Content-type: text/html"
echo ""

login_status="not_logged_in"
message=""

if [ "$REQUEST_METHOD" == "POST" ]; then
  read -r input_data

  decoded_data=$(echo "$input_data" | sed -e 's/%40/@/g')

  email=$(echo "$decoded_data" | grep -oP 'email=\K[^&]*')
  password=$(echo "$input_data" | grep -oP 'password=\K[^&]*')
  result=$(mysql --defaults-file=my.cnf -e "SELECT COUNT(*) FROM users WHERE email = '${email}' AND password = '${password}';" -s -N)

  if [ "$result" -eq 0 ]; then
    message="Fehlgeschlagen. Bitte überprüfen Sie Ihre Eingaben."
  else
    message="Willkommen ${email}!"
    login_status="logged_in"
  fi
fi

if [ "$login_status" == "logged_in" ]; then
  . ../todo/table3.sh
  cat ../todo/styles.html
else
  cat header.html
  . notloggedin.sh
  cat footer.html
fi
