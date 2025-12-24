#!/bin/sh

for terminal in urxvt urxvt256c uxterm xterm gnome-terminal
do
  if [ -n "$(command -vp $terminal)" ]
  then
    if [ "$1" = "--class" ] && { [ "$terminal" = "urxvt" ] || [ "$terminal" = "xterm" ] || [ "$terminal" = "uxterm" ] || [ "$terminal" = "urxvt256c" ]; }; then
        shift
        exec $terminal -name "$@"
    else
        exec $terminal "$@"
    fi
  fi
done
unset terminal
