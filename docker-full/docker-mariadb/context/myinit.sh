#!/bin/bash
log=/docker.log
echo starte >> $log

trap onexit SIGTERM 

function onexit {
  #shutdown ...
  echo shutting down >> $log
  /etc/init.d/mariadb stop
  exit
}
echo trap handler set >> $log 
# start services
/etc/init.d/mariadb start

#initialize database
mysql -u root -e "

CREATE DATABASE IF NOT EXISTS todo_app;
CREATE USER IF NOT EXISTS dbuser@'%' IDENTIFIED BY 'vnsteam14';
GRANT ALL PRIVILEGES ON todo_app.* TO dbuser@'%';
FLUSH PRIVILEGES;

USE todo_app

CREATE TABLE IF NOT EXISTS users (
id INT AUTO_INCREMENT PRIMARY KEY, 
name VARCHAR(100) NOT NULL
email VARCHAR(255) NOT NULL UNIQUE
password VARCHAR (255) NOT NULL
salt VARCHAR(255) NOT NULL);

CREATE TABLE IF NOT EXISTS sessions (
sessions_id CHAR(36) PRIMARY KEY,
email VARCHAT(255) NOT NULL,
created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
expires_at DATETIME NOT NULL,
FOREIGN KEY (email) REFERENCES users(email) ON DELETE CASCADE
);
"

while true; do
  echo "$(date +%FT%T) ping" >> $log
  read -t 10 </dev/fd/1
done
