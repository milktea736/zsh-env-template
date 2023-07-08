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

### === export fzf configs ===
export LC_ALL=zh_TW.UTF-8
export PATH="$PATH:$BASEDIR/bat/bin:$HOME/.local/bin"

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


### === aliases ===
alias py="python"


### === custom functions ===
function pfc() {
    local PRVIEW_WINDOW="--preview-window 'right:57%'"
    local PREVIEW="--preview 'bat --color always --style=numbers --line-range :300 {}'"
    local BIND="--bind 'ctrl-y:preview-up,ctrl-e:preview-down,ctrl-b:preview-page-up,ctrl-f:preview-page-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down,shift-up:preview-top,shift-down:preview-bottom,alt-up:half-page-up,alt-down:half-page-down'"
    local files
    files=$(eval "fzf $PRVIEW_WINDOW $PREVIEW $BIND --exit-0") && code  $files
}

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

export JABBA_VERSION='0.11.2'
[ -s "$JABBA_HOME/jabba.sh" ] && source "$JABBA_HOME/jabba.sh"
