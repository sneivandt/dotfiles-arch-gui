#!/usr/bin/env bash

player_status=$(playerctl status 2>/dev/null)
if [[ $? -eq 0 ]] && playerctl metadata 'mpris:trackid' | grep -wq "spotify"
then
  metadata=()
  artist="$(playerctl metadata artist)"
  if [[ -n $artist ]]
  then
    metadata+=("$artist")
  fi
  metadata+=("$(playerctl metadata title)")
fi

if [[ $player_status = "Playing" && ${#metadata[@]} -ne 0 ]]
then
  echo "$1 $(printf "%s - " "${metadata[@]}" | cut -d "-" -f 1-${#metadata[@]})"
else
  echo ""
fi