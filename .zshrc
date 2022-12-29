# Zsh related
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh
PROMPT="%{$fg_bold[white]%}$USER@%{$fg[yellow]%}%m%}%{$fg_bold[cyan]%} %c $(git_prompt_info)%{$reset_color%}"

alias dev="ssh 0x05"

# Docker related
export DOCKER_CERT_PATH=/Users/kiyoshi/.docker/certs
export DOCKER_TLS_VERIFY=1
export DOCKER_HOST=tcp://0x05.k1yoshi.com:2376

# Convenient Scripts
export PATH=$PATH:/Users/kiyoshi/Source/convenient-scripts
