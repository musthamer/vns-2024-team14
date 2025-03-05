#!/bin/bash

echo 'import http from "k6/http";
import { check, sleep } from "k6";

export let options = {
    stages: [
        { duration: "30s", target: 50 },
        { duration: "1m", target: 100 },
        { duration: "30s", target: 0 },
    ],  
};

export default function () {
    let loginPayload = "username=admin&password=admin";
    let headers = { "Content-Type": "application/x-www-form-urlencoded" };

    let loginRes = http.post("http://haproxy:80/cgi-bin/vns/todo/login.sh", loginPayload, { headers });

    check(loginRes, {
        "Login erfolgreich": (r) => r.status === 303,
        "Session-Cookie gesetzt": (r) => r.headers["Set-Cookie"] && r.headers["Set-Cookie"].includes("session_id"),
    });

    let cookies = loginRes.headers["Set-Cookie"];

    if (cookies) {
        let todoRes = http.get("http://haproxy:80/cgi-bin/vns/todo/table3.sh", { headers: { "Cookie": cookies } });
        check(todoRes, {
            "ToDo-Seite geladen": (r) => r.status === 200,
        });
    }

    sleep(1);
}
' > k6_login_test.js

# Führt das k6 Skript für Login-Tests aus und speichert das Ergebnis in einer Datei
echo "Starte k6 Login-Test für Todo-List..."
k6 run k6_login_test.js > k6_login_results.txt
