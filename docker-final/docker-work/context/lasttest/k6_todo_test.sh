#!/bin/bash

url="http://haproxy:80/cgi-bin/vns/todo"
duration="30s"
virtual_users=50

# Erstellt eine separate k6 Skript-Datei
echo '
import http from "k6/http";
import { check, sleep } from "k6";

export let options = {
    duration: "30s",
    vus: 50,
};

export default function () {
    let getRes = http.get("http://haproxy:80/cgi-bin/vns/todo/table3.sh");
    check(getRes, { "GET Status 200": (r) => r.status == 200 });

    let postRes = http.post("http://haproxy:80/cgi-bin/vns/todo/addTodo.sh", JSON.stringify({ task: "Neuer Task", details: "Details zum Task" }), { headers: { "Content-Type": "application/x-www-form-urlencoded" }});
    check(postRes, { "POST Status 200": (r) => r.status == 200 });

    sleep(1);
}
' > /home/user/k6_todo_test.js

# Führt das k6 Skript aus
echo "Starte k6 HTTP GET und POST Test für Todo-List mit Redis Caching..."
k6 run /home/user/k6_todo_test.js
