#!/bin/bash

# Überprüfen, ob Container-Namen angegeben wurden
if [ $# -eq 0 ]; then
    echo "Verwendung: $0 <container1> <container2> ..."
    exit 1
fi

# Gehe durch alle angegebenen Container und starte sie
for container in "$@"; do
    if [ -d "docker-$container" ]; then
        echo "Starte Container: docker-$container"
        cd docker-$container
        if [ -f bin/start.sh ]; then
            bin/start.sh
        else
            echo "Start-Skript für $container wurde nicht gefunden."
        fi
        cd ..
    else
        echo "Fehler: Verzeichnis docker-$container wurde nicht gefunden."
    fi
done

echo "Die ausgewählten Container wurden erfolgreich gestartet."

