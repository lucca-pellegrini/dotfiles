#!/bin/sh
setbg &        # set the background with the `setbg` script
setxkbmap br & # set polish keyboard
xrdb ~/.config/xrdb/Xdefaults    # load ~/.Xresources
xsetroot -cursor_name left_ptr & # change the cursor shape from "x" to normal
unclutter --timeout 3 -jitter 50 --ignore-scrolling & # Remove mouse when idle
dunst &
picom &
mpd &

# bspwm
#sxhkd &
#launch_polybar &
#exec bspwm

# dwm
dwmbar &
exec dwm
