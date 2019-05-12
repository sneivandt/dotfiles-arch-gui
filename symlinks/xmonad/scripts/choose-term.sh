#!/usr/bin/env bash

for terminal in urxvt urxvt256c uxterm xterm gnome-terminal
do
  if [[ -n $(command -vp $terminal) ]]
  then
    exec $terminal
    exit
  fi
done
