# Installation Instructions
## Install dependencies
Packages from official arch repositories:
```sh
sudo pacman -S --needed git sxhkd picom dunst libnotify xdo xdotool         \
    xdg-user-dirs sxiv urxvt vifm tmux neomutt abook neovim zathura         \
    zathura-pdf-mupdf mpd mpc ncmpcpp alsa-utils pulseaudio pulseaudio-alsa \
    ffmpeg maim transmission-cli zsh zsh-syntax-highlighting xorg-xinit     \
    xorg-server xorg-ssetroot lsof unclutter pacman-contrib                 \
    pipewire-{alsa,jack,pulse} alsa-utils xwallpaper eza rustup
```

## Install Cargo programs
```sh
rustup default stable
cargo install broot skim
```

## Setup dotfiles
Download dotfiles
```sh
git clone --bare https://github.com/lucca-pellegrini/dotfiles.git ~/.config/dots-git
alias dots='git --git-dir=$HOME/.config/dots-git/ --work-tree=$HOME'
dots checkout
dots submodule update --init --recursive
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
```sh
dots checkout -f
```
Set the flag `showUntrackedFiles` to `no` for dots git repository
```sh
dots config --local status.showUntrackedFiles no
```
Install fonts
```sh
sudo fc-cache -f -v
```
Create user directories like ~/music and ~/pix
```sh
xdg-user-dirs-update
```
Set `zsh` as default shell
```sh
chsh -s /usr/bin/zsh
```
Remove some files from your `$HOME`
```sh
dots update-index --assume-unchanged LICENSE README.md .gitignore
rm -rf LICENSE README.md .gitignore
```
You can revert this later with `--no-assume-unchanged` flag.

## NeoVim's configuration
Create a symbolic link to your NeoVim configuration:
```sh
ln -s ~/.config/NvChad ~/.config/nvim/lua/custom
```

## Tmux's configuration
Install all Tmux plugins:
```sh
~/.local/share/tpm/bin/install_plugins
```

## Build and install suckless programs
```sh
for d in ~/.config/suckless/*; do
	cd "$d"
	make clean all && sudo make install
done
```

Compile programs for the WM
```sh
cd ~/.local/bin/wm
make all
```
To display colorful emoji in dmenu you need `libxft-bgra`.

## Enable systemd user units
```sh
systemctl --user daemon-reload
systemctl --user enable {checkupdates,newsboat}.timer
```

## Finished
That's it, dotfiles are ready! It is recommended to restart your computer. Now you can type `dots up` to update dotfiles or use regular git commands:
```sh
dots status
dots pull
dots add
dots commit
dots push
```
