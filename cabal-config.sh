#!/bin/sh

if [ -z "$1" ]; then
  cabal_conf=$HOME/.cabal/config
  echo "using default cabal config path $cabal_conf"
elif [ -f "$1" ]; then
  echo "modifying $1"
  cabal_conf=$1
else
  echo "file not found: '$1'"
  exit 1
fi

tmpfile=$(mktemp)
cat $cabal_conf \
       | sed -s 's/^-- library-profiling: False/library-profiling: True/' \
       | sed -s 's/^-- executable-profiling: False/executable-profiling: True/' \
       > $tmpfile

if [ $? -ne 0 ]; then
  echo "stream editing $cabal_conf failed"
  exit 1
fi

mv $tmpfile $cabal_conf
echo "modified $cabal_conf successfully"

