#!/bin/sh

set -xe

cp "$(xdg-user-dir PICTURES)"/wallpaper /tmp/wallpaper.bak
magick /tmp/wallpaper.bak -colorspace gray /tmp/wallpaper
setbg /tmp/wallpaper && rm /tmp/wallpaper

reset()
{
	setbg /tmp/wallpaper.bak && rm /tmp/wallpaper.bak
	exit 0
}

trap reset HUP INT TERM
until ! kill -0 "$1"; do
	sleep 1
done
reset
