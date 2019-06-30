#!/bin/sh

if [ -n "$(command -vp playerctl)" ] && [ -n "$(command -vp amixer)" ]
then

  # Pause player
  STATUS=$(playerctl status 2>/dev/null)
  playerctl pause

  # Mute
  SOUND=$(amixer sget Master | grep -E -o '\[on\]' | head -n 1)
  amixer -q set Master mute 2>/dev/null

  # Lock and wait
  slock
  wait

  # Resume player
  if [ "$STATUS" = "Playing" ]
  then
    playerctl play 2>/dev/null
  fi

  # Unmute
  if [ "$SOUND" = "[on]" ]
  then
    amixer -q set Master unmute 2>/dev/null
  fi

elif [ -n "$(command -vp slock)" ]
then

  # Fallback 1
  slock

elif [ -n "$(command -vp xsecurelock)" ]
then

  # Fallback 2
  xsecurelock

fi
