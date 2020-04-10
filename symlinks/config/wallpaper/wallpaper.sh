#!/bin/sh

curl -sSL "$(curl -sSL "https://wallhaven.cc/api/v1/search?sorting=toplist&order=desc&topRange=6M&purity=100&categories=100&colors=000000&atleast=$(xdpyinfo | awk '/dimensions/{print $2}')&q=abstract" | jq -r '.data[0].path')" | feh - --bg-fill --no-fehbg || feh --bg-fill --no-fehbg ~/.config/wallpaper/default.png
