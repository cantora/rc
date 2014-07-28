#!/bin/sh

if [ -n "$1" -a ! -f "$1" ]; then
  EFILE=$1
  efile_set () {
    echo "$1=$2" >> $EFILE
  }
else
  efile_set () {
    #do nothing
    return 0
  }
fi

export PATH=$HOME/bin:$HOME/.cabal/bin:$PATH

RUBY="$(which ruby 2>/dev/null)"
if [ -n "$RUBY" ]; then
    export PATH=$(ruby -rubygems -e "puts Gem.user_dir")/bin:$PATH
fi

GO="$(which go 2>/dev/null)"
if [ -n "$GO" ]; then
    export GOPATH=$HOME/golang
    export PATH=$GOPATH/bin:$PATH
fi

efile_set PATH $PATH
