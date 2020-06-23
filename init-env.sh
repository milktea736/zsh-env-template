#!/bin/bash
BASEDIR=$(dirname "$0")

function common_install() {
    # download antigen
    curl -L git.io/antigen > $BASEDIR/antigen.zsh
}

function mac_install() {
    brew install pyenv
    brew install autojump
    brew install fzf
    brew install tree
    echo "please add the lines above to the top of zshrc"

}

function linux_install() {
    # download pyenv
    git clone https://github.com/pyenv/pyenv.git $BASEDIR/pyenv

    # install autojump
    git clone git://github.com/wting/autojump.git $BASEDIR/autojump
    cd $BASEDIR/autojump
    ./install.py

    echo "please add the lines above to the top of zshrc"
}

function install_requires(){
    common_install

    os=$(uname -s)
    if [ $os == "Linux" ]; then
        linux_install
    elif [ $os == "Darwin" ]; then
        mac_install
    fi
}

install_requires