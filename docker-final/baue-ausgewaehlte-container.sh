#!/bin/bash

# Überprüfen, ob Container-Namen angegeben wurden
if [ $# -eq 0 ]; then
    echo "Verwendung: $0 <container1> <container2> ..."
    exit 1
fi

# Gehe durch alle angegebenen Container und baue sie
for container in "$@"; do
    if [ -d "docker-$container" ]; then
        echo "Baue Container: docker-$container"
        cd docker-$container
        if [ -f bin/build.sh ]; then
            bin/build.sh
        else
            echo "Build-Skript für $container wurde nicht gefunden."
        fi
        cd ..
    else
        echo "Fehler: Verzeichnis docker-$container wurde nicht gefunden."
    fi
done

echo "Die ausgewählten Container wurden erfolgreich gebaut."

