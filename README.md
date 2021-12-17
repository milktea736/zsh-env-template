# A template enviroment of zsh

* Requirements: Install `zsh`, makes `zsh` as default shell

## Install steps(On ubuntu 20.04)

* Install requirements
  * `$ sudo locale-gen zh_TW.UTF-8`
  * `$ sudo apt-get update`
  * `$ sudo apt-get install -y zsh python-is-python3 thefuck tree bat`

* Create a `.zshrc` file at home directory
  * `$ touch ~/.zshrc`

* Execute install script. `$ ./zsh-env-template/init-env.sh`
  * This script will Install requirements (`pyenv`, `antigen` and `autojump`)
    * [Fulfils pyenv suggested build environment](https://github.com/pyenv/pyenv/wiki#suggested-build-environment) if you are using Linux

* add `source $PATH_TO_ZSH_ENV_TEMPLATE/zshenv` to the top of `~/.zshrc`

* Set zsh as your default shell. `sudo chsh -s $(which zsh) $USER`
