#!/bin/sh

if [ -n "$(command -vp playerctl)" ] && [ -n "$(command -vp amixer)" ]
then

  # Pause player
  STATUS=$(playerctl status 2>/dev/null)
  playerctl pause 2>/dev/null

  # Mute
  SOUND=$(amixer sget Master | grep -E -o "\[on\]" | head -n 1)
  amixer -q sset Master mute 2>/dev/null

  # Lock and wait
  slock
  wait

  # Unmute
  if [ "$SOUND" = "[on]" ]
  then
    for channel in $(amixer scontrols | awk -F "'" '{print $2}')
    do
      amixer -q sset "$channel" unmute 2>/dev/null
    done
    unset channel
  fi

  # Resume player
  if [ "$STATUS" = "Playing" ]
  then
    playerctl play 2>/dev/null
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
