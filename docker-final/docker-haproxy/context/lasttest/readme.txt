HAProxy Session Stickiness – Unser Erfahrungsbericht
Wir haben einen Session-Stickiness-Test mit HAProxy durchgeführt, um zu überprüfen, ob unsere Lastverteilung korrekt arbeitet und Nutzeranfragen an denselben Server geleitet werden, solange die Session aktiv bleibt.

Was haben wir getestet?
Session-Stickiness: Prüft, ob Anfragen desselben Clients immer an denselben Backend-Server weitergeleitet werden.
Mehrere aufeinanderfolgende Anfragen: Wir haben 10 Anfragen hintereinander gesendet und überprüft, ob sie am selben Server ankommen.
Manuelle Cookie-Setzung: Um zu testen, ob das HAProxy-Routing korrekt arbeitet, haben wir explizit einen bestimmten Server (apache1) vorgegeben.
Der Testablauf
Erste Anfrage mit Cookie-Speicherung:

Der erste Request wurde mit dem HAProxy-Load-Balancer durchgeführt.
Das erhaltene Session-Cookie wurde gespeichert.
Mehrere Anfragen zur Überprüfung:

Wir haben zehn weitere Anfragen gesendet, um zu testen, ob HAProxy die Requests an denselben Server weiterleitet.
Manuelle Cookie-Setzung:

Hier haben wir einen bestimmten Server (apache1) als Ziel angegeben, um zu sehen, ob HAProxy die Stickiness korrekt erkennt.
Die Ergebnisse
HAProxy leitet wiederholte Anfragen an denselben Server weiter.
Die Serverantwort zeigt Apache als Backend, was bestätigt, dass die Stickiness funktioniert.
Die Cookie-basierte Steuerung über "SERVERID=apache1" hat ebenfalls korrekt funktioniert.
Die Antwortzeiten waren stabil und zeigten eine konsistente Geschwindigkeit.
Was bedeutet das für uns?
Unser HAProxy-Setup mit Session-Stickiness funktioniert wie erwartet. Das bedeutet, dass:
✅ Benutzeranfragen während einer Session nicht zwischen den Backend-Servern hin- und herwechseln.
✅ Die Cookie-basierte Steuerung von HAProxy zuverlässig funktioniert.
✅ Unser Load-Balancer eine gute Performance liefert und die Antwortzeiten stabil bleiben.


............
Wir haben einen Load-Balancing Test mit HAProxy durchgeführt, um die Leistungsfähigkeit und Stabilität unseres Systems zu überprüfen. Der Test wurde mit dem Tool wrk gemacht, das speziell für HTTP-Lasttests geeignet ist. Für den Test haben wir 4 Threads und 50 gleichzeitige Verbindungen verwendet, und der Test lief über einen Zeitraum von 10 Sekunden. Getestet wurde die Instanz unter der URL http://haproxy:80. Während des Tests wurden insgesamt 114.414 Anfragen erfolgreich verarbeitet. Die durchschnittliche Latenz lag bei 4,66 Millisekunden, was ein sehr guter Wert ist. Die maximale Latenz betrug 62,49 Millisekunden, was ebenfalls noch im akzeptablen Bereich liegt. Pro Sekunde wurden im Schnitt 11.418,83 Anfragen bearbeitet und die Übertragungsrate lag bei 21,03 MB/s. Es gab während des Tests insgesamt 14 Lese-Fehler, was zwar nicht ideal ist, aber angesichts der Gesamtanzahl an Anfragen einen sehr geringen Anteil ausmacht. Verbindungsfehler, Schreibfehler oder Timeout-Probleme traten nicht auf. Das zeigt, dass unser HAProxy-Setup stabil läuft und mit einer hohen Anzahl von Anfragen gut zurechtkommt. Die Ergebnisse sprechen insgesamt für eine starke und verlässliche Performance, was für uns bedeutet, dass wir mit unserer aktuellen Konfiguration auf einem sehr guten Stand sind. Dennoch sollten wir die Lese-Fehler im Auge behalten und gegebenenfalls Maßnahmen ergreifen, um diese weiter zu minimieren. Hier könnten Optimierungen in der Netzwerkverbindung hilfreich sein. Außerdem könnte es sinnvoll sein, die Anzahl der Threads und gleichzeitigen Verbindungen bei zukünftigen Tests zu erhöhen, um zu sehen, wie unser System bei noch stärkerer Belastung reagiert. Insgesamt können wir mit den Testergebnissen sehr zufrieden sein, da unser System die Anforderungen gut gemeistert hat und wir jetzt ein solides Fundament haben, auf dem wir weiter aufbauen können.

Wir haben einen weiteren Load-Balancing Test mit HAProxy durchgeführt, um unser System unter noch stärkerer Belastung zu testen. Diesmal haben wir die Testbedingungen angepasst und die Anzahl der Threads auf 10 sowie die gleichzeitigen Verbindungen auf 150 erhöht. Der Test lief insgesamt 30 Sekunden und wurde mit dem Tool wrk durchgeführt, das speziell für HTTP-Lasttests geeignet ist. In dieser Zeit wurden insgesamt 317.129 Anfragen verarbeitet und dabei 584,01 MB an Daten übertragen. Die durchschnittliche Latenz betrug dabei 15,24 Millisekunden, wobei die höchste gemessene Latenz bei 249,78 Millisekunden lag. Die Anzahl der Anfragen pro Sekunde belief sich auf 10.922,29, was zeigt, dass unser System auch bei einer höheren Last noch eine beeindruckende Performance liefern kann. Es traten während des Tests allerdings 5.618 Lese-Fehler und 150 Timeouts auf. Obwohl dies im Vergleich zur Gesamtanzahl an Anfragen nur einen kleinen Prozentsatz ausmacht, deutet es darauf hin, dass das System unter dieser erhöhten Last an seine Grenzen stößt.

Für uns bedeutet das, dass unser HAProxy-Setup auch bei höherer Last grundsätzlich stabil läuft und eine gute Performance bietet. Die durchschnittliche Latenz von 15,24 ms ist zwar etwas höher als beim vorherigen Test, liegt aber noch im akzeptablen Bereich. Die gestiegene Anzahl an Lese-Fehlern und Timeouts zeigt jedoch, dass hier noch Optimierungspotenzial besteht. Mögliche Maßnahmen zur Verbesserung könnten eine weitere Feinjustierung der Konfiguration von HAProxy sein, z.B. durch das Anpassen von Timeouts oder der Erhöhung der maximalen gleichzeitigen Verbindungen. Auch ein genaueres Monitoring des Backend-Systems könnte helfen, Engpässe oder Flaschenhälse zu identifizieren.

Insgesamt sind wir mit der Leistung von HAProxy zufrieden, da das System auch unter erhöhter Last stabil arbeitet und eine große Menge an Anfragen in kurzer Zeit verarbeiten kann. Die vorhandenen Lese-Fehler und Timeouts sind jedoch ein Hinweis darauf, dass wir unser System weiter optimieren sollten, um zukünftige Lastspitzen noch besser bewältigen zu können.
