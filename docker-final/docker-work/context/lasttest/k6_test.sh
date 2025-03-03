#!/bin/bash

# Setze Testdauer und Nutzerzahl
duration="30s"
virtual_users=50
url="http://haproxy:80"
script_path="/home/user/loadtest.js"

echo "Starte k6 Lasttest für $url mit $virtual_users Benutzern für $duration..."
k6 run $script_path
