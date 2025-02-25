#!/bin/bash
log=/docker.log
echo starte >> $log

function onexit {
  #shutdown ...
  echo shutting down >> $log
  /etc/init.d/mariadb stop
  exit
}

trap onexit SIGTERM

echo trap handler set >> $log
# start services
/etc/init.d/mariadb start

#initialize database
sudo -u mysql mariadb -e "drop database if exists dbdemo;
drop user if exists dbuser@'localhost';
drop user if exists dbuser@'%';

CREATE DATABASE IF NOT EXISTS todo_app;
CREATE USER IF NOT EXISTS 'dbuser'@'%' IDENTIFIED BY '12345';
GRANT ALL PRIVILEGES ON todo_app.* TO 'dbuser'@'%';
FLUSH PRIVILEGES;

USE todo_app;

CREATE TABLE IF NOT EXISTS todos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  task VARCHAR(255) NOT NULL,
  details TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE users (
  name VARCHAR(50) PRIMARY KEY,
  password VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS sessions (
  session_id CHAR(36) PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  expires_at DATETIME NOT NULL,
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO users (name, password) VALUES ('admin', 'admin');
"

while true; do
  echo "$(date +%FT%T) ping" >> $log
  read -t 10 < /dev/null
done
