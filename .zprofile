#                            ████ ██  ██
#  ██████                   ░██░ ░░  ░██
# ░██░░░██ ██████  ██████  ██████ ██ ░██  █████
# ░██  ░██░░██░░█ ██░░░░██░░░██░ ░██ ░██ ██░░░██
# ░██████  ░██ ░ ░██   ░██  ░██  ░██ ░██░███████
# ░██░░░   ░██   ░██   ░██  ░██  ░██ ░██░██░░░░
# ░██     ░███   ░░██████   ░██  ░██ ███░░██████
# ░░      ░░░     ░░░░░░    ░░   ░░ ░░░  ░░░░░░

# Adds `~/.local/bin` to $PATH
export PATH="$HOME/.local/share/cargo/bin/:$HOME/.local/share/gem/ruby/3.0.0/bin:$HOME/.config/fzf/fzf/bin/:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//'):/usr/lib/ccache/bin:$PATH"

# Default programs:
export EDITOR="nvim"
export TERMINAL="st"
export READER="zathura"
export FILE="vifm"
#export BROWSER="surf"
export BROWSER="librewolf"
export DMENU_RUN="dmenu_run -w 245 -x 10 -y 30 -i"
export DMENU="dmenu -w 245 -x 10 -y 30 -i"

# ~/ Clean-up:
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export INPUTRC="$ZDOTDIR/inputrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export LESSHISTFILE="-"
export LYNX_CFG="$XDG_CONFIG_HOME/lynx/lynx.cfg"
export LYNX_LSS="$XDG_CONFIG_HOME/lynx/lynx.lss"
export XCOMPOSEFILE="$XDG_CONFIG_HOME/XCompose"
export XCOMPOSECACHE="${XDG_CACHE_HOME:-"$HOME/.cache"}/compose-cache"

# Sudo
export SUDO_PROMPT="$(printf "\033[1;36m")[sudo]$(printf "\033[0m") password for %p: "
export SUDO_ASKPASS="$HOME/.local/bin/etc/dmenupass"

# Less
export LESS=-R
export LESS_TERMCAP_mb="$(printf '\033[1;36m')"
export LESS_TERMCAP_md="$(printf '\033[1;36m')"
export LESS_TERMCAP_me="$(printf '\033[0m')"
export LESS_TERMCAP_se="$(printf '\033[0m')"
export LESS_TERMCAP_so="$(printf "\033[0;46;30m")"
export LESS_TERMCAP_ue="$(printf '\033[0m')"
export LESS_TERMCAP_us="$(printf '\033[0;92m')"

# Fzf
export FZF_DEFAULT_OPTS='
--color fg:7,hl:4,fg+:15,bg+:0,hl+:3
--color pointer:1,info:8,spinner:3,header:8,prompt:8,marker:8
--info=inline
--height 60%
--reverse
--preview "( [ -d {} ] && ls -Fh --color=always {} ) || ( [ -f {} ] && bat -pp --color always {} )"
'

export FZF_DEFAULT_COMMAND="find . -mindepth 1 2>/dev/null"
export FZF_ALT_C_COMMAND='find . -mindepth 1 -type d 2>/dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Other program settings
export SXHKD_SHELL="/bin/sh"
export MPD_HOST="$XDG_CONFIG_HOME/mpd/socket"
export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org/"
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=44;30;1:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
export EZA_ICONS_AUTO=1

[ ! -f ~/.config/zsh/shortcutrc ] && shortcuts >/dev/null 2>&1
[ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh

# Start SSH Agent
SSH_EVAL_FILE="${XDG_RUNTIME_DIR:-"$HOME/.cache"}/ssh_agent_eval"

if [ -f "$SSH_EVAL_FILE" ]; then
	eval "$(cat "$SSH_EVAL_FILE")"
fi

if [ ! -S "$SSH_AUTH_SOCK" ] \
	|| [ ! -d "/proc/$SSH_AGENT_PID" ] \
	|| [ "$(ssh-add -l > /dev/null 2>&1; echo $?)" -eq 2 ]
then
	eval "$(ssh-agent | grep -v echo | tee "$SSH_EVAL_FILE")"
fi

# Start graphical server on tty1 if not already running.
if [ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null; then
	exec ~/.config/zsh/tty.zsh
fi
