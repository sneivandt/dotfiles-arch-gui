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
        "amazon")
          $browser --app="https://amazon.com/video"
          ;;
        "chatgpt")
          $browser --app="https://chat.openai.com"
          ;;
        "lichess")
          $browser --app="https://lichess.org"
          ;;
        "netflix")
          $browser --app="https://netflix.com"
          ;;
        "outlook")
          $browser --app="https://outlook.live.com"
          ;;
        "teams")
          $browser --app="https://teams.microsoft.com"
          ;;
        "twitch")
          $browser --app="https://twitch.tv/directory/following/live"
          ;;
        "youtube")
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
