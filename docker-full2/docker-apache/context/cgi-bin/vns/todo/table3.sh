#!/usr/bin/env bash

# Session prüfen

# Session-ID aus dem Cookie extrahieren
session_id=$(echo "$HTTP_COOKIE" | sed -n 's/.*session_id=\([^;]*\).*/\1/p')

# Falls keine Session vorhanden ist, umleiten
if [ -z "$session_id" ]; then
  echo "Content-type: text/html"
  echo "Status: 303 See Other"
  echo "Location: ../login/login.sh"
  echo ""
  exit 0
fi

# E-Mail des angemeldeten Benutzers anhand der Session ermitteln
email=$(mysql --defaults-file=my.cnf -e "SELECT email FROM sessions WHERE session_id = '${session_id}';" -s -N)

# Falls keine gültige Session gefunden wurde, umleiten
if [ -z "$email" ]; then
  echo "Content-type: text/html"
  echo "Status: 303 See Other"
  echo "Location: ../login/login.sh"
  echo ""
  exit 0
fi

# Hole den Namen des Benutzers aus der users-Tabelle
name=$(mysql --defaults-file=my.cnf -e "SELECT name FROM users WHERE email = '${email}';" -s -N)

# Bestimme den benutzerspezifischen Tabellennamen anhand des E-Mail-Hash
email_hash=$(echo -n "$email" | md5sum | awk '{print $1}')
table_name="todos_${email_hash}"

# Ausgabe der HTML-Seite
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
    <h1>Willkommen, $name!</h1>
    <h1>ToDo Liste</h1>

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
            <input type='hidden' name='table' value='$table_name'>
            <div>
              <input type='hidden' name='_gotcha' value='' style='display:none;'>
              <button type='submit' class='submit-btn'>Aufgabe hinzufügen</button>
            </div>
          </fieldset>
        </form>
      </div>
    </div>
<form action="logout.sh" method="GET">
  <button type="submit">Logout</button>
</form>
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

# Aufgaben aus der benutzerspezifischen ToDo-Tabelle abrufen und als HTML-Tabelle ausgeben
mariadb --defaults-file=my.cnf -e "SELECT id, task, details, created_at FROM ${table_name};" -B | \
  awk -F'\t' 'NR>1 {
    split($4, datetime, " ");
    printf "<tr onclick=\"toggleTodo(this)\"><td>%s</td><td>%s</td><td>%s %s</td><td><button onclick=\"editTodo(%s); event.stopPropagation();\">Bearbeiten</button> <button onclick=\"deleteTodo(%s); event.stopPropagation();\">Löschen</button></td></tr><tr class=\"todo-row\"><td colspan=\"4\" class=\"todo-body\">%s</td></tr>\n", $1, $2, datetime[1], datetime[2], $1, $1, $3
  }'

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
        xhr.send('task=' + encodeURIComponent(newTask) + '&details=' + encodeURIComponent(newDetails) + '&table=' + encodeURIComponent('$table_name'));
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
        xhr.send('id=' + id + '&task=' + encodeURIComponent(newTask) + '&details=' + encodeURIComponent(newDetails) + '&table=' + encodeURIComponent('$table_name'));
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
        xhr.send('id=' + id + '&table=' + encodeURIComponent('$table_name'));
      }
    }
  </script>
</body>
</html>"

