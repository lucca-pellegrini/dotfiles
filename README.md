# Dotfiles

Originally stolen from [here](https://github.com/YaN-3k/dots), and then rebased
because that repo is _b i g_ (some 81 MiB on a fresh clone as of Thu Apr 17
13:51:19 -03 2025).

# Installation Instructions

## Install dependencies

Packages from official arch repositories:

```sh
sudo pacman -S --needed git sxhkd picom dunst libnotify xdo xdotool           \
    xdg-user-dirs sxiv vifm tmux neomutt neovim zathura zathura-pdf-poppler   \
    mpd mpc ncmpcpp alsa-utils brightnessctl                                  \
    pipewire{,-{alsa,audio,jack,pulse,session-manager,v4l2}} ffmpeg maim      \
    transmission-cli zsh zsh-syntax-highlighting xorg-xinit xorg-server       \
    xorg-xsetroot lsof unclutter pacman-contrib pipewire-{alsa,jack,pulse}    \
    alsa-utils xwallpaper eza rustup hyprland swww grim slurp wl-clipboard    \
    hypridle hyprlock mako thunar nautilus hyprpolkitagent cliphist rofi      \
    xdg-desktop-portal-hyprland
```

There are probably a few (maybe many?) other packages missing… It's not easy to
tell, because I only very rarely do a fresh install.

## Optional: Install Cargo programs (eww… Rust 🤮)

```sh
rustup default stable
cargo install broot skim alass-cli git-delta
```

## Optional: Install an AUR helper (eww… Go 🤮)

```sh
git clone https://aur.archlinux.org/yay.git /tmp/yay && (
    set -e
    cd /tmp/yay
    makepkg -si
)
```

```sh
yay -S --needed pyprland aylurs-gtk-shell-git wireplumber libgtop bluez     \
    bluez-utils networkmanager dart-sass wl-clipboard upower gvfs           \
    gtksourceview3 libsoup3 ags-hyprpanel-git python-pywal16                \
    python-pywalfox-librewolf python-haishoku deezer librewolf matugen-git  \
    wpgtk gradience
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

Set your GnuPG defauly key fingerprint at the top of the `~/.zprofile` file
(for programs like `pass`):
```sh
nvim ~/.zprofile
```
Example:
```zsh
#                            ████ ██  ██
#  ██████                   ░██░ ░░  ░██
# ░██░░░██ ██████  ██████  ██████ ██ ░██  █████
# ░██  ░██░░██░░█ ██░░░░██░░░██░ ░██ ░██ ██░░░██
# ░██████  ░██ ░ ░██   ░██  ░██  ░██ ░██░███████
# ░██░░░   ░██   ░██   ░██  ░██  ░██ ░██░██░░░░
# ░██     ░███   ░░██████   ░██  ░██ ███░░██████
# ░░      ░░░     ░░░░░░    ░░   ░░ ░░░  ░░░░░░

# Set your default GnuPG key fingerprint here
export GPG_DEFAULT_KEY='2CAEDEBD407FA54F816C139550D458344399D7D8'

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

## Optional: set up colorscheme synchronization between HyprLand and browser

First, run the browser once to initialize its profile directory and install the
extension:

```sh
librewolf 'https://addons.mozilla.org/en-US/firefox/addon/pywalfox/'
```

Then, execute the installation script before following the instructions on the
extension's page:

```sh
pywalfox --browser librewolf install
```

## Cleanup

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
