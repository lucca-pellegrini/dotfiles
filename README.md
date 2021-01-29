# Installation Instructions
## Install dependencies
Packages from official arch repositories:
```
$ sudo pacman -S --needed git sxhkd picom dunst libnotify xdo xdotool xdg-user-dirs sxiv urxvt vifm tmux neomutt abook neovim zathura zathura-pdf-mupdf mpd mpc ncmpcpp alsa-utils pulseaudio pulseaudio-alsa ffmpeg maim transmission-cli
```
## Setup dotfiles
Download dotfiles
```
$ git clone --bare git@gitlab.com:dull_unicorn/dotfiles.git ~/.config/dots-git
$ alias dots='git --git-dir=$HOME/.config/dots-git/ --work-tree=$HOME'
$ dots checkout
```
If it fails and shows message like this:
```
error: The following untracked working tree files would be overwritten by checkout:
    .bashrc
    .gitignore
Please move or remove them before you can switch branches.
Aborting
```
Move these files to another directories or force checkout (delete all these files)
```
$ dots checkout -f
```
Set the flag `showUntrackedFiles` to `no` for dots git repository
```
$ dots config --local status.showUntrackedFiles no
```
Install fonts
```
$ sudo fc-cache -f -v
```
Create user directories like ~/music and ~/pix
```
$ xdg-user-dirs-update
```
Set `zsh` as default shell
```
$ chsh -s /usr/bin/zsh
```
Remove `LICENSE` and `README.md` from your `$HOME`
```
$ dots update-index --assume-unchanged LICENSE README.md
$ rm -rf LICENSE README.md
```
You can revert this later with `--no-assume-unchanged` flag.
## Build and install suckless programs
Install dwm
```
$ cd ~/.config/dwm
$ sudo make clean install
```
Install st
```
$ cd ~/.config/st
$ sudo make clean install
```
Install slock
```
$ cd ~/.config/slock
$ sudo make clean install
```
Install dmenu
```
$ cd ~/.config/dmenu
$ sudo make clean install
```
Compile programs for the WM
```
$ cd ~/.local/bin/wm
$ make all
```
To display colorful emoji in dmenu you need `libxft-bgra` (see [.config/dmenu/README](.config/dmenu/README) "Requirements")<br>
## Finished
That's it, dotfiles are ready! It is recommended to restart your computer. Now you can type `dots up` to update dotfiles or use regular git commands:
```
$ dots status
$ dots pull
$ dots add
$ dots commit
$ dots push
```

