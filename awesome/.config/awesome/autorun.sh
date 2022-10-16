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
run kmix
run ~/.config/polybar/launch.sh
run feh --bg-fill --randomize ~/.local/share/backgrounds
