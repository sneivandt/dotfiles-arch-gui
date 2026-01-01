#!/bin/sh

# Unmute and set Master volume
amixer -q sset Master unmute
amixer -q sset Master 80%

# Unmute all channels
if command -v amixer >/dev/null 2>&1; then
  for channel in $(amixer scontrols | awk -F "'" '{print $2}'); do
    amixer -q sset "$channel" unmute 2>/dev/null || true
  done
fi
