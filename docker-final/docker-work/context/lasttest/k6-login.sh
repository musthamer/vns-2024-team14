#!/bin/bash

echo 'import http from "k6/http";
import { check, sleep } from 'k6';

export let options = {
    stages: [
        { duration: '30s', target: 5 },   // 5 gleichzeitige Benutzer
        { duration: '30s', target: 10 },  // 10 gleichzeitige Benutzer
        { duration: '30s', target: 15 },  // 15 gleichzeitige Benutzer
        { duration: '30s', target: 20 },  // 20 gleichzeitige Benutzer
    ],
};

export default function () {
    let url = "http://haproxy:80/cgi-bin/vns/todo/login.sh";

    let payload = "username=admin&password=admin";

    let params = {
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        }
    };

    let res = http.post(url, payload, params);

    check(res, {
        'Login erfolgreich': (r) => r.status === 200 || r.status === 303,
    });

    sleep(1);
}

' > k6_login_test.js

# Führt das k6 Skript für Login-Tests aus und speichert das Ergebnis in einer Datei
echo "Starte k6 Login-Test für Todo-List..."
k6 run k6_login_test.js > k6_login_results.txt
