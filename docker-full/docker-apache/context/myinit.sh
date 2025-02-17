#!/bin/bash 
log=/docker.log
echo apache starting >> $log

apache2ctl -D FOREGROUN


