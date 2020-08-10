#!/bin/sh

for editor in code-insiders code gvim
do
  if [ -n "$(command -vp $editor)" ]
  then
    $editor
    exit
  fi
done
unset editor
