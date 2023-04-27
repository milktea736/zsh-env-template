if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

BASEDIR=$(cd $(dirname "$0") && pwd)

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Load mac client env
  source "$BASEDIR/mac-env.sh"
fi

# Load custom host env
source "$BASEDIR/host-env.sh"

function load_zplug() {
    # use zplug
    export ZPLUG_HOME=$BASEDIR/.zplug
    source "$ZPLUG_HOME/init.zsh"
    source "$BASEDIR/zplug.conf"
}

load_zplug