#!/usr/bin/env bash
REDIS_HOST="redis"
REDIS_PORT="6379"
REDIS_PASSWORD="foobared"

# Session-Überprüfung
session_id=""
if [ -n "$HTTP_COOKIE" ]; then
  session_id=$(echo "$HTTP_COOKIE" | sed -n 's/.*session_id=\([^;]*\).*/\1/p')
fi

if [ -z "$session_id" ]; then
  # Keine Session vorhanden – Umleitung zur Login-Seite
  echo "Status: 303 See Other"
  echo "Location: /index.html"
  echo "Content-type: text/html"
  echo ""
  exit 0
fi

# Prüfe, ob die Session in Redis existiert
user=$(redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" -a "$REDIS_PASSWORD" GET "session:$session_id")
if [ -z "$user" ]; then
  # Session ungültig oder abgelaufen – Umleitung zur Login-Seite
  echo "Status: 303 See Other"
  echo "Location: /index.html"
  echo "Content-type: text/html"
  echo ""
  exit 0
fi

# Falls Session vorhanden, wird die ToDo-Seite angezeigt
echo "Content-type: text/html"
echo ""
echo "<!DOCTYPE html>
<html>
<head>
  <meta charset='UTF-8'>
  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
  <title>ToDo Liste</title>

  <style>"
cat styles.css
echo "  </style>
</head>
<body>
  <div class='container'>
    <h1>ToDo Liste</h1>
<form action='/cgi-bin/vns/todo/logout.sh' method='POST' style='display:inline;'>
  <button type='submit'>Logout</button>
</form>

    <button onclick='toggleForm()'>Neue Aufgabe hinzufügen</button>

    <!-- Formular zum Hinzufügen neuer Aufgaben -->
    <div id='todo-form'>
      <div class='booking-form'>
        <h2>Neue Aufgabe hinzufügen</h2>
        <form action='../todo/addTodo.sh' method='POST' accept-charset='UTF-8'>
          <fieldset>
            <legend>Aufgabendetails</legend>
            <label>
              Aufgabe
              <input type='text' name='task' required>
            </label>
            <label>
              Details
              <textarea name='details' required></textarea>
            </label>
            <div>
              <input type='hidden' name='_gotcha' value='' style='display:none;'>
              <button type='submit' class='submit-btn'>Aufgabe hinzufügen</button>
            </div>
          </fieldset>
        </form>
      </div>
    </div>
    <!-- Tabelle der bestehenden Aufgaben -->
    <table>
      <thead>
        <tr>
          <th style='width: 5%;'>ID</th>
          <th style='width: 45%;'>Aufgabe</th>
          <th style='width: 25%;'>Erstellt am</th>
          <th style='width: 25%;'>Aktion</th>
        </tr>
      </thead>
      <tbody>"

# Redis-Caching Implementierung
REDIS_KEY="todos_cache"
todos=$(redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" -a "$REDIS_PASSWORD" get "$REDIS_KEY")

if [ -z "$todos" ]; then
  # Daten aus MariaDB holen, wenn kein Cache existiert
  todos=$(mariadb --defaults-file=my.cnf -e "SELECT id, task, details, created_at FROM todos;" -B)

  # In Redis speichern mit 5 Minuten TTL (300 Sekunden)
  redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" -a "$REDIS_PASSWORD" setex "$REDIS_KEY" 300 "$todos" >/dev/null
fi

# Ausgabe der Aufgaben als HTML-Tabelle
echo "$todos" | while read -r line; do
    # Überspringe die Kopfzeile
    if [[ "$line" != "id"* ]]; then
        # Extrahiere die Felder mit cut
        id=$(echo "$line" | cut -d$'\t' -f1)
        task=$(echo "$line" | cut -d$'\t' -f2)
        details=$(echo "$line" | cut -d$'\t' -f3)
        created_at=$(echo "$line" | cut -d$'\t' -f4)

        # Generiere die HTML-Zeile
        echo "<tr onclick=\"toggleTodo(this)\">"
        echo "<td>$id</td>"
        echo "<td>$task</td>"
        echo "<td>$created_at</td>"
        echo "<td><button onclick=\"editTodo($id); event.stopPropagation();\">Bearbeiten</button> <button onclick=\"deleteTodo($id); event.stopPropagation();\">Löschen</button></td>"
        echo "</tr>"
        echo "<tr class=\"todo-row\"><td colspan=\"4\" class=\"todo-body\">$details</td></tr>"
    fi
done

echo "      </tbody>
    </table>
  </div>
 <script>
    function toggleTodo(row) {
      var todoRows = document.querySelectorAll('.todo-row');
      var allRows = document.querySelectorAll('tr');
      var nextRow = row.nextElementSibling;
      if (nextRow && nextRow.classList.contains('todo-row')) {
        var isVisible = nextRow.style.display === 'table-row';
        todoRows.forEach(function(todoRow) {
          todoRow.style.display = 'none';
        });
        allRows.forEach(function(tr) {
          tr.style.backgroundColor = '';
        });
        if (!isVisible) {
          nextRow.style.display = 'table-row';
          row.style.backgroundColor = '#e9e9e9';
        }
      }
    }

    function toggleForm() {
      var form = document.getElementById('todo-form');
      var isVisible = form.style.display === 'block';
      if (isVisible) {
        form.style.display = 'none';
      } else {
        form.style.display = 'block';
      }
    }

    function addTodo() {
      var newTask = prompt('Neue Aufgabe eingeben:');
      var newDetails = prompt('Details der Aufgabe eingeben:');
      if (newTask && newDetails) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '../todo/addTodo.sh', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onload = function () {
          if (xhr.status === 200) {
            window.location.reload();
          } else {
            alert('Fehler beim Hinzufügen der Aufgabe.');
          }
        };
        xhr.send('task=' + encodeURIComponent(newTask) + '&details=' + encodeURIComponent(newDetails));
      }
    }

    function editTodo(id) {
      var newTask = prompt('Bearbeiten Sie die Aufgabe:');
      var newDetails = prompt('Bearbeiten Sie die Details:');
      if (newTask && newDetails) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '../todo/editTodo.sh', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onload = function () {
          if (xhr.status === 200) {
            window.location.reload();
          } else {
            alert('Aufgabe bearbeitet.');
            window.location.reload();
          }
        };
        xhr.send('id=' + id + '&task=' + encodeURIComponent(newTask) + '&details=' +
encodeURIComponent(newDetails));
      }
    }

    function deleteTodo(id) {
      if (confirm('Möchten Sie diese Aufgabe wirklich löschen?')) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '../todo/deleteTodo.sh', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onload = function () {
          if (xhr.status === 200) {
            window.location.reload();
          } else {
            alert('Aufgabe gelöscht.');
            window.location.reload();
          }
        };
        xhr.send('id=' + id);
      }
    }
 </script>
</body>
</html>"
