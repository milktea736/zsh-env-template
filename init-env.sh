#!/bin/bash
BASEDIR=$(cd $(dirname "$0") && pwd)

function common_install() {
    # install zplug
    export ZPLUG_HOME=$BASEDIR/.zplug
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
}

function mac_install() {
    brew install pyenv
    brew install autojump
    brew install fzf
    brew install tree
    echo "please add the lines above to the top of zshrc"

}

function linux_install() {
    sudo apt install -y fzf tree bat jq zsh tmux

    # create soft link for bat
    mkdir -p $BASEDIR/bat/bin
    ln -s $(which batcat) $BASEDIR/bat/bin/bat

    echo "=== please add the lines above to the top of cd $BASEDIR/zshrc ==="

    # install asdf
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3

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
