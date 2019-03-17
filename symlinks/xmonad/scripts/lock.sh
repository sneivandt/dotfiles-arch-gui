#!/usr/bin/env bash

if [[ -n $(command -v playerctl) && -n $(command -v amixer) ]]
then

  # Pause player
  STATUS=$(playerctl status)
  playerctl pause

  # Mute
  SOUND=$(amixer sget Master | grep -E -o '\[on\]' | head -n 1)
  amixer -q set Master mute 2>/dev/null

  # Lock and wait
  slock
  wait

  # Resume player
  if [[ $STATUS = "Playing" ]]
  then
    playerctl play
  fi

  # Unmute
  if [[ $SOUND == "[on]" ]]
  then
    amixer -q set Master unmute 2>/dev/null
  fi

else

  # Simple lock fallback
  xsecurelock

fi
