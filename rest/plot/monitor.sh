#!/bin/bash

# CSV-Datei vorbereiten
echo "Zeit,CPU_Apache1,CPU_Apache2,CPU_Work,CPU_Haproxy,CPU_Redis,CPU_MariaDB,RAM_Apache1,RAM_Apache2,RAM_Work,RAM_Haproxy,RAM_Redis,RAM_MariaDB" > performance_data.csv

for ((i=0; i<1000000; i++)); do  # 1440 Durchläufe für 8 Stunden bei 20-Sekunden-Intervallen
    ZEIT=$(date +"%H:%M:%S")

    # CPU- und RAM-Nutzung direkt aus Docker Stats abrufen
    CPU_APACHE1=$(docker stats --no-stream apache1 | grep apache1 | sed -E 's/ +/ /g' | cut -d' ' -f3 | tr -d '%')
    CPU_APACHE2=$(docker stats --no-stream apache2 | grep apache2 | sed -E 's/ +/ /g' | cut -d' ' -f3 | tr -d '%')
    CPU_WORK=$(docker stats --no-stream work | grep work | sed -E 's/ +/ /g' | cut -d' ' -f3 | tr -d '%')
    CPU_HAPROXY=$(docker stats --no-stream haproxy | grep haproxy | sed -E 's/ +/ /g' | cut -d' ' -f3 | tr -d '%')
    CPU_REDIS=$(docker stats --no-stream redis | grep redis | sed -E 's/ +/ /g' | cut -d' ' -f3 | tr -d '%')
    CPU_MARIADB=$(docker stats --no-stream mariadb | grep mariadb | sed -E 's/ +/ /g' | cut -d' ' -f3 | tr -d '%')

    RAM_APACHE1=$(docker stats --no-stream apache1 | grep apache1 | sed -E 's/ +/ /g' | cut -d' ' -f4)
    RAM_APACHE2=$(docker stats --no-stream apache2 | grep apache2 | sed -E 's/ +/ /g' | cut -d' ' -f4)
    RAM_WORK=$(docker stats --no-stream work | grep work | sed -E 's/ +/ /g' | cut -d' ' -f4)
    RAM_HAPROXY=$(docker stats --no-stream haproxy | grep haproxy | sed -E 's/ +/ /g' | cut -d' ' -f4)
    RAM_REDIS=$(docker stats --no-stream redis | grep redis | sed -E 's/ +/ /g' | cut -d' ' -f4)
    RAM_MARIADB=$(docker stats --no-stream mariadb | grep mariadb | sed -E 's/ +/ /g' | cut -d' ' -f4)

    # Daten in CSV speichern
    echo "$ZEIT,$CPU_APACHE1,$CPU_APACHE2,$CPU_WORK,$CPU_HAPROXY,$CPU_REDIS,$CPU_MARIADB,$RAM_APACHE1,$RAM_APACHE2,$RAM_WORK,$RAM_HAPROXY,$RAM_REDIS,$RAM_MARIADB" >> performance_data.csv

#    sleep 5  # Alle 20 Sekunden Daten sammeln
done

