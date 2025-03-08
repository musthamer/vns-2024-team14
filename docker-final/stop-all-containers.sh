#!/bin/bash

# Container-Verzeichnisse und Stop-Skripte definieren
for service in mariadb apache redis haproxy work; do
    echo "Stopping container: docker-$service"
    cd docker-$service
    if [ -f bin/stop.sh ]; then
        bin/stop.sh
    else
        echo "nicht gefunden $service"
    fi
    cd ..
done


