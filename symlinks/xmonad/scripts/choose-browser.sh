#!/bin/bash

for browser in chromium-dev chromium
do
  if [[ -n $(command -v $browser) ]]
  then
    exec $browser
    exit
  fi
done
