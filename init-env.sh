#!/bin/bash
BASEDIR=$(dirname "$0")

# download pyenv
git clone https://github.com/pyenv/pyenv.git $BASEDIR/pyenv

# download antigen
curl -L git.io/antigen > $BASEDIR/antigen.zsh

# install autojump
git clone git://github.com/wting/autojump.git $BASEDIR/autojump
cd $BASEDIR/autojump
./install.py

echo "please add the lines above to the top of zshrc"
