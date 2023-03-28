# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

BASEDIR=$(cd $(dirname "$0") && pwd)
# Load mac client env
source "$BASEDIR/mac-env.sh"

# Load custom host env
source "$BASEDIR/host-env.sh"

function load_zplug() {
    # use zplug
    export ZPLUG_HOME=/usr/local/opt/zplug
    source "$ZPLUG_HOME/init.zsh"
    source "$BASEDIR/zplug.conf"
}

load_zplug