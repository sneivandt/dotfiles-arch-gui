#!/bin/sh

for browser in chromium-dev chromium
do
  if [ -n "$(command -vp $browser)" ]
  then
    if [ -z "$1" ]
    then
      $browser
    else
      case $(echo "$@" | tr '[:upper:]' '[:lower:]') in
        "amazon")
          $browser --app="https://amazon.com/video"
          ;;
        "netflix")
          $browser --app="https://netflix.com"
          ;;
        "outlook")
          $browser --app="https://outlook.office365.com"
          ;;
        "teams")
          $browser --app="https://teams.microsoft.com"
          ;;
        "twitch")
          $browser --app="https://twitch.tv/following/live"
          ;;
        "youtube")
          $browser --app="http://youtube.com/feed/subscriptions"
          ;;
        "<iframe "*)
          $browser --app="$(echo "$*" | grep -Po '.* src="\K[^ "'']*')"
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
