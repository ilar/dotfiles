#!/bin/zsh
################################################################################
#                    spease's zshrc file v2.0.1 , based on:
#                          jdong's zshrc file v0.2.1
#
#
################################################################################

################################################################################
# Set general ZSH options.
#
#

# History
setopt SHARE_HISTORY      # Instant export of commands to history file+history
setopt APPEND_HISTORY     # Allow multiple zsh sessions to coexist.
setopt EXTENDED_HISTORY   # Puts timestamps in the history.
setopt HIST_IGNORE_DUPS   # Don't allow contiguous duplicates in history.

# Completion
setopt CORRECT            # Try to correct bad commands. e.g. cta -> cat
setopt CORRECT_ALL        # Try to correct bad arguments. e.g. --hepl -> --help
setopt REC_EXACT          # Allow exact matches without beeping at me.
setopt AUTO_LIST          # Automatically list choices for ambiguous completes.

# Directories
setopt PUSHD_TO_HOME      # pushd with no args assumes home directory.
setopt PUSHD_SILENT       # pushd doesn't tell me things I already know.
setopt AUTO_PUSHD         # cd is considered a call to pushd.
setopt AUTO_PARAM_SLASH   # Don't have an extra character to type.
setopt EXTENDED_GLOB      # nice features like recursive globbing, negation.

# Jobs
setopt NOTIFY             # Report BG jobs immediately, not at next prompt.
setopt LONG_LIST_JOBS     # List jobs in long format by default.
setopt AUTO_RESUME        # Allow a repitition of a bg command to resume it.

# Do not allow: I hate these settings.
unsetopt BG_NICE          # Background commands run at same priority as FG
unsetopt MENUCOMPLETE     # When there's completions, let me see them first.
unsetopt GLOB_DOTS        # Require a dot to match dotfiles.

# Misc
setopt MAIL_WARNING       # You've got mail.
setopt ALL_EXPORT         # Global export next section's variables.


################################################################################
# Get and set general information about the environment
#
#

# What toaster/lawnmower/etc am I running this on?
if [[ -r "$HOME/.settings/scripts/detect-os" ]]; then
    source "$HOME/.settings/scripts/detect-os"
fi

if [ "$OSX" = "1" ]; then
    # Set a sane pretty print hostname and make tabs something reasonable.
    printf -- $'\033]6;1;bg;red;brightness;18\a\033]6;1;bg;green;brightness;18\a\033]6;1;bg;blue;brightness;18\a'
    HOSTNAME="local"
else
    HOSTNAME=$(hostname -s)
fi

PATH="/usr/local/git2.8/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin/:/bin:/sbin:/usr/bin:/usr/sbin:$PATH"
TZ="America/New_York"
HISTFILE=$HOME/.zhistory
HISTSIZE=5000
SAVEHIST=5000
PAGER='less'
EDITOR='vim'
MUTT_EDITOR='vim'
LC_ALL='en_US.UTF-8'
LANG='en_US.UTF-8'
LC_CTYPE=C
DOTFILES_DIR="$HOME/.dotfiles/dotfiles"

# Set our terminal titlebar to [$USER@$HOST]$ Current Running Command
FGCMD=''
PROMPT_COMMAND='echo -ne "\033]0;[${USER}@${HOSTNAME}]\$ ${FGCMD}\007"'
precmd() { FGCMD='zsh'; eval "$PROMPT_COMMAND" }
preexec() { FGCMD="$1" ; eval "$PROMPT_COMMAND" }


################################################################################
# Colors
#
#

echo -ne '\e]4;0;#121212\a'   # black
echo -ne '\e]4;1;#d75f5f\a'   # red
echo -ne '\e]4;2;#87af5f\a'   # green
echo -ne '\e]4;3;#ffd787\a'   # yellow
echo -ne '\e]4;4;#87afd7\a'   # blue
echo -ne '\e]4;5;#d7afff\a'   # magenta
echo -ne '\e]4;6;#5fd7ff\a'   # cyan
echo -ne '\e]4;7;#d7d7d7\a'   # white (light grey really)
echo -ne '\e]4;8;#686a66\a'   # bold black (i.e. dark grey)
echo -ne '\e]4;9;#f54235\a'   # bold red
echo -ne '\e]4;10;#99e343\a'  # bold green
echo -ne '\e]4;11;#fdeb61\a'  # bold yellow
echo -ne '\e]4;12;#84b0d8\a'  # bold blue
echo -ne '\e]4;13;#bc94b7\a'  # bold magenta
echo -ne '\e]4;14;#37e6e8\a'  # bold cyan
echo -ne '\e]4;15;#f1f1f0\a'  # bold white

autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
  eval PR_$color='$terminfo[bold]$fg[${(L)color}]'
  eval PR_LIGHT_$color='$fg[${(L)color}]'
  (( count = $count + 1 ))
done
PR_NO_COLOR="%{$terminfo[sgr0]%}"
PR_BOLD='[1m'
PR_DIM='[2m'
PR_UNDERLINE='[4m'
PR_BLINK='' # No.
PR_REVERSE='[7m'
PR_HIDDEN='[8m'
PR_NO='[0m'

# OSX/BSD
LSCOLORS="EafxcxdxcxegedaBagacad"
# Linux
LS_COLORS="di=1;34:ln=35:so=32:pi=33:ex=32:bd=34;46:cd=34;43:su=30;1;41:sg=30\
;46:tw=30;42:ow=30;43"


################################################################################
# Set the prompt
#
#

PS1="[%{$PR_BLUE%}%n%{$PR_WHITE%}@%{$PR_GREEN%}%U${HOSTNAME}%u%{$PR_NO_COLOR%}"
PS1="$PS1:%{$PR_RED%}%2c%{$PR_NO_COLOR%}]%(!.#.$) "
RPS1="%{$PR_LIGHT_YELLOW%}(%D{%m-%d %H:%M})%{$PR_NO_COLOR%}"


################################################################################
# Done with enviromental variables.
#
#

unsetopt ALL_EXPORT


################################################################################
# Aliases
#
#

alias man='LC_ALL=C LANG=C man'
alias dirs="dirs -v"
alias f=finger
alias s='ssh'
alias t='touch'

# Diff colorization and sane output.
alias diff="my_diff"
alias diff_color="perl -pe 's/^[^+-@](.*)$/$PR_DIM\1$PR_NO/gm|s/^(\-.*)$/$PR_RED\1$PR_NO/gm|s/^\+(.*)$/$PR_BLUE+\1$PR_NO/gm|s/^@@ \-(\d+),\d+ \+(\d+),\d+ @@/Lines $PR_RED\1$PR_NO and $PR_BLUE\2$PR_NO\./gm'"

# LS colorization
if [ "$BSD" = "1" ]; then
  alias ll='ls -halG'
  alias ls='ls -G'
elif [ "$LINUX" = "1" ]; then
  alias ll='ls -hal --color=auto'
  alias ls='ls --color=auto'
else
    alias ll='ls -hal'
    alias ls='ls'
fi


################################################################################
# Turn on what we're all here for- autocompletion magic.
#
#

autoload -U compinit
compinit


################################################################################
# Keybinds
#
#

bindkey "" backward-delete-char
bindkey "" backward-delete-char
bindkey '^[[2~' beginning-of-line
bindkey '^[[3~' delete-char
bindkey '^[[4~' end-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey "^r" history-incremental-search-backward
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand


################################################################################
# Completion settings. Here there be dragons.
#
#

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
  'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
  'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
# on processes completion complete all user processes
# zstyle ':completion:*:processes' command 'ps -au$USER'

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#zstyle ':completion:*:processes' command 'ps ax -o pid,s,nice,stime,args | sed "/ps/d"'
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes-names' command 'ps axho command' 
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#
#NEW completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
  '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
  adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
  named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
  rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
  avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
  firebird gnats haldaemon hplip irc klog list man cupsys postfix\
  proxy syslog www-data mldonkey sys snort



################################################################################
# Utility functions
#
#

# Apply the appropriate colorization for diff.
my_diff() {
    if [ "$LINUX" = "1" ]; then
        /usr/bin/diff -u $@ | diff_color
    else
        /bin/diff -u $@ | diff_color
    fi
}

# Set up all the rest of the dotfiles.
first-install() {
  if ! [ "$1" = "nogit" ]; then
    mkdir -p "$HOME/.dotfiles"
    git -C "$HOME/.dotfiles" clone "https://github.com/ilar/dotfiles.git"
    update-symlinks
  else
    update-dotfiles nogit
    update-symlinks
  fi
}

# Handle re-symlinking everything between WC and home dir.
update-symlinks() {
    for internal_ilar_var_file in $DOTFILES_DIR/*(D); do
      if ! [ "$(basename $internal_ilar_var_file)" = ".git" ]; then
        rm "${HOME}/$(basename $internal_ilar_var_file)" 2> /dev/null
        ln -s "$DOTFILES_DIR/$(basename $internal_ilar_var_file)" "${HOME}/$(basename $internal_ilar_var_file)"
      fi
    done
    source $HOME/.zshrc
}

# Either git-pull or grab a master copy and shove it over.
update-dotfiles() {
  if [ "$1" = "nogit" ]; then
    mkdir -p "$DOTFILES_DIR"
    curl "https://codeload.github.com/ilar/dotfiles/zip/master" -o "${HOME}/.dotfiles/update.zip"
    unzip "${HOME}/.dotfiles/update.zip" -d "${HOME}/.dotfiles/"
    cp -r ${HOME}/.dotfiles/dotfiles-master/*(D) "$DOTFILES_DIR/"
  else
    git -C $DOTFILES_DIR pull
  fi
  update-symlinks
}

# Send a copy of this file to another host, then run first-install.
ssh-dotfiles() {
  scp -r "$DOTFILES_DIR/.zshrc" "$1:"
  echo "Please run first-install."
  ssh $1
}

# Push changes upstream.
push-dotfiles() {
  if [ -z "$1" ]; then
    echo "You must have a commit message."
  else
    for internal_ilar_var_file in $DOTFILES_DIR/*(D); do
        git -C $DOTFILES_DIR add "$internal_ilar_var_file"
    done
    git -C $DOTFILES_DIR commit -m "$1"
    git -C $DOTFILES_DIR push 
  fi
}


################################################################################
# Local settings and handling spurious files.
#
#

if ! [ -f "$HOME/.zshrc.local" ]; then
    touch "$HOME/.zshrc.local"
fi
if ! [ -f "$HOME/.vimrc.local" ]; then
    touch "$HOME/.vimrc.local"
fi
source "${HOME}/.zshrc.local"
