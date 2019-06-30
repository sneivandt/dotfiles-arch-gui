#!/bin/sh

if [ "$(playerctl status --player=spotify)" = "Playing" ]
then
  echo "$1 $(playerctl metadata --player=spotify --format '{{ artist }} - {{ album }} - {{ title }}')"
fi