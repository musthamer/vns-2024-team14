Bericht zum Lasttest der MariaDB-Datenbank
Für unser Projekt haben wir die Performance von MariaDB getestet, um herauszufinden, wie gut die Datenbank mit vielen Lese- und Schreibanfragen umgehen kann. Dazu haben wir mit 20 parallelen Threads über 30 Sekunden hinweg sowohl Lese- als auch Schreibanfragen simuliert.

Testergebnisse
Lesetest (Read-Only)
Durchschnittliche Abfragen pro Sekunde (qps): 22.095
Durchschnittliche Transaktionen pro Sekunde (tps): 1.380
Maximale Latenz (95%): 23,95 ms
Gesamtanzahl der abgefragten Datensätze: 580.384
🔹 Bewertung:
Die Datenbank konnte stabile 22.000 Abfragen pro Sekunde verarbeiten, mit einer durchschnittlichen Latenz von 14,47 ms. Der höchste Wert bei 95% der Anfragen lag bei 23,95 ms, was für eine relationale Datenbank eine gute Performance ist.

Schreibtest (Write-Only)
Durchschnittliche Abfragen pro Sekunde (qps): 17.801
Durchschnittliche Transaktionen pro Sekunde (tps): 2.966
Maximale Latenz (95%): 11,04 ms
Gesamtanzahl der durchgeführten Schreiboperationen: 356.252
🔹 Bewertung:
Die Schreiboperationen liefen schneller als erwartet, mit einer Latenz von durchschnittlich 6,74 ms und einer maximalen Verzögerung von 11,04 ms. Die Transaktionsrate lag bei 2.966 pro Sekunde, was darauf hindeutet, dass MariaDB Schreibanfragen effizient abarbeitet.

Vergleich zwischen Lesen & Schreiben
Leseabfragen sind langsamer als Schreibabfragen, was darauf hindeutet, dass die Abfrageverarbeitung (z.B. Index-Suche) mehr Zeit benötigt.
Schreiboperationen waren fast doppelt so schnell wie Leseoperationen (6,74 ms vs. 14,47 ms Latenz).
Keine Fehler oder Verbindungsabbrüche während des Tests – die Datenbank blieb stabil.
Fazit
MariaDB zeigt gute Performance für große Datenmengen und verarbeitet sowohl Lese- als auch Schreibanfragen effizient. Der Lasttest hat bewiesen, dass die Datenbank unter hoher Last stabil bleibt und weiterhin tausende Anfragen pro Sekunde verarbeiten kann.

Empfehlung:
Falls das System in Zukunft noch höhere Lasten bewältigen muss, könnte man Optimierungen wie Caching (z.B. Redis) oder Index-Anpassungen in Betracht ziehen, um Leseabfragen weiter zu beschleunigen.
