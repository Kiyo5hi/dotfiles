export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh
PROMPT='%{$fg_bold[white]%}$USER@%{$fg[yellow]%}%m%}%{$fg_bold[cyan]%} %c $(git_prompt_info)%{$reset_color%}'

alias dev="ssh dev"
