#!/bin/sh

if [ -f "$XDG_CACHE_HOME"/wallpaper ]
then
  feh --bg-fill --no-fehbg "$XDG_CACHE_HOME"/wallpaper
else
  feh --bg-fill --no-fehbg "$XDG_CONFIG_HOME"/wallpaper/default.png
fi

tmpfile="$(mktemp)"
curl -sfSL "$(curl -sSL "https://wallhaven.cc/api/v1/search?sorting=toplist&order=desc&topRange=3M&purity=100&categories=100&colors=000000&atleast=$(xdpyinfo | awk '/dimensions/{print $2}')&q=abstract dark color" | jq -r '.data[0].path')" > "$tmpfile" || exit
mv "$tmpfile" "$XDG_CACHE_HOME"/wallpaper
feh - --bg-fill --no-fehbg < "$XDG_CACHE_HOME"/wallpaper
