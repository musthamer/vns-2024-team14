#!/bin/bash
log=/docker.log
echo starte >> $log

trap onexit SIGTERM

function onexit {
  #shutdown ...
  echo shutting down >> $log

  read pid < /run/apache2/apache2.pid
  apachectl stop
  while test "$pid" != "" && ps -p $pid >/dev/null; do
    echo wait for shutdown of pid $pid >> $log
    sleep 0.01
  done

  exit
}
# start services
apachectl start

while true; do
        echo "$(date +%FT%T) ping" >> $log
  read -t 1 </dev/fd/1
done
