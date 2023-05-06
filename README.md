# A template enviroment of zsh

* Requirements: Install `zsh`, makes `zsh` as default shell

## Install steps(On ubuntu 20.04+)

* Install requirements
  * `$ sudo locale-gen zh_TW.UTF-8`
  * `$ sudo apt-get update`

* Execute install script. `$ ./zsh-env-template/init-env.sh`
  * This script will Install requirements (`pyenv`)
    * [Fulfils pyenv suggested build environment](https://github.com/pyenv/pyenv/wiki#suggested-build-environment) if you are using Linux

* add `source $PATH_TO_ZSH_ENV_TEMPLATE/zshenv` to the top of `~/.zshrc`

* Set zsh as your default shell. `sudo chsh -s $(which zsh) $USER`

* logout & login

* Install python: `asdf plugin-add python `. List all the python versions `asdf list all python`, Install: `asdf install python 3.11.3`. Set global version: `asdf global python 3.11.3`
* Install golang: `asdf plugin-add golang https://github.com/kennyp/asdf-golang.git`. Install: `asdf install golang 1.20.4`. Set global version: `asdf global golang 1.20.4`.