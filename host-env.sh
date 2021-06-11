#!/bin/bash
BASEDIR=$(cd $(dirname "$0") && pwd)

### === Set env ===
export LC_ALL=zh_TW.UTF-8

### === Concate custom PATH ===
export PATH=$PATH:$BASEDIR/bat/bin

### === Aliases ===
alias py="python"
alias gdd=git_diff
alias gss=git_stash_save
alias pf="fzf --preview 'bat --color \"always\" {}'"
alias pfc="fzf --preview 'bat --color \"always\" {}' | xargs code"
alias prettyjson="python -m json.tool"

### === Init pyenv ===
export PYENV_ROOT="$BASEDIR/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

### === Init thefuck ===
eval "$(thefuck --alias wtf)"

### === Init nvm ===
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

function pip() {
    if [[ $1 == "search" ]]; then
        command curl https://pypi.org/pypi/$2/json | jq  .releases | jq 'keys[]'
    else
        command pip "$@"
    fi
}

### === Custom functions ===
function realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

function git_diff {
    git diff HEAD $1
}

function git_stash_save {
    git stash save $1
}

function docker_rn() {
    docker rmi $1 $(docker images --filter "dangling=true" -q --no-trunc)
}
