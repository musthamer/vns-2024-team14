MariaDB Stresstest – Unser Erfahrungsbericht
Wir haben einen Stresstest mit MariaDB durchgeführt, um zu sehen, wie gut unsere Datenbank mit vielen gleichzeitigen Anfragen klarkommt. Dafür haben wir Sysbench benutzt, ein Tool, das uns hilft, die Performance der Datenbank zu messen.

Was haben wir gemacht?
Zuerst haben wir sichergestellt, dass Sysbench auf unserem work-Container installiert ist. Dann haben wir 15 Tabellen mit jeweils 20.000 Datensätzen erstellt, um eine realistische Last auf die Datenbank zu bringen. Danach haben wir zwei Tests durchgeführt:

Lese-Last-Test: Hier haben wir geprüft, wie schnell die Datenbank auf viele gleichzeitige SELECT-Abfragen reagiert.
Schreib-Last-Test: In diesem Test haben wir viele INSERT- und UPDATE-Abfragen ausgeführt, um zu sehen, wie schnell Daten in die Datenbank geschrieben werden können.
Was kam dabei raus?
Beim Lese-Test wurden im Schnitt 18.502 Abfragen pro Sekunde ausgeführt, mit 1.156 Transaktionen pro Sekunde. Die durchschnittliche Latenz (also die Zeit, die eine Anfrage braucht) lag bei 17,28 ms. Das 95%-Perzentil lag bei 34,33 ms, das heißt, 95% der Abfragen waren schneller als das. Die höchste gemessene Verzögerung lag bei 217,96 ms.
Gut ist: Es gab keine Verbindungsfehler oder fehlerhaften Abfragen, was bedeutet, dass unsere Datenbank stabil läuft.

Beim Schreib-Test waren es 13.631 Abfragen pro Sekunde und 2.271 Transaktionen pro Sekunde. Die durchschnittliche Latenz lag hier bei 8,79 ms, das 95%-Perzentil bei 17,95 ms, und die höchste gemessene Latenz war 199,20 ms. Auch hier lief alles sauber, nur eine einzige Fehlermeldung wurde ignoriert.

Was bedeutet das für uns?
Unsere Datenbank arbeitet stabil und kann eine große Menge an Abfragen gut verarbeiten. Besonders beeindruckend ist die hohe Anzahl an Transaktionen pro Sekunde, was zeigt, dass MariaDB effizient arbeitet. Allerdings haben wir festgestellt, dass es bei hoher Last gelegentliche Latenzspitzen gibt, vor allem im Lese-Test, wo manche Abfragen über 200 ms dauerten.

Das könnte an mehreren Dingen liegen:

Vielleicht brauchen wir bessere Indizes, damit die Daten schneller gefunden werden.
Query-Caching könnte helfen, damit wiederholte Anfragen schneller beantwortet werden.
Eine bessere Lastverteilung könnte helfen, um Engpässe zu vermeiden.
