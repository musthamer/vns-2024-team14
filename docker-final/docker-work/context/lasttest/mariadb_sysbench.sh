#!/bin/bash

# Konfigurationsvariablen
DB_NAME="todo_app"
DB_USER="dbuser"
DB_PASS="12345"
DB_HOST="mariadb"
DB_PORT="3306"
TABLES=20
TABLE_SIZE=10000
THREADS=20
TEST_DURATION=40  # Dauer in Sekunden


echo "🔎 Überprüfe existierende Tabellen..."
EXISTING_TABLES=$(docker exec -it mariadb mariadb -u $DB_USER -p$DB_PASS -D $DB_NAME -e "SHOW TABLES LIKE 'sbtest%';")

if [ -n "$EXISTING_TABLES" ]; then
    docker exec -i work sysbench --db-driver=mysql \
        --mysql-host=$DB_HOST --mysql-user=$DB_USER --mysql-password=$DB_PASS \
        --mysql-db=$DB_NAME --tables=$TABLES oltp_read_write cleanup
fi

docker exec -i work sysbench --db-driver=mysql \
    --mysql-host=$DB_HOST --mysql-user=$DB_USER --mysql-password=$DB_PASS \
    --mysql-db=$DB_NAME --table-size=$TABLE_SIZE --tables=$TABLES \
    --threads=$THREADS oltp_read_write prepare

docker exec -i work sysbench --db-driver=mysql \
    --mysql-host=$DB_HOST --mysql-user=$DB_USER --mysql-password=$DB_PASS \
    --mysql-db=$DB_NAME --tables=$TABLES --threads=$THREADS \
    --time=$TEST_DURATION --report-interval=10 oltp_read_only run | tee mariadb_stresstest_read.txt

docker exec -i work sysbench --db-driver=mysql \
    --mysql-host=$DB_HOST --mysql-user=$DB_USER --mysql-password=$DB_PASS \
    --mysql-db=$DB_NAME --tables=$TABLES --threads=$THREADS \
    --time=$TEST_DURATION --report-interval=10 oltp_write_only run | tee mariadb_stresstest_write.txt

read -p " Möchtest du die Sysbench-Tabellen entfernen? (y/n): " CLEANUP
if [ "$CLEANUP" == "y" ]; then
    docker exec -i work sysbench --db-driver=mysql \
        --mysql-host=$DB_HOST --mysql-user=$DB_USER --mysql-password=$DB_PASS \
        --mysql-db=$DB_NAME --tables=$TABLES oltp_read_write cleanup
else
    echo " Sysbench-Daten wurden beibehalten."
fi

echo " MariaDB-Stresstest abgeschlossen."
echo " Ergebnisse in: mariadb_stresstest_read.txt und mariadb_stresstest_write.txt"

