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


##########
# PROMPT #
##########

autoload -U colors && colors

# My custom prompt. 
# Displays the exit code of a command if it is not 0 on a line of its own.
# The actual prompt is '<user>@<hostname>:<pwd> <privilegeLevel> '.
PROMPT="%0(?..%{$bg[red]%}%?%{$reset_color%}
)%{$fg[green]%}%n@%m%{$reset_color%}:%~ %{$fg[red]%}%#%{$reset_color%} "

RPROMPT="[ %D{%d.%m.%Y %H:%M:%S} ]"


###########
# ALIASES #
###########

# ls is a tool from the GNU Core Utilities (coreutils). From version 6 on it supports the parameter --group-directories-first.
coreutilsMainVersion=`ls --version | head -n 1 | awk '{print substr($NF, 0, 1)}'`
if [[ $coreutilsMainVersion -ge 6 ]]; then
	alias ls="ls --color=auto --indicator-style=slash --group-directories-first"
else
	alias ls="ls --color=auto --indicator-style=slash"
fi

alias ll="ls -l --all --human-readable"
alias lso="ll -S"  # list sorted (by file size) 
alias pstree="ps -eF --forest --headers"  # Show process tree 
alias reloadrc="source ~/.zshrc"
alias grep="grep --binary-files=without-match --line-number"  # Don't search in binary files, show line number
alias igrep="grep --ignore-case"


########
# PATH #
########

# If the directory ~/bin exists prepend it to PATH.
if [[ -d $HOME/bin ]] then PATH=$HOME/bin:$PATH fi


###############
# Environment #
###############

export EDITOR=vim
