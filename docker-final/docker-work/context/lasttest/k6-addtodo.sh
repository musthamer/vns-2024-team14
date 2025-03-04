#!/bin/bash

echo 'import http from "k6/http";
import { check, sleep } from "k6";

export let options = {
    stages: [
        { duration: "20s", target: 20 },  // 20 gleichzeitige Nutzer
        { duration: "40s", target: 50 },  // Skalierung auf 50 Nutzer
        { duration: "20s", target: 0 },   // Abbau der Last
    ],
};

export default function () {
    let createTodoPayload = "task=K6 Test Task&details=Dies ist eine Testaufgabe mit K6.";
    let headers = { "Content-Type": "application/x-www-form-urlencoded" };

    let createRes = http.post("http://haproxy:80/cgi-bin/vns/todo/addTodo.sh", createTodoPayload, { headers, redirects: 0 });

    check(createRes, {
        "Aufgabe erfolgreich hinzugefügt": (r) => r.status === 303,
    });

    let getTodosRes = http.get("http://haproxy:80/cgi-bin/vns/todo/table3.sh");
    check(getTodosRes, {
        "ToDo-Liste geladen": (r) => r.status === 200,
    });
    
    sleep(1);
}
' > k6_todo_test.js

# Führt das k6 Skript für ToDo-Tests aus und speichert das Ergebnis in einer Datei
echo "Starte k6 ToDo-List-Test..."
k6 run k6_todo_test.js > k6_addtodo_results.txt

