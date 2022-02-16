#!/bin/sh

WM="${WM:-dwm}"

setbg &                           # set the background with the `setbg` script
xrdb -merge -DDARK_THEME ~/.config/xrdb/Xdefaults # load Xdefaults
setxkbmap br,apl -option grp:shift_caps_toggle,compose:rctrl & # set xkb opts
xset s off -dpms                  # do not blank screen automatically
unclutter --timeout 3 -jitter 50 --ignore-scrolling & # Remove mouse when idle

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
/usr/lib/kdeconnectd &
xdunst &
picom &
clipmenud &
dwmbar &

# set environment for user systemd units
/etc/X11/xinit/xinitrc.d/50-systemd-user.sh
systemctl --user import-environment SSH_AGENT_PID SSH_AUTH_SOCK

exec "$WM"
