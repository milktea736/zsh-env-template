#!/bin/bash

export KUBECONFIG=/Users/ivan/Cathay/project/deploy-okd/setup-dir/auth/kubeconfig
export OC_CLI=/Users/ivan/Cathay/project/deploy-okd/client
export PATH=$PATH:$KUBECONFIG:$OC_CLI

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

### === lazy functions ===
function workwork() {
    (cd /Users/ivan/Cathay/playground/aws-scripts && pipenv run python manage-instance.py start $1)
}

function byebye() {
    (cd /Users/ivan/Cathay/playground/aws-scripts && pipenv run python manage-instance.py stop $1)
}

function state() {
    (cd /Users/ivan/Cathay/playground/aws-scripts && pipenv run python manage-instance.py state $1)
}

function upload() {
    source_dir="/Users/Ivan/Cathay/project/micro-cluster"

    if [ "$1" = "--del" ]; then
        rsync -rave "ssh -i ~/.ssh/lab_ivan.pem" --exclude venv --exclude '*.pyc' --delete ${source_dir} ubuntu@aws-u18:/data/
    else
        rsync -rave "ssh -i ~/.ssh/lab_ivan.pem" --exclude venv --exclude '*.pyc' ${source_dir} ubuntu@aws-u18:/data/
    fi
}

function upload_stable() {
    source_dir="/Users/ivan/Cathay/project/stable"

    if [ "$1" = "--del" ]; then
        rsync -rave "ssh -i ~/.ssh/lab_ivan.pem" --exclude venv --exclude '*.pyc' --delete ${source_dir} ubuntu@aws-u18:/data/
    else
        rsync -rave "ssh -i ~/.ssh/lab_ivan.pem" --exclude venv --exclude '*.pyc' ${source_dir} ubuntu@aws-u18:/data/
    fi
}

function checkin() {
    (
        cd /Users/ivan/Cathay/playground/clockon
        create_environment_json
        newman run checkin.postman_collection.json --environment environment.json
        rm environment.json
    )
}

function checkout() {
    (
        cd /Users/ivan/Cathay/playground/clockon
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
if [ -f '/Users/ivan/Cathay/project/gcp-demo/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ivan/Cathay/project/gcp-demo/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ivan/Cathay/project/gcp-demo/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ivan/Cathay/project/gcp-demo/google-cloud-sdk/completion.zsh.inc'; fi
