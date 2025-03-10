#!/bin/bash

log_file="cpu_usage.csv"
echo "Sekunden,apache1,apache2,apache3,haproxy,mariadb,redis" > $log_file

start_time=$(date +%s)

for i in {1..100}; do  # 10 Minuten lang (alle 5 Sek.)
    current_time=$(date +%s)
    elapsed_time=$((current_time - start_time))

    cpu1=$(docker stats apache1 --no-stream --format "{{.CPUPerc}}" | tr -d '%' | tr ',' '.')
sleep 1
    cpu2=$(docker stats apache2 --no-stream --format "{{.CPUPerc}}" | tr -d '%' | tr ',' '.')
sleep 1   
    cpu3=$(docker stats apache3 --no-stream --format "{{.CPUPerc}}" | tr -d '%' | tr ',' '.')
sleep 1    
    cpu4=$(docker stats haproxy --no-stream --format "{{.CPUPerc}}" | tr -d '%' | tr ',' '.')
sleep 1   
    cpu5=$(docker stats mariadb --no-stream --format "{{.CPUPerc}}" | tr -d '%' | tr ',' '.')
sleep 1  
    cpu6=$(docker stats redis --no-stream --format "{{.CPUPerc}}" | tr -d '%' | tr ',' '.')
sleep 1
    echo "$elapsed_time,$cpu1,$cpu2,$cpu3,$cpu4,$cpu5,$cpu6" >> $log_file

done
