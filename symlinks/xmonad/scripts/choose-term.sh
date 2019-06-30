#!/bin/sh

for terminal in urxvt urxvt256c uxterm xterm gnome-terminal
do
  if [ -n "$(command -vp $terminal)" ]
  then
    $terminal
    exit
  fi
done
