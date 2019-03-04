#!/bin/bash

for terminal in urxvt urxvt256c uxterm xterm gnome-terminal
do
  if [[ -n $(command -v $terminal) ]]
  then
    exec $terminal
    exit
  fi
done
