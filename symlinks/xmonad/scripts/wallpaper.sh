#!/bin/sh

curl -sSL "$(curl -sSL "https://wallhaven.cc/api/v1/search?sorting=random&atleast=$(xdpyinfo | awk '/dimensions/{print $2}')&colors=000000&q=city" | jq -r '.data[0].path')" | feh - --bg-fill || feh --randomize --bg-fill ~/.wallpaper/*
