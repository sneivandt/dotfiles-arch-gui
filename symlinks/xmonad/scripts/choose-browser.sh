#!/bin/sh

for browser in chromium-dev chromium
do
  if [ -n "$(command -vp $browser)" ]
  then
    if [ -z "$1" ]
    then
      $browser
    else
      case $@ in
        "<iframe "*)
          $browser --app="$(echo "$@" | grep -Po '.* src="\K[^ "'']*')"
          ;;
        "https://"*)
          $browser --app="$@"
          ;;
        *)
          $browser --app="https://$@"
          ;;
      esac
    fi
    exit
  fi
done
