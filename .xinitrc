#!/bin/sh

WM="${WM:-dwm}"
[ ! "$NOLOCK" ] && slock

# check for previously set theme
WM_THEME_FILE="${XDG_CONFIG_HOME:-"$HOME/.config"}/wm_theme"
if [ -f "$WM_THEME_FILE" ]; then
	WM_THEME="$(cat "$WM_THEME_FILE")"
else
	WM_THEME=DARK
fi
xrdb -merge -D"$WM_THEME"_THEME ~/.config/xrdb/Xdefaults # load Xdefaults

setbg &                           # set the background with the `setbg` script
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

# SSH agent
SSH_EVAL_FILE="${XDG_RUNTIME_DIR:-"$HOME/.cache"}/ssh_agent_eval"

if [ -f "$SSH_EVAL_FILE" ]; then
	eval "$(cat "$SSH_EVAL_FILE")"
fi

if [ ! -S "$SSH_AUTH_SOCK" ] \
	|| [ ! -d "/proc/$SSH_AGENT_PID" ] \
	|| ! ssh-add -l
then
	eval "$(ssh-agent | tee "$SSH_EVAL_FILE")"
fi

# WM
unset QT_STYLE_OVERRIDE
export QT_STYLE_OVERRIDE QT_QPA_PLATFORMTHEME=qt5ct
export GTK_THEME=Materia-dark-compact
/usr/lib/kdeconnectd &
xdunst &
if [ ! "$NOPICOM" ]; then
	picom &
fi
clipmenud &
dwmbar &

# set environment for user systemd units
/etc/X11/xinit/xinitrc.d/50-systemd-user.sh
systemctl --user import-environment SSH_AGENT_PID SSH_AUTH_SOCK

$X11PROGS &
exec "$WM"
