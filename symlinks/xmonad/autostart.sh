#!/usr/bin/env bash

feh --randomize --bg-fill ~/.wallpaper/* &
compton &
redshift &
dunst -config ~/.config/dunst/dunstrc &
xautolock -time 10 -locker ~/.xmonad/scripts/lock.sh &
