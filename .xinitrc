#!/bin/sh

WM="${WM:-dwm}"

setbg &                           # set the background with the `setbg` script
xrdb ~/.config/xrdb/Xdefaults     # load ~/.Xresources
setxkbmap br,apl -option grp:shift_caps_toggle,compose:rctrl & # set xkb opts
xsetroot -cursor_name left_ptr &  # change the cursor shape from "x" to normal
xset s off -dpms                  # do not blank screen automatically
unclutter --timeout 3 -jitter 50 --ignore-scrolling & # Remove mouse when idle
/usr/lib/kdeconnectd &
dunst &
picom &

# synaptics touchpad options
synclient TapButton1=1
synclient TapButton2=3
synclient TapButton3=2
synclient HorizTwoFingerScroll=1
synclient CircularScrolling=1 # For greater speed and precision
synclient VertScrollDelta=-47 # Because it makes more sense
synclient HorizScrollDelta=-47

# WM
export GTK_THEME=Materia-dark-compact
export QT_STYLE_OVERRIDE=kvantum-dark
eval "$(ssh-agent)"
clipmenud &
dwmbar &

# set environment for user systemd units
/etc/X11/xinit/xinitrc.d/50-systemd-user.sh
systemctl --user import-environment SSH_AGENT_PID SSH_AUTH_SOCK

exec "$WM"
