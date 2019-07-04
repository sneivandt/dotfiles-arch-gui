#!/bin/sh

vol=$(amixer sget Master | awk -F "[][]" '/dB/ { print $2 }')
echo "$1 $vol"
