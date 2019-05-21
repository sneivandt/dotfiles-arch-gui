#!/bin/sh

if [ "$(playerctl status 2>/dev/null)" = "Playing" ] && (playerctl metadata 'mpris:trackid' | grep -wq "spotify")
then
  metadata="$(playerctl metadata title)"
  artist="$(playerctl metadata artist)"
  if [ -n "$artist" ]
  then
    metadata="$metadata $artist"
  fi
  echo "$1 $metadata"
else
  echo ""
fi