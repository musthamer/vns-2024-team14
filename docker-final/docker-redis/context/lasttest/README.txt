redis-bashmarktest:
Im Rahmen unseres Projekts haben wir eine Lastprüfung für die Redis-Datenbank durchgeführt, um ihre Performance zu messen. Dabei wurden 200.000 Anfragen für SET- und GET-Operationen jeweils unter Last mit 50 parallelen Clients getestet.

Ergebnisse im Detail
SET-Befehl: 200.000 Anfragen wurden in 3,26 Sekunden abgearbeitet. Das entspricht einer Durchsatzrate von 61.274 Anfragen pro Sekunde.
GET-Befehl: Hier dauerte es 3,71 Sekunden für dieselbe Anzahl an Anfragen, mit einer Durchsatzrate von 53.879 Anfragen pro Sekunde.
Latenzanalyse
Die Latenz wurde in Millisekunden gemessen. Hier sind einige wichtige Werte:

Durchschnittliche Latenz bei SET: 0,485 ms, bei GET: 0,500 ms
99.9%-Quantil (also die 0,1% langsamsten Anfragen):
SET: 2,159 ms
GET: 2,863 ms
Maximale Latenz: 2,975 ms (SET) bzw. 5,327 ms (GET)
Das bedeutet, dass selbst unter hoher Last der Großteil der Anfragen in weniger als 1 Millisekunde verarbeitet wurde. Nur ein kleiner Teil hat eine etwas höhere Verzögerung erreicht.

Bewertung der Ergebnisse
Die Tests zeigen, dass Redis unter Last eine sehr hohe Performance liefert. Die Geschwindigkeit ist auch mit vielen parallelen Anfragen stabil, und die Latenz bleibt in einem sehr niedrigen Bereich. Ein kleiner Unterschied zwischen SET und GET ist erkennbar – SET ist schneller, was logisch ist, da beim Abrufen eventuell mehr Daten aus dem Speicher geholt werden müssen.

Fazit
Redis hat sich als extrem schnelle und effiziente In-Memory-Datenbank bewiesen. Die Testergebnisse bestätigen, dass selbst unter hoher Last mit vielen parallelen Zugriffen die Performance sehr stabil und schnell bleibt. Für Anwendungen, die viele schnelle Schreib- und Lesevorgänge benötigen, ist Redis also eine sehr gute Wahl.

