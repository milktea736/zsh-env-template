#!/bin/bash

export KUBECONFIG=$HOME/Cathay/project/deploy-okd/csc/auth/kubeconfig
export OC_CLI=$HOME/Cathay/project/deploy-okd/client
export PATH=$PATH:$KUBECONFIG:$OC_CLI

### === load code-gist bins ===
GIST_BIN_DIR=$HOME/code-gists/bin

bin_path=$(find $GIST_BIN_DIR -type d | tr '\n' ':')
export PATH=$PATH:$bin_path

### === init thefuck ===
eval "$(thefuck --alias wtf)"

### === init nvm ===
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

function checkin() {
    (
        cd $HOME/Cathay/playground/clockon
        create_environment_json
        newman run checkin.postman_collection.json --environment environment.json
        rm environment.json
    )
}

function checkout() {
    (
        cd $HOME/Cathay/playground/clockon
        create_environment_json
        newman run checkout.postman_collection.json --environment environment.json
        rm environment.json
    )
}

function create_environment_json() {
    user_id=$(grep user_id properties.ini | cut -d '=' -f 2)
    password=$(grep password properties.ini | cut -d '=' -f 2)

    cat cathay.postman_environment.json |
        sed "s/{USER_ID}/${user_id}/" |
        sed "s/{USER_PASSWORD}/${password}/" > environment.json
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/Cathay/project/gcp-demo/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/Cathay/project/gcp-demo/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/Cathay/project/gcp-demo/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/Cathay/project/gcp-demo/google-cloud-sdk/completion.zsh.inc'; fi
