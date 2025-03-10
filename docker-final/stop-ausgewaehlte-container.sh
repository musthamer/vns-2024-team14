#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Verwendung: $0 <container1> <container2> ..."
    exit 1
fi

for container in "$@"; do
    if [ -d "docker-$container" ]; then
        echo "Stoppe Container: docker-$container"
        cd docker-$container
        if [ -f bin/stop.sh ]; then
            bin/stop.sh
        else
            echo "Stop-Skript für $container wurde nicht gefunden."
        fi
        cd ..
    else
        echo "Fehler: Verzeichnis docker-$container wurde nicht gefunden."
    fi
done

echo "Die ausgewählten Container wurden erfolgreich gestoppt."

