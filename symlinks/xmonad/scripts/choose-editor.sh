#!/bin/sh

for editor in code-insiders code gvim
do
  if [ -n "$(command -vp $editor)" ]
  then
    exec $editor
    exit
  fi
done
