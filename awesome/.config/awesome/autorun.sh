#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run nm-applet --indicator
run blueman-applet
run picom
run feh --bg-fill --randomize ~/.local/share/backgrounds
