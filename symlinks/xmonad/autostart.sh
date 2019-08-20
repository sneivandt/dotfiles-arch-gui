#!/bin/sh

~/.xmonad/scripts/wallpaper.sh &
compton &
redshift &
dunst -config ~/.config/dunst/dunstrc &
xautolock -time 20 -locker ~/.xmonad/scripts/lock.sh &
