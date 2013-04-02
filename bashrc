if [[ -z "$PS1" ]]; then return; fi

HISTCONTROL=ignoredups:ignorespace

shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

PS1="\e[1m\h[\$(if [ \$(pwd | wc -c) -gt 30 ]; then echo -n '...'; pwd | tail -c 27; else pwd; fi)]>\e[0m "

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

export PATH=$HOME/bin:$PATH

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

alias ssh-pw="ssh -o PreferredAuthentications=password"
alias scp-pw="ssh -o PreferredAuthentications=password"

alias trash='trash-put'
export EDITOR=vim
alias rudo="sudo -E $(which ruby)"

#unlimited core file size
ulimit -c unlimited

#source local transient configurations
. $HOME/.local.bashrc
