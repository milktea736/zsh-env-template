#!/bin/bash
BASEDIR=$(cd $(dirname "$0") && pwd)

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

    # create soft link for bat
    mkdir -p $BASEDIR/bat/bin
    ln -s $(which batcat) $BASEDIR/bat/bin/bat

    # install fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git $BASEDIR/fzf
    $BASEDIR/fzf/install

    # install autojump
    git clone https://github.com/wting/autojump.git $BASEDIR/autojump
    cd $BASEDIR/autojump
    python3 ./install.py

    echo "=== please add the lines above to the top of cd $BASEDIR/zshrc ==="

    # install tmux.conf
    git clone https://github.com/gpakosz/.tmux.git $BASEDIR/tmux.conf
    echo "=== Create a symbolic link for tmux.conf ==="
    echo "=== Please follow the instuctions below ==="
    echo "ln -s -f $BASEDIR/tmux.conf/.tmux.conf ~/.tmux.conf"
    echo "cp $BASEDIR/tmux.conf/.tmux.conf.local ~/.tmux.conf.local"
}

function install_requires() {
    common_install

    os=$(uname -s)
    if [ $os == "Linux" ]; then
        linux_install
    elif [ $os == "Darwin" ]; then
        mac_install
    fi
}

install_requires
