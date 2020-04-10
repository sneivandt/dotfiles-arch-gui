#!/bin/sh

if [ "$(playerctl status --player=spotify)" = "Playing" ]
then
  metadata="$(playerctl metadata --player=spotify --format '{{ artist }} - {{ album }} - {{ title }}')"
  case "$metadata" in
    " - "*) metadata=$(echo "$metadata" | cut -c4-)
  esac
  echo "$1 $metadata"
fi