#!/bin/sh

for terminal in xterm urxvt urxvt256c uxterm
do
  if [ -n "$(command -vp $terminal)" ]
  then
    $terminal
    exit
  fi
done
