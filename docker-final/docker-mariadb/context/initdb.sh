#!/bin/bash
sudo -u mysql mariadb -e "drop database if exists dbdemo;
drop user if exists dbuser@'localhost';
drop user if exists dbuser@'%';

CREATE DATABASE IF NOT EXISTS todo_app;
CREATE USER IF NOT EXISTS 'dbuser'@'%' IDENTIFIED BY '12345';
GRANT ALL PRIVILEGES ON todo_app.* TO 'dbuser'@'%';
FLUSH PRIVILEGES;

USE todo_app;

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR (255) NOT NULL,
  salt VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS sessions (
  sessions_id CHAR(36) PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  expires_at DATETIME NOT NULL,
  FOREIGN KEY (email) REFERENCES users(email) ON DELETE CASCADE
);
"
