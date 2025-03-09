#!/bin/bash

mariadb --defaults-file=my.cnf -e "
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    salt VARCHAR(255) NOT NULL
);

CREATE TABLE sessions (
    session_id CHAR(36) PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL,
    expires_at DATETIME NOT NULL,
    FOREIGN KEY (email) REFERENCES users(email) ON DELETE CASCADE
);
"

