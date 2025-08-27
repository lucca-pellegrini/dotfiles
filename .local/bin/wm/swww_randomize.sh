#!/usr/bin/env sh
# For each display, changes the wallpaper to a randomly chosen image in
# a given directory at a set interval, and applies colors using wal.

DEFAULT_INTERVAL=3600 # In seconds

if [ $# -lt 1 ] || [ ! -d "$1" ]; then
	printf "Usage:\n\t\e[1m%s\e[0m \e[4mDIRECTORY\e[0m [\e[4mINTERVAL\e[0m]\n" "$0"
	printf "\tChanges the wallpaper to a randomly chosen image in DIRECTORY every\n\tINTERVAL seconds (or every %d seconds if unspecified)." "$DEFAULT_INTERVAL"
	exit 1
fi

if [ ! -d "$XDG_RUNTIME_DIR/swww" ]; then
	mkdir "$XDG_RUNTIME_DIR/swww"
fi

# See swww-img(1)
RESIZE_TYPE="crop"
export SWWW_TRANSITION_FPS="${SWWW_TRANSITION_FPS:-60}"
export SWWW_TRANSITION_STEP="${SWWW_TRANSITION_STEP:-2}"

while true; do
	find "$1" -type f \
	| while read -r img; do
		echo "$(</dev/urandom tr -dc a-zA-Z0-9 | head -c 8):$img"
	done \
	| sort -n | cut -d':' -f2- \
	| while read -r img; do
		for d in $(swww query | grep -Po "^[^:]+"); do # see swww-query(1)
			set -x

			# Get next random image for this display, or re-shuffle images
			# and pick again if no more unused images are remaining
			[ -z "$img" ] && if read -r img; then true; else break 2; fi
			swww img --resize "$RESIZE_TYPE" --outputs "$d" "$img"
			rm -f ~/Pictures/wallpaper
			ln -s "$img" ~/Pictures/wallpaper

			# Apply colors using wal
			wal --backend haishoku --saturate 0.5 -i "$img"

			# Apply colors using matugen
			matugen image "$img"

			# Update Hyprland window border colors
			# This part depends on how you configure Hyprland, you may need to
			# source the generated colors or apply them directly.
			# Example:
			# hyprctl set window_border_color $(cat ~/.cache/wal/colors | grep -E '^color[0-9]' | awk '{print $2}')

			pywalfox update &

			(genzathurarc > ~/.cache/wal/zathurarc) &

			unset -v img # Each image should only be used once per loop

			set +x
		done
		(sleep "${2:-$DEFAULT_INTERVAL}"; touch "$XDG_RUNTIME_DIR/swww/next") &
		sleep_pid=$!
		inotifywait -e create "$XDG_RUNTIME_DIR/swww/"
		rm "$XDG_RUNTIME_DIR/swww/next"
		kill $sleep_pid
	done
done
