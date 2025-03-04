#!/bin/bash

# MariaDB Stresstest mit sysbench
echo "Starte MariaDB Stresstest..."
docker exec -ti work apt-get install -y sysbench

# Sicherstellen, dass die Tabellen erstellt werden!
echo "Initialisiere Testtabellen..."
docker exec -ti work sysbench --db-driver=mysql \
    --mysql-host=mariadb --mysql-user=dbuser --mysql-password=12345 \
    --mysql-db=todo_app --table-size=20000 --tables=20 --threads=20 oltp_read_write prepare

echo "Starte Lese-Last-Test..."
docker exec -ti work sysbench --db-driver=mysql \
    --mysql-host=mariadb --mysql-user=dbuser --mysql-password=12345 \
    --mysql-db=todo_app --tables=20 --threads=20 --time=30 --report-interval=5 oltp_read_only run > mariadb_stresstest_read.txt

echo "Starte Schreib-Last-Test..."
docker exec -ti work sysbench --db-driver=mysql \
    --mysql-host=mariadb --mysql-user=dbuser --mysql-password=12345 \
    --mysql-db=todo_app --tables=20 --threads=20 --time=30 --report-interval=5 oltp_write_only run > mariadb_stresstest_write.txt

echo "MariaDB Stresstest abgeschlossen. Ergebnisse gespeichert in mariadb_stresstest_read.txt und mariadb_stresstest_write.txt"

