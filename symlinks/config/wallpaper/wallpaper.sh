#!/bin/sh

if [ -f ~/.cache/wallpaper ]
then
  feh --bg-fill --no-fehbg ~/.cache/wallpaper
else
  feh --bg-fill --no-fehbg ~/.config/wallpaper/default.png
fi

tmpfile="$(mktemp)"
curl -sfSL "$(curl -sSL "https://wallhaven.cc/api/v1/search?sorting=toplist&order=desc&topRange=6M&purity=100&categories=100&colors=000000&atleast=$(xdpyinfo | awk '/dimensions/{print $2}')&q=abstract" | jq -r '.data[0].path')" > "$tmpfile" || exit
mv "$tmpfile" ~/.cache/wallpaper
feh - --bg-fill --no-fehbg < ~/.cache/wallpaper