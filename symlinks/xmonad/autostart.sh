#!/bin/bash

feh --randomize --bg-fill ~/.wallpaper/* &
compton &
redshift &
dunst -config ~/.config/dunst/dunstrc &
xautolock -time 10 -notify 5 -notifier '/usr/lib/xsecurelock/until_nonidle /usr/lib/xsecurelock/dimmer' -locker ~/.xmonad/scripts/lock.sh &
