#!/bin/bash

echo "Starte MariaDB Stresstest..."

echo "Initialisiere Testtabellen..."
docker exec -ti work sysbench --db-driver=mysql \
    --mysql-host=mariadb --mysql-user=dbuser --mysql-password=12345 \
    --mysql-db=todo_app --table-size=20000 --tables=15 --threads=20 oltp_read_write prepare

echo "Starte Lese-Last-Test..."
docker exec -ti work sysbench --db-driver=mysql \
    --mysql-host=mariadb --mysql-user=dbuser --mysql-password=12345 \
    --mysql-db=todo_app --tables=15 --threads=20 --time=30 --report-interval=5 oltp_read_only run > mariadb_stresstest_read.txt

echo "Starte Schreib-Last-Test..."
docker exec -ti work sysbench --db-driver=mysql \
    --mysql-host=mariadb --mysql-user=dbuser --mysql-password=12345 \
    --mysql-db=todo_app --tables=15 --threads=20 --time=30 --report-interval=5 oltp_write_only run > mariadb_stresstest_write.txt

echo "MariaDB Stresstest abgeschlossen. Ergebnisse gespeichert in mariadb_stresstest_read.txt und mariadb_stresstest_write.txt"

