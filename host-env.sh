BASEDIR=$(dirname "$0")

### === Set env ===
export LC_ALL=zh_TW.UTF-8

### === Init Pyenv ===
export PYENV_ROOT=$BASEDIR/pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"

### === Aliases ===
alias py="python"
alias gdd=git_diff
alias gss=git_stash_save

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
