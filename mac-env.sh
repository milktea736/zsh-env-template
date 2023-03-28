#!/bin/bash

export KUBECONFIG=$HOME/Cathay/project/deploy-okd/csc/auth/kubeconfig
export OC_CLI=$HOME/Cathay/project/deploy-okd/client
export PATH=$PATH:$KUBECONFIG:$OC_CLI
export GO_BIN_HOME=~/go/bin
export PATH=$PATH:$GO_BIN_HOME

### === load code-gist bins ===
GIST_BIN_DIR=$HOME/code-gists/bin

bin_path=$(find $GIST_BIN_DIR -type d | tr '\n' ':')
export PATH=$PATH:$bin_path

### === load  krew ===
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
alias kail="kubectl tail"

# ### === init nvm ===
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

### === AWS ===
alias ec2-u18="ssh -i ~/.ssh/lab_ivan.pem ubuntu@aws-u18"
alias ec2-ivan-u18="ssh -i ~/.ssh/lab_ivan.pem ivan@aws-u18"
alias ec2-u20="ssh -i ~/.ssh/lab_ivan.pem ubuntu@aws-u20"
alias ec2-graph="ssh -i ~/.ssh/micro-cluster-workshop.pem ubuntu@auto-graph"

### === lazy functions ===
function workwork() {
    (cd $HOME/Cathay/playground/aws-scripts && pipenv run python manage-instance.py start $1)
}

function byebye() {
    (cd $HOME/Cathay/playground/aws-scripts && pipenv run python manage-instance.py stop $1)
}

function state() {
    (cd $HOME/Cathay/playground/aws-scripts && pipenv run python manage-instance.py state $1)
}

function upload() {
    source_dir="$HOME/Cathay/project/micro-cluster"

    if [ "$1" = "--del" ]; then
        rsync -rave "ssh -i ~/.ssh/lab_ivan.pem" --exclude venv --exclude '*.pyc' --delete ${source_dir} ubuntu@aws-u18:/data/
    else
        rsync -rave "ssh -i ~/.ssh/lab_ivan.pem" --exclude venv --exclude '*.pyc' ${source_dir} ubuntu@aws-u18:/data/
    fi
}

function upload_stable() {
    source_dir="$HOME/Cathay/project/stable"

    if [ "$1" = "--del" ]; then
        rsync -rave "ssh -i ~/.ssh/lab_ivan.pem" --exclude venv --exclude '*.pyc' --delete ${source_dir} ubuntu@aws-u18:/data/
    else
        rsync -rave "ssh -i ~/.ssh/lab_ivan.pem" --exclude venv --exclude '*.pyc' ${source_dir} ubuntu@aws-u18:/data/
    fi
}
