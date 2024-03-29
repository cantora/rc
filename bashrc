if [[ -z "$PS1" ]]; then return; fi

HISTCONTROL=ignoreboth:erasedupes

shopt -s histappend

HISTSIZE=999999
HISTFILESIZE=""

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

PS1="\[\033[1;37m\]\h(\$(\$HOME/bin/battery-levels))[\$(if [ \$(pwd | wc -c) -gt 30 ]; then echo -n '...'; pwd | tail -c 27; else pwd; fi)]>\[\033[0m\] "

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -hlF'
alias la='ls -alFh'
alias l='ls -CF'

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

alias ssh-pw="ssh -o PreferredAuthentications=password"
alias scp-pw="ssh -o PreferredAuthentications=password"
alias trash='trash-put'
alias tmpdir='cd $(mktemp -d)'
export EDITOR=vim

#unlimited core file size
ulimit -c unlimited

GPG_TTY=$(tty)
export GPG_TTY

source $HOME/.environment

alias emacs='ec'
alias userctl='systemctl --user'
alias rudo="sudo -E ruby"

#source local transient configurations
LOCAL_BASHRC=$HOME/.local.bashrc
[ -f $LOCAL_BASHRC ] && source $LOCAL_BASHRC

#do this after LOCAL_BASHRC so that it can override FONT
if [ -z "$FONT" ]; then
    FONT=ter-124n
fi
#set font if we are in a physical terminal
tty | grep '/dev/tty[0-9]\+' >/dev/null && setfont $FONT
