# Dotfiles

Originally stolen from [here](https://github.com/YaN-3k/dots), and then rebased
because that repo is _b i g_ (some 81 MiB on a fresh clone as of Thu Apr 17
13:51:19 -03 2025).

# Installation Instructions

## Install dependencies

Packages from official arch repositories:

```sh
sudo pacman -Syu --needed git sxhkd picom dunst libnotify xdo xdotool       \
    xdg-user-dirs sxiv urxvt vifm tmux neomutt abook neovim zathura         \
    zathura-pdf-mupdf mpd mpc ncmpcpp alsa-utils pulseaudio pulseaudio-alsa \
    ffmpeg maim transmission-cli zsh zsh-syntax-highlighting xorg-xinit     \
    xorg-server xorg-ssetroot lsof unclutter pacman-contrib                 \
    pipewire-{alsa,jack,pulse} alsa-utils xwallpaper eza rustup
```

There are probably a few (maybe many?) other packages missing… It's not easy to
tell, because I only very rarely do a fresh install.

## Optional: Install Cargo programs (eww… Rust 🤮)

```sh
rustup default stable
cargo install broot skim alass-cli
```

## Optional: Install an AUR helper (eww… Go 🤮)

```sh
git clone https://aur.archlinux.org/yay.git /tmp/yay && (
    set -e
    cd /tmp/yay
    makepkg -si
)
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

Move these files to another directories or force checkout (delete all these
files)

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

Create user directories like ~/Music and ~/Pictures

```sh
xdg-user-dirs-update
```

Set `zsh` as default shell

```sh
chsh -s /usr/bin/zsh
```

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

## Build and install suckless programs (eww… C 🤮)

```sh
for d in ~/.config/suckless/*; do
	cd "$d"
	make clean all && sudo make install
done
```

Compile programs for the WM (eww… even more C 🤮)

```sh
cd ~/.local/bin/wm
make all
```

## Enable systemd user units (eww… systemd 🤮)

```sh
systemctl --user daemon-reload
systemctl --user enable {checkupdates,newsboat}.timer
```

Remove some files from your `$HOME`

```sh
dots update-index --assume-unchanged LICENSE README.md .gitignore
rm -rf LICENSE README.md .gitignore # You may have to run this again after a pull
```

You can revert this later with `--no-assume-unchanged` flag.

## Finished

That's it, dotfiles are ready! It is recommended to restart your computer. Now
you can use regular git commands (with tab completion):

```sh
dots status
dots pull
dots add
dots commit
dots push
```
