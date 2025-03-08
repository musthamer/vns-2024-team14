Redis Benchmark – Unser Erfahrungsbericht
Wir haben einen Leistungstest für Redis durchgeführt, um herauszufinden, wie gut unser Redis-Server mit vielen gleichzeitigen Anfragen umgehen kann. Dafür haben wir das Redis-Benchmark-Tool benutzt, das speziell für solche Lasttests entwickelt wurde.

Was haben wir getestet?
Der Test bestand aus zwei Teilen:

SET-Operationen (Daten in Redis speichern)
GET-Operationen (Daten aus Redis abrufen)
Wir haben 100.000 Anfragen mit 50 parallelen Clients durchgeführt, um eine möglichst hohe Last zu erzeugen.

Die Ergebnisse
SET-Operationen (Schreiben in Redis)
100.000 Anfragen in nur 1,18 Sekunden abgeschlossen
Durchschnittlicher Durchsatz: 84.388 Anfragen pro Sekunde 🚀
Durchschnittliche Latenz: 0,320 Millisekunden
95%-Perzentil-Latenz: 0,471 Millisekunden (95% aller Anfragen waren schneller als das)
Maximale Latenz: 3,399 Millisekunden
➡️ Das bedeutet: Redis kann Daten extrem schnell speichern, mit einer durchschnittlichen Verzögerung von unter einer halben Millisekunde!

GET-Operationen (Daten aus Redis abrufen)
100.000 Anfragen in 1,45 Sekunden abgeschlossen
Durchschnittlicher Durchsatz: 69.204 Anfragen pro Sekunde
Durchschnittliche Latenz: 0,377 Millisekunden
95%-Perzentil-Latenz: 0,599 Millisekunden
Maximale Latenz: 11,087 Millisekunden
➡️ Das bedeutet: Auch beim Lesen bleibt Redis unglaublich schnell, aber mit etwas höheren Latenzen als beim Schreiben.

Was bedeutet das für uns?
Diese Ergebnisse zeigen, dass Redis eine extrem leistungsfähige In-Memory-Datenbank ist, die sehr viele Anfragen in kürzester Zeit verarbeiten kann. Selbst mit 50 gleichzeitigen Clients bleiben die Antwortzeiten sehr niedrig.

Wir haben allerdings festgestellt, dass die Latenz im GET-Test etwas höher ist als im SET-Test. Das könnte verschiedene Ursachen haben:

Cache-Hits vs. Cache-Misses: Falls einige Anfragen nicht direkt im Speicher gefunden werden, dauert es etwas länger.
Netzwerkverzögerungen: Auch wenn Redis selbst schnell ist, können kleine Verzögerungen im Netzwerk auftreten.
Systembelastung: Falls andere Prozesse parallel liefen, könnte das zu kleinen Verzögerungen geführt haben.
