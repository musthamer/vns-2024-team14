#!/bin/bash

url="http://haproxy:80/cgi-bin/vns/todo/table3.sh"
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
    let firstRequest = http.get("http://haproxy:80/cgi-bin/vns/todo/table3.sh");
    check(firstRequest, { "First GET Status 200": (r) => r.status == 200 });

    sleep(2); // Warten, um sicherzustellen, dass der Cache aktiv ist

    let cachedRequest = http.get("http://haproxy:80/cgi-bin/vns/todo/table3.sh");
    check(cachedRequest, { "Cached GET Status 200": (r) => r.status == 200 });

    if (firstRequest.timings.duration > cachedRequest.timings.duration) {
        console.log("Cache funktioniert, zweite Anfrage war schneller!");
    } else {
        console.log("Cache funktioniert nicht optimal.");
    }

    sleep(1);
}
' > /home/user/k6_redis_cache_test.js

# Führt das k6 Skript aus
echo "Starte k6 Redis Caching Test für Todo-List..."
k6 run /home/user/k6_redis_cache_test.js
