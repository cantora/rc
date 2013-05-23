#!/bin/sh

mkdir -p $HOME/install
cd $HOME/install

git clone 'git://github.com/cantora/rc.git'
git clone 'git://github.com/cantora/cantora-bin.git'

cd rc
make install
cd $HOME/install/cantora-bin
make install
