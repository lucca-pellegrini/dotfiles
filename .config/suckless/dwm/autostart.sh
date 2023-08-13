# layouts
dwmc viewex 8 && dwmc setlayoutex 1 #&& dwmc togglebar
dwmc viewex 0 && dwmc setlayoutex 1

# programs
(cd && tabbed -r2 alacritty --embed xid -e zsh -lc tmux) &
keepassxc &
