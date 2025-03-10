# Schritt 1: Login und Cookie-Datei neu erstellen
rm -f cookies.txt  # Alte Cookie-Datei löschen
curl -s -i -c cookies.txt -d "username=admin&password=admin" \
"http://localhost:8000/cgi-bin/vns/todo/login.sh"

# Schritt 2: Anzeige der gesetzten SERVERID aus Cookie-Datei
SERVERID=$(grep 'SERVERID' cookies.txt | cut -f7)
echo "SERVERID → $SERVERID"

# Schritt 3: Mehrere Anfragen mit Session-Stickiness und Server-Anzeige
for i in {1..10}; do
  curl -s -b cookies.txt "http://localhost:8000/cgi-bin/vns/todo/table3.sh" > /dev/null
  echo "Anfrage $i → SERVERID=$SERVERID"
done

