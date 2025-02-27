#!/bin/bash

# Redis-Server starten
echo "Starte Redis-Server..."
chown redis: /etc/redis/redis.conf
sudo -u redis redis-server /etc/redis/redis.conf --daemonize no

# Container am Leben halten
echo "Redis-Container läuft..."
while true; do
  sleep 10
done
