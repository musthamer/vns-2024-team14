wrk-load: 
Bericht zum Lasttest des HAProxy Load Balancers
Für unser Projekt haben wir HAProxy getestet, um zu sehen, wie viele Anfragen er in kurzer Zeit verarbeiten kann. Dafür haben wir für 10 Sekunden eine Lastsimulation durchgeführt, bei der 4 Threads mit 50 gleichzeitigen Verbindungen Anfragen an den Load Balancer gesendet haben.

Testergebnisse
Durchschnittliche Antwortzeit: 4,47 ms
Maximale Antwortzeit: 62,61 ms
Anfragen pro Sekunde: 11.288
Gesamtzahl der Anfragen: 113.108
Gesamte Datenmenge: 208,29 MB übertragen
Fehler: 5 Lesefehler, aber keine Verbindungsabbrüche oder Timeouts
Bewertung
HAProxy hat über 11.000 Anfragen pro Sekunde verarbeitet, was eine sehr gute Leistung ist.
Die durchschnittliche Latenz von 4,47 ms zeigt, dass die Anfragen schnell beantwortet werden.
Nur 5 von über 113.000 Anfragen hatten Lesefehler, was ein sehr niedriger Fehleranteil ist.

Fazit
Der HAProxy Load Balancer hat gezeigt, dass er eine sehr hohe Last bewältigen kann, ohne große Verzögerungen oder Verbindungsabbrüche zu verursachen.

Empfehlung: Falls noch höhere Lasten erwartet werden, könnte man die Serveranzahl hinter dem Load Balancer erhöhen oder die Thread-Anzahl optimieren. Aber für den aktuellen Test zeigt HAProxy eine sehr stabile Performance.

# curl- session - haproxy 

Bericht zum Session-Stickiness Test mit HAProxy
Um zu überprüfen, ob HAProxy die Sitzungen (Sessions) korrekt weiterleitet, haben wir mehrere Tests durchgeführt. Dabei wurde geprüft, ob eine Verbindung nach der ersten Anfrage immer zum gleichen Apache-Server weitergeleitet wird.

Testmethode
Session-Cookies wurden genutzt, um zu sehen, ob die Last bei weiteren Anfragen beim gleichen Backend-Server bleibt.
Mehrere Anfragen wurden mit curl gesendet, um das Verhalten zu testen.
Ein zusätzlicher Test wurde durchgeführt, indem das Cookie SERVERID=apache1 manuell gesetzt wurde, um zu prüfen, ob HAProxy die Anfrage gezielt an denselben Server schickt.
Testergebnisse
haproxy_session_test.txt zeigt, dass die erste Verbindung erfolgreich von Apache/2.4.58 (Ubuntu) bearbeitet wurde.
haproxy_sticky_test_1.txt & haproxy_sticky_test_2.txt zeigen mehrere erfolgreiche Anfragen mit hoher Datenübertragungsrate, was darauf hindeutet, dass die Verbindungen konsistent weitergeleitet wurden.
haproxy_sticky_test_apache1.txt bestätigt, dass alle Anfragen mit SERVERID=apache1 korrekt an denselben Apache-Server geleitet wurden.
Bewertung
Der Test bestätigt, dass Session-Stickiness in HAProxy richtig funktioniert. Das bedeutet, dass Sitzungen nicht zufällig auf verschiedene Backend-Server verteilt werden, sondern an den ursprünglich gewählten Server gebunden bleiben.

Fazit
Die Session-Persistenz von HAProxy funktioniert einwandfrei, was für Anwendungen mit Session-abhängigen Daten (z. B. Login-Sitzungen, Benutzerkörbe) besonders wichtig ist.
