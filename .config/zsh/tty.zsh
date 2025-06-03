#!/usr/bin/env zsh

set -e

# Validate user via GnuPG
if [ "$(gpg -d ~/.local/share/.xinit-unlock-data.gpg 2>/dev/null | b3sum --no-names)" != '9609e7dddf9150162239b8f38ad6046f45a1cc9807ebd262e9a6dce4c4c04e88' ]; then
	echo "Error validating key. Logging out..."
	exec sleep 5
fi

SHLVL=0 # Reset shell level
exec env NOLOCK=1 startx #-- -config /etc/X11/xorg.conf.d/10-monitor.conf
