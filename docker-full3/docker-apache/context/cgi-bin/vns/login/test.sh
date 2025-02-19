#!/bin/bash
echo "Content-type: text/html"
echo ""
echo "<html><head><title>MariaDB Tabellen</title></head><body>"
echo "<h2>MariaDB Tabellen</h2>"

echo "<pre>"
mariadb --defaults-file=my.cnf -e "SHOW TABLES;"
echo "</pre>"

echo "</body></html>"

