#!/bin/zsh
######################################################################
#           spease's zshrc file v1.3.1 , based on:
#		      jdong's zshrc file v0.2.1
#
#
######################################################################

# next lets set some enviromental/shell pref stuff up
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
unsetopt BG_NICE		# do NOT nice bg commands
setopt CORRECT			# command CORRECTION
setopt EXTENDED_HISTORY		# puts timestamps in the history

setopt MENUCOMPLETE
setopt ALL_EXPORT

# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent 
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash


PATH="/usr/local/git2.8/bin:/home/`hostname -s`/a/spease/.local/bin:/usr/local/bin:/usr/local/sbin/:/bin:/sbin:/usr/bin:/usr/sbin:$PATH"
TZ="America/New_York"
HISTFILE=$HOME/.zhistory
HISTSIZE=5000
SAVEHIST=5000
HOSTNAME="`hostname`"
PAGER='less'
#TERM=xterm-256color
EDITOR='vim'
autoload colors zsh/terminfo
if [ $(uname) = "Darwin" ]; then
    printf -- $'\033]6;1;bg;red;brightness;20\a\033]6;1;bg;green;brightness;20\a\033]6;1;bg;blue;brightness;20\a'
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}\007"'
    precmd() { eval "$PROMPT_COMMAND" }
    HOSTNAME="local"
fi
if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
  eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
  eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
  (( count = $count + 1 ))
done
PR_NO_COLOR="%{$terminfo[sgr0]%}"
PS1="[$PR_BLUE%n$PR_WHITE@$PR_GREEN%U${HOSTNAME}%u$PR_NO_COLOR:$PR_RED%2c$PR_NO_COLOR]%(!.#.$) "
RPS1="$PR_LIGHT_YELLOW(%D{%m-%d %H:%M})$PR_NO_COLOR"
#LANGUAGE=
LC_ALL='en_US.UTF-8'
LANG='en_US.UTF-8'
LC_CTYPE=C
LSCOLORS="ExfxcxdxcxegedaBagacad"

if [ $SSH_TTY ]; then
  MUTT_EDITOR=vim
fi

unsetopt ALL_EXPORT
# # --------------------------------------------------------------------
# # aliases
# # --------------------------------------------------------------------

alias man='LC_ALL=C LANG=C man'
alias f=finger
if [ $(uname) = "FreeBSD" ] || [ $(uname) = "Darwin" ]; then
  alias ll='ls -halG'
  alias ls='ls -G'
else
  alias ll='ls -hal --color=auto'
  alias ls='ls --color=auto'
fi
alias s='ssh'
alias t='touch'
alias diff="my_diff"
alias diff_color="perl -pe 's/^[^+-@](.*)$/[2m\1[0m/gm|s/^(\-.*)$/[38;5;203m\1[0m/gm|s/^\+(.*)$/[38;5;103m+\1[0m/gm|s/^@@ \-(\d+),\d+ \+(\d+),\d+ @@/Lines [38;5;203m\1[0m and [38;5;103m\2[0m\./gm'"


autoload -U compinit
compinit
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

my_diff() {
  /bin/diff -u $@ | diff_color
}

first-install() {
  if ! [ "$1" = "nogit" ]; then
    internal_ilar_var_cwd=$(pwd)
    mkdir -p "${HOME}/.dotfiles/dotfiles/"
    cd "${HOME}/.dotfiles/"
    git clone "https://github.com/ilar/dotfiles.git"
    for internal_ilar_var_file in ${HOME}/.dotfiles/dotfiles/*; do
      if ! [ "$(basename $internal_ilar_var_file)" = ".git" ]; then
        rm "${HOME}/$(basename $internal_ilar_var_file)"
        ln -s "${HOME}/.dotfiles/dotfiles/$(basename $internal_ilar_var_file)" "${HOME}/$(basename $internal_ilar_var_file)"
      fi
    done
    source "${HOME}/.zshrc"
    cd "$internal_ilar_var_cwd"
  else
    update-dotfiles nogit
    for internal_ilar_var_file in ${HOME}/.dotfiles/dotfiles/*; do
      if ! [ "$(basename $internal_ilar_var_file)" = ".git" ]; then
        rm "${HOME}/$(basename $internal_ilar_var_file)"
        ln -s "${HOME}/.dotfiles/dotfiles/$(basename $internal_ilar_var_file)" "${HOME}/$(basename $internal_ilar_var_file)"
      fi
    done
    source "${HOME}/.zshrc"
  fi
}

update-dotfiles() {
  if [ "$1" = "nogit" ]; then
    mkdir -p "${HOME}/.dotfiles/dotfiles/"
    curl "https://codeload.github.com/ilar/dotfiles/zip/master" -o "${HOME}/.dotfiles/update.zip"
    unzip "${HOME}/.dotfiles/update.zip" -d "${HOME}/.dotfiles/"
    cp -r ${HOME}/.dotfiles/dotfiles-master/* "${HOME}/.dotfiles/dotfiles/"
  else
    git pull "${HOME}/.dotfiles/dotfiles/"
  fi
}

ssh-dotfiles() {
  scp -r "${HOME}/.dotfiles/dotfiles/.zshrc" "$1:"
  #ssh -t $@ 'mkdir -p "${HOME}/.dotfiles/dotfiles/"; git clone "https://github.com/ilar/dotfiles.git" "${HOME}/.dotfiles/dotfiles/" ; for internal_ilar_var_file in ${HOME}/.dotfiles/dotfiles/*; do; ln -s "${HOME}/.dotfiles/dotfiles/$(basename $internal_ilar_var_file)" "${HOME}/$(basename $internal_ilar_var_file)" ; done'
}

push-dotfiles() {
  if [ -z "$1" ]; then
    echo "You must have a commit message."
  else
    internal_ilar_var_cwd=$(pwd)
    cd "${HOME}/.dotfiles/dotfiles/"
    git add "${HOME}/.dotfiles/dotfiles/*"
    git commit -a -m "$1"
    git push 
    cd "$internal_ilar_var_cwd"
  fi
}

source "${HOME}/.zshrc.local"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
