#!/bin/bash
BASEDIR=$(cd $(dirname "$0") && pwd)

# unlimit zsh history size
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export HISTFILE=~/.zsh_history

### === export krew ===
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

### === export golang ===
export PATH=$PATH:/usr/local/go/bin
export GOBIN=$HOME/go/bin
export PATH=$PATH:$GOBIN

### === export gpg ===
export GPG_TTY=$(tty)

export LC_ALL=zh_TW.UTF-8
export PATH="$PATH:$BASEDIR/bat/bin:$HOME/.local/bin"

### === aliases ===
alias py="python"
alias pf="fzf --preview 'bat --color \"always\" {}'"
alias pfc="fzf --preview 'bat --color \"always\" {}' | xargs code"
alias prettyjson="python -m json.tool"

### === init pyenv ===
export PYENV_ROOT="$BASEDIR/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

### === custom functions ===
function pip() {
    if [[ $1 == "search" ]]; then
        command curl https://pypi.org/pypi/$2/json | jq .releases | jq 'keys[]'
    else
        command pip "$@"
    fi
}

function realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

function docker_rn() {
    docker rmi $1 $(docker images --filter "dangling=true" -q --no-trunc)
}
