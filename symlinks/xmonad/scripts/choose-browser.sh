#!/bin/sh

for browser in chromium-dev chromium
do
  if [ -n "$(command -vp $browser)" ]
  then
    if [ -z "$1" ]
    then
      exec $browser
    else
      exec $browser --app="https://$1"
    fi
    exit
  fi
done
