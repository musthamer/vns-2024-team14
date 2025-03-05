#!/bin/bash

echo 'import http from "k6/http";
import { check, sleep } from "k6";
import { textSummary } from "https://jslib.k6.io/k6-summary/0.0.1/index.js";
import grpc from "k6/net/grpc";

export let options = {
    stages: [
        { duration: "50s", target: 100 },
        { duration: "1m", target: 100 },
        { duration: "30s", target: 0 },
    ],
};

export default function () {
    let responses = [];

    let res1 = http.get("http://haproxy:80/");
    responses.push({ name: "HAProxy", response: res1 });
    check(res1, {
        "HAProxy Status 200": (r) => r.status === 200,
        "HAProxy Antwortzeit < 500ms": (r) => r.timings.duration < 500,
    });
    
    let res2 = http.get("http://apache1:80/");
    responses.push({ name: "Apache", response: res2 });
    check(res2, {
        "Apache Status 200": (r) => r.status === 200,
        "Apache Antwortzeit < 500ms": (r) => r.timings.duration < 500,
    });
    
    let res3 = http.get("http://apache2:80/");
    responses.push({ name: "Apache2", response: res3 });
    check(res3, {
        "Apache2 Status 200": (r) => r.status === 200,
        "Apache2 Antwortzeit < 500ms": (r) => r.timings.duration < 500,
    });

}

export function handleSummary(data) {
    return {
        "haproxy_result.txt": textSummary(data, { indent: "", enableColors: false }),
        "apache_result.txt": textSummary(data, { indent: "", enableColors: false }),
        "apache2_result.txt": textSummary(data, { indent: "", enableColors: false }),
    };
}

' > k6_test.js

# Führt das k6 Skript aus und speichert die Ergebnisse in separaten Dateien
echo "Starte k6 Redis & MariaDB Test für Todo-List..."
k6 run k6_test.js

