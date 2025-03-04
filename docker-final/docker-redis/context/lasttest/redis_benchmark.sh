#!/bin/bash
# Redis Lasttest (SET und GET)
# Führe diesen Test innerhalb des Redis-Containers aus

echo "Starte Redis Lasttest..."
docker exec -ti redis redis-benchmark -p 6379 -a foobared -t set,get -n 200000 > redis_benchmark_results.txt

echo "Test abgeschlossen. Ergebnisse gespeichert in redis_benchmark_results.txt"
