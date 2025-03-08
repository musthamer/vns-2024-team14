#!/bin/bash

# Container-Verzeichnisse und Start-Skripte definieren
for service in mariadb apache redis haproxy work; do
    echo "Starte container: docker-$service"
    cd docker-$service
    bin/start.sh
    cd ..
done

echo "Alle containers gestartet."

