#                 ██
#                ░██
#  ██████  ██████░██
# ░░░░██  ██░░░░ ░██████
#    ██  ░░█████ ░██░░░██
#   ██    ░░░░░██░██  ░██
#  ██████ ██████ ░██  ░██
# ░░░░░░ ░░░░░░  ░░   ░░

#
#   KEYBINDINGS
#
# emacs like
bindkey "^a"  beginning-of-line
bindkey "^e"  end-of-line
bindkey "^k"  kill-line
bindkey "^l"  clear-screen
bindkey "^u"  kill-whole-line
bindkey "^w"  backward-kill-word

bindkey '^x'   clear-screen
bindkey '^[^M' self-insert-unmeta
bindkey '^[[Z' reverse-menu-complete

# edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd '^e' edit-command-line

# fix backspace, C+h and DEL key
bindkey -v '^?'          backward-delete-char
bindkey '^H'             backward-delete-char
bindkey -M vicmd "^[[3~" delete-char
bindkey "^[[3~"          delete-char

# Vim keys search history
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N      up-line-or-beginning-search
zle -N      down-line-or-beginning-search

bindkey -v '^[[J'    up-line-or-beginning-search
bindkey -v '^[[K'    down-line-or-beginning-search

bindkey -M vicmd 'L' history-incremental-search-backward
bindkey -M vicmd 'H' history-incremental-search-forward
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

#
#   Autocompletion
#
setopt NO_NOMATCH        # disable globbing
setopt complete_in_word
autoload -U compinit && compinit -u
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' ignored-patterns '.' # ignore .
zstyle ':completion:*' matcher-list \
	'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*' # case-insensitive completion
_comp_options+=(globdots) # Include hidden files.

# use vim keys in tab complete menu:
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

#
#   FZF
#
FZF_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/fzf"
[ ! -d "$FZF_DIR/fzf" ] && {
	pwd=$PWD
	mkdir -p "$FZF_DIR" && cd "$FZF_DIR"
	git clone --depth 1 https://github.com/junegunn/fzf
	"$FZF_DIR/fzf/install" --no-bash --no-fish --xdg --all
	cd "$pwd"
}
source "$FZF_DIR/fzf.zsh" 2>/dev/null

#
#   SYNTAX HIGHLIGHTING
#
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[links]='fg=magenta,underline'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold,underline'
ZSH_HIGHLIGHT_STYLES[function]='fg=cyan,bold,underline'
ZSH_HIGHLIGHT_STYLES[command]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='none'
ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=red,underline'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=green'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=green'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[assign]='none'

#
#   HISTORY
#
HISTSIZE=999999
SAVEHIST=999999
HISTFILE="${XDG_CONFIG_HOME:-~/.config}/zsh/.zsh_history"
setopt extended_history   # Record timestamp of command in HISTFILE
setopt hist_ignore_dups   # Ignore duplicated commands history list
setopt share_history      # Share command history data
setopt histignorespace    # Ignore commands prepended with a space

# #
# #   PROMPT
# #
# ICO_DIRTY="%F{red}•"
# ICO_AHEAD="%F{green}↑"
# ICO_BEHIND="%F{yellow}↓"
# ICO_DIVERGED="%F{red}!"
#
# COLOR_ROOT="%F{red}"
# COLOR_USER="%F{cyan}"
# COLOR_NORMAL="%F{white}"
# PROMPT_STYLE="classic"
#
# # allow functions in the prompt
# setopt PROMPT_SUBST
# autoload -Uz colors && colors
#
# # colors for permissions
# [ "$EUID" -ne "0" ] &&
# 	USER_LEVEL="${COLOR_USER}" ||
# 	USER_LEVEL="${COLOR_ROOT}"
#
# # git prompt
# GIT_PROMPT() {
# 	ref=$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null) || exit
#
# 	[ "$(git rev-parse --is-bare-repository 2>&1)" = "false" ] && {
# 		[[ $(git status --short | wc -l) -ne 0 ]] && dirty=$ICO_DIRTY || dirty=""
#
# 		stat=$(git status | sed -n 2p)
#
# 		case "$stat" in
# 		*ahead*) stat=$ICO_AHEAD ;;
# 		*behind*) stat=$ICO_BEHIND ;;
# 		*diverged*) stat=$ICO_DIVERGED ;;
# 		*) stat="" ;;
# 		esac
# 	}
# 	echo "${USER_LEVEL}─[${COLOR_NORMAL}${ref}${dirty}${stat}${USER_LEVEL}]"
# }
#
# precmd() { # Use two line prompt when $PWD is long
# 	if [ ${#PWD} -ge 20 ]; then
# 		PROMPT='${USER_LEVEL}┌%(?..[%F{red}%?${USER_LEVEL}]-)[${COLOR_NORMAL}%~${USER_LEVEL}]$(GIT_PROMPT)'$'\n''${USER_LEVEL}└─ ─ %f'
# 	else
# 		PROMPT='${USER_LEVEL}%(?..[%F{red}%?${USER_LEVEL}]-)[${COLOR_NORMAL}%~${USER_LEVEL}]$(GIT_PROMPT)── ─ %f'
# 	fi
#
# 	# Set window title
# 	printf '\033]0;%s\007' "$PWD"
# }

#
#   VI MODE
#
bindkey -v
export KEYTIMEOUT=1

# change cursor shape for different vi modes.
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
	   [[ $1 = 'block' ]]; then
		echo -ne '\e[2 q'
	elif [[ ${KEYMAP} == main ]] ||
	     [[ ${KEYMAP} == viins ]] ||
	     [[ ${KEYMAP} = '' ]] ||
	     [[ $1 = 'beam' ]]; then
		echo -ne '\e[6 q'
	fi
}
zle -N zle-keymap-select

zle-line-init() {
	zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
	echo -ne "\e[6 q"
}
zle -N zle-line-init

preexec() {
	printf '\033]0;%s\007' "$2"
	printf '\e[1 q'
}

printf '\e[6 q' # Use beam shape cursor on startup.

#
#   Miscellaneous
#
set -k                  # Allow comments in shell
setopt shwordsplit      # Split words on variable substitution (like in sh)
setopt auto_cd          # cd by just typing the directory name
unsetopt flowcontrol    # Disable Ctrl-S + Ctrl-Q
source "$ZDOTDIR/aliases" 2>/dev/null
source "$ZDOTDIR/shortcutrc" 2>/dev/null

# bind `^n` to ls
els() { clear; ls; zle redisplay; }
zle -N els; bindkey "^n" els

# bind `^g` to git status
egs() { clear; git status; zle redisplay; }
zle -N egs; bindkey "^g" egs

# Interactive program options
export GPG_TTY=$(tty)

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# Load asdf-vm completion
if [ -f /opt/asdf-vm/asdf.sh ]; then
	source /opt/asdf-vm/asdf.sh
fi

# Add and initialize the pure prompt
fpath+=("${ZDOTDIR}/pure")
autoload -U promptinit; promptinit
prompt pure
zstyle :prompt:pure:git:stash show yes
