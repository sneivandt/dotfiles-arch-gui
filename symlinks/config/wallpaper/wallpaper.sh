#!/bin/sh

curl -sSL "$(curl -sSL "https://wallhaven.cc/api/v1/search?sorting=toplist&topRange=1m&atleast=$(xdpyinfo | awk '/dimensions/{print $2}')&q=abstract" | jq -r '.data[0].path')" | feh - --bg-fill --no-fehbg || feh --bg-fill --no-fehbg ~/.config/wallpaper/default.png
