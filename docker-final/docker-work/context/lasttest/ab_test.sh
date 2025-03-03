#!/bin/bash

url="http://haproxy:80"
anfragen=1000
concurrent=50

echo "Starte Apache Bench Lasttest mit $anfragen Anfragen und $concurrent gleichzeitigen Verbindungen..."
ab -n $anfragen -c $concurrent $url
