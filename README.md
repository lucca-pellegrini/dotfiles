# Dotfiles

Originally stolen from [here](https://github.com/YaN-3k/dots), and then rebased
because that repo is _b i g_ (some 81 MiB on a fresh clone as of Thu Apr 17
13:51:19 -03 2025).

# Installation Instructions

> [!NOTE]
>
> This configuration is very centered around _my_ particular tastes and
> preferences. It will most likely not serve your use case, unless you're
> willing to alter it _a lot!_ This README is kept for my own reference.

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
    xdg-desktop-portal-hyprland wtype ydotool python-pipx greetd{,-tuigreet}  \
    nerd-fonts sbctl
```

There are probably a few (maybe many?) other packages missing… It's not easy to
tell, because I only very rarely do a fresh install.

### Optional: Install Cargo programs (eww… Rust 🤮)

```sh
rustup default stable
cargo install broot skim alass-cli git-delta
```

### Install an AUR helper (eww… Go 🤮)

> [!NOTE]
>
> The AUR helper itself is not strictly necessary. I use it for convenience,
> but you may choose to build and install all packages below by hand.

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
    wpgtk gradience sunshine-git kmscon
```

### Install Python dependencies (eww… Python 🤮)

```sh
pipx install rofimoji
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

### NeoVim's configuration

Create a symbolic link to your NeoVim configuration:

```sh
ln -s ~/.config/NvChad ~/.config/nvim/lua/custom
```

### Tmux's configuration

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

### Build and install suckless programs (eww… C 🤮)

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

### Enable systemd user units (eww… systemd 🤮)

```sh
systemctl --user daemon-reload
systemctl --user enable {checkupdates,newsboat}.timer mpd sunshine
```

### Optional: set up colorscheme synchronization between HyprLand and browser

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

## Optional: system-wide configuration

### Configure and enable the Display Manager

You can edit this with `sudoedit`.

```/etc/greetd/config.toml
[terminal]
# The VT to run the greeter on. Can be "next", "current" or a number
# designating the VT.
vt = 12

# The default session, also known as the greeter.
[default_session]

command = "tuigreet --cmd Hyprland --remember-session --user-menu --time --greeting 'Access is restricted to authorized personnel only.' --width 90 --remember --asterisks --asterisks-char • --window-padding 2 --container-padding 4 --prompt-padding 0"

# The user to run the command as. The privileges this user must have depends
# on the greeter. A graphical greeter may for example require the user to b
# in the `video` group.
user = "greeter"
```

```sh
sudo systemctl enable greetd.service
```

To make sure your `~/.zprofile` is sourced when you log in, create the
following symlink:

```sh
ln -s .zprofile ~/.profile
```

### Configure and enable a nice Agetty replacement

You can edit this with `sudoedit`. Set your preferred font and keyboard layout
like this:

```/etc/kmscon/kmscon.conf
font-name=JetBrainsMono Nerd Font Mono
font-size=12
xkb-layout=br
xkb-variant=abnt2
```

Then, enable it on all virtual terminals:

```sh
sudo ln -s '/usr/lib/systemd/system/kmsconvt@.service' '/etc/systemd/system/autovt@.service'
```

### Very Optional: set up UKI, enable Secure Boot, and enroll your disk decryption keys to the TPM

> [!WARNING]
>
> This part is _very much_ optional! I like to do it because I already use
> systemd-boot, I like UKIs, and I like having fun messing around with
> computers. If you're not sure whether you can set up Secure Boot on your
> system [without bricking
> it](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot),
> if you don't understand how [the boot process
> works](https://wiki.archlinux.org/title/Arch_boot_process), or how the
> [mkinitcpio script](https://wiki.archlinux.org/title/Mkinitcpio) is
> configured, or if you have any doubts about what _anything_ in this section
> means or does, I recommend you skip it.
>
> As I stated above, this is **_my_** configuration, and I (sort of) know what
> I'm doing. Blindly copying these commands _will_ break stuff.

#### Set up your system to use a [Unified Kernel Image](https://wiki.archlinux.org/title/Unified_kernel_image)

First, copy [your Kernel
parameters](https://wiki.archlinux.org/title/Kernel_parameters) from the boot
loader configuraion into the `/etc/cmdline.d` directory, making sure to set all
relevant `rd.luks` settings. For example, if you have both root and swap under
a LUKS-encrypted LVM group, with hybernation configured and TPM2-backed auto
unlocking, you may use something like:

```/etc/cmdline.d/root.conf
cryptdevice=UUID=3a8e656f-4ccf-4881-8afc-c3b929693221:cryptlvm rd.luks.uuid=3a8e656f-4ccf-4881-8afc-c3b929693221 rd.luks.options=3a8e656f-4ccf-4881-8afc-c3b929693221=tpm2-device=auto root=/dev/lvm/root resume=/dev/lvm/swap rw
```

> [!NOTE]
>
> I actually don't know if you're supposed to keep or remove the original
> `cryptdevice=[...]` parameter when you add the `rd.luks` options. I keep it
> around just in case, because I can't be bothered to maintain two separate
> sets of parameters for UKIs and regular split setups.

Then, make sure you have all relevant hooks set in your `mkinitcpio`
configuration, like below. Notice, in particular, that I use systemd in the
initcpio, because I want TPM2-backed unlocking of the LUKS-encrypted LVM group
which contains the root and swap partition.

```/etc/mkinitcpio.conf
# ...
HOOKS=(base systemd autodetect microcode modconf kms consolefont plymouth keyboard keymap microcode sd-encrypt block lvm2 filesystems resume sd-vconsole)
# ...
```

Edit your `mkinitcpio` preset to generate a UKI. Here's an example that, in
addition, disables regular split linux/initramfs builds, and includes Arch's
builtin splash image. Note that this assumes that your EFI partition is mounted
at `/boot`, that the `/boot/EFI/Linux` directory exists, and that your boot
loader can load from it automatically (`systemd-boot` should be able to):

```/etc/mkinitcpio.d/linux.preset
# mkinitcpio preset file for the 'linux' package

ALL_config="/etc/mkinitcpio.conf"
ALL_kver="/boot/vmlinuz-linux"

PRESETS=('default' 'fallback')

default_config="/etc/mkinitcpio.conf"
# default_image="/boot/initramfs-linux.img"
default_uki="/boot/EFI/Linux/arch-linux.efi"
default_options="--splash /usr/share/systemd/bootctl/splash-arch.bmp"

fallback_config="/etc/mkinitcpio.conf"
# fallback_image="/boot/initramfs-linux-fallback.img"
fallback_uki="/boot/EFI/Linux/arch-linux-fallback.efi"
fallback_options="-S autodetect"
```

#### Set up [Secure Boot](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot)

> [!CAUTION]
>
> If you don't know how to do this yourself, **_do not follow these
> instructions_**. This is not a tutorial. You can severely damage your
> computer by messing this up. At the _very_ least, make sure you've carefully
> read **_and understood_** the [article in the Arch
> Wiki](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot).

Boot with [Secure Boot set to Setup
mode](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot#Putting_firmware_in_%22Setup_Mode%22)
and check that you've succeeded with `sbctl status`. Then, create your keys and
enroll them. Unless you know what you're doing, you should also enroll
Microsoft's keys to prevent bricking anything, as below. When you're done `sbctl
status` should indicate that the keys have been enrolled. You can then
regenerate the initramfs (or, rather, the UKI), and (just in case it doesn't
automatically, though it should), have `sbctl` sign everything manually.

```sh
sudo sbctl create-keys
sudo sbctl enroll-keys --microsoft
sudo mkinitcpio -P
sudo sbctl sign-all -g
```

Then, remove any split kernel/initramfs images that may have been left over in
`/boot`, reboot into the firmware interface, and reenable secure boot. If your
system fails to boot, congratulations: you've done something wrong. Either
perform a CMOS reset or consult your motherboard's manual.

#### Enroll TPM2 key into LUKS keyslot

We can now enroll a new key into our LUKS keyslot using the TPM2 module and
`systemd-cryptenroll`. **_Make sure_** you're booted into Secure Boot mode
before doing this — you can check with `bootctl(1)`. Here's an example,
assuming that your encrypted partition is in `/dev/nvme0n1p5`, and, more
importantly, that PCR 7 corresponds to `secure-boot-policy` in your system:

```sh
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7 /dev/nvme0n1p5
```

#### Enable automatic unlocking of your primary GnuPG key on login

> [!NOTE]
>
> This assumes that your `~/.zprofile` will be sourced when you log in. If you
> use a Display Manager, make sure it can do so. In the case of `greetd` with
> `tuigreet`, you might have to create a symlink at `~/.profile` that points to
> `~/.zprofile`.

Making sure to be in Secure Boot mode, you can store the passphrase to your
main GPG key using `systemd-creds(1)`. For example, if you already have your
agent running and your key unlocked, and the passphrase is saved in `pass`, you
can run something like this:

```sh
pass gpg/main | systemd-creds --user --tpm2-pcrs=7 encrypt - ~/.local/share/gnupg/2CAEDEBD407FA54F816C139550D458344399D7D8.cred
```

> [!WARNING]
>
> The fingerprint above must match the key you've set up as your main one in
> `.zprofile`, and it _must_ be stored in `~/.local/share/gnupg/` in this exact
> fashion. Grep for `systemd-creds` in `~/.zprofile` and read the
> implementation for details.

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
