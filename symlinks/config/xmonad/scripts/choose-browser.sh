#!/bin/sh

for browser in chromium-dev chromium
do
  if [ -n "$(command -vp $browser)" ]
  then
    browser="$browser --enable-features=OverlayScrollbar"
    if [ -z "$1" ]
    then
      $browser
    else
      case $(echo "$@" | tr '[:upper:]' '[:lower:]') in
        "Prime Video")
          $browser --app="https://amazon.com/video"
          ;;
        "ChatGPT")
          $browser --app="https://chat.openai.com"
          ;;
        "Lichess")
          $browser --app="https://lichess.org"
          ;;
        "Netflix")
          $browser --app="https://netflix.com"
          ;;
        "YouTube")
          $browser --app="http://youtube.com/feed/subscriptions"
          ;;
        "<iframe "*)
          $browser --app="$(echo "$*" | grep -Po '.* src="\K[^ "'']*')"
          ;;
        "file://"*)
          $browser --app="$*"
          ;;
        "https://"*)
          $browser --app="$*"
          ;;
        *)
          $browser --app="https://$*"
          ;;
      esac
    fi
    exit
  fi
done
unset browser
