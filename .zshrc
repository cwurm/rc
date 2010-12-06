# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/chrwurm/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U colors && colors

# My custom prompt. 
# Displays the exit code of a command if it is not 0 on a line of its own.
# The actual prompt is '<user>@<hostname>:<pwd> <privilegeLevel> '.
PROMPT="%0(?..%{$bg[red]%}%?%{$reset_color%}
)%{$fg[green]%}%n@%m%{$reset_color%}:%~ %{$fg[red]%}%#%{$reset_color%} "

RPROMPT="[ %D{%d.%m.%Y} %* ]"

alias ls="ls --color=auto --indicator-style=slash --group-directories-first"
alias ll="ls -l --all --human-readable"
# list sorted (by file size)
alias lso="ll -S"
# Show process tree
alias pstree="ps -eF --forest --headers"
alias reloadrc="source ~/.zshrc"
