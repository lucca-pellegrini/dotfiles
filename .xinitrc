#!/bin/sh

WM="${WM:-dwm}"

# check for previously set theme
WM_THEME_FILE="${XDG_CONFIG_HOME:-"$HOME/.config"}/wm_theme"
if [ -f "$WM_THEME_FILE" ]; then
	WM_THEME="$(cat "$WM_THEME_FILE")"
else
	WM_THEME=FALCON
fi
xrdb -merge -D"$WM_THEME"_THEME ~/.config/xrdb/Xdefaults # load Xdefaults
xrdb -merge -D"$WM_THEME"_THEME ~/.config/xrdb/themes/"$(printf %s "$WM_THEME" | tr '[:upper:]' '[:lower:]')"

setbg &                           # set the background with the `setbg` script
setxkbmap br,apl -option grp:shift_caps_toggle,compose:lwin-altgr & # set xkb opts
xset s off -dpms &                # do not blank screen automatically
unclutter --timeout 3 -jitter 50 --ignore-scrolling & # Remove mouse when idle
warpinator -a & # Autostart warpinator if configured
chkboot-desktopalert & # Warn about changes to /boot
[ -f ~/.config/Xmodmap ] && xmodmap ~/.config/Xmodmap &  # load any additional custom key options
[ ! "$NOLOCK" ] && slock

# synaptics touchpad options
(
	synclient TapButton1=1
	synclient TapButton2=3
	synclient TapButton3=2
	synclient HorizTwoFingerScroll=1
	synclient CircularScrolling=1 # For greater speed and precision
	synclient VertScrollDelta=-47 # Because it makes more sense
	synclient HorizScrollDelta=-47
) &

# Fix for JavaFX apps, which assumes most WMs are reparenting
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit

# Fix for Calibre
export CALIBRE_USE_SYSTEM_THEME=1

# WM
unset QT_STYLE_OVERRIDE
export QT_STYLE_OVERRIDE QT_QPA_PLATFORMTHEME=qt5ct
export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
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
systemctl --user restart --no-block sunshine

# Uncomment the lines below to start Gnome
# export XDG_SESSION_TYPE=x11
# export GDK_BACKEND=x11
# exec gnome-session

$X11PROGS &
exec "$WM"
