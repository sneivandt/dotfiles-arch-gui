#!/bin/sh

if [ "$(playerctl status --player=spotify)" = "Playing" ]
then
  metadata="$(playerctl metadata --player=spotify --format '{{ artist }} - {{ album }} - {{ title }}')"
  case "$metadata" in
    " - "*) metadata=$(echo "$metadata" | cut -c4-)
  esac
  echo "$1 $metadata" | awk -v len=128 '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }'
fi