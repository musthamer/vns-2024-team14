#!/bin/bash
name="apache1"
if test "$1" =! ""; then
  name="$1"
fi
docker container run rm -f "$name"
