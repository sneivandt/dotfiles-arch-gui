#!/usr/bin/env bash

for browser in chromium-dev chromium
do
  if [[ -n $(command -v $browser) ]]
  then
    if [[ -z $1 ]]
    then
      exec $browser
    else
      exec $browser --app="https://$1"
    fi
    exit
  fi
done
