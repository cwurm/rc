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

# -C: force multi-column mode (see [1])
# --color=always: always use coloring (see [1])
# --indicator-style=slash: append slash ('/') to directories
# --group-directories-first: list directories before files (only available in ls version 6 or higher)
# ls is a tool from the GNU Core Utilities (coreutils). From version 6 on it supports the parameter --group-directories-first.
if [[ $OSTYPE == darwin* ]] {
	alias ls="ls -F -G"
	alias ll="ls -l -a -h"
} else {
	coreutilsMainVersion=`ls --version | head -n 1 | awk '{print substr($NF, 1, 1)}'`
	if [[ $coreutilsMainVersion -ge 6 ]] {
		alias ls="ls -C --color=always --indicator-style=slash --group-directories-first"
	} else {
		alias ls="ls -C --color=always --indicator-style=slash"
	}
	alias ll="ls -l --all --human-readable"
}

alias pstree="ps -eF --forest --headers"  # Show process tree 
alias reloadrc="source ~/.zshrc"
alias grep="grep --binary-files=without-match --line-number"  # Don't search in binary files, show line number
alias igrep="grep --ignore-case"
alias less="less --RAW-CONTROL-CHARS"	# interpret ANSI "color" escape sequences (see also [1]) 
alias rm="rm -I"	# safety precaution, see rm(1)

# http://stackoverflow.com/q/8801198/235203
alias g++="g++ -Wall -Wextra -Wshadow"
alias nm="nm --demangle"

# [1] http://unix.stackexchange.com/questions/7164/scrolling-through-ls-output-without-a-mouse/7178#7178 

########
# PATH #
########

# If the directory ~/bin exists prepend it to PATH.
if [[ -d $HOME/bin ]] {
	PATH=$HOME/bin:$PATH
}


###############
# Environment #
###############

# Setting VISUAL instead of EDITOR because of comments on [1]
# [1] http://unix.stackexchange.com/questions/7186/can-less-invoke-vim-instead-of-the-default-vi-when-i-hit-the-v-key/7188#7188
export VISUAL=vim


########
# MISC #
########

# Case-insensitive autocompletion (only a->A, not A->a)
# From http://zsh.sourceforge.net/Guide/zshguide06.html Section 6.7.1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


#############
# FUNCTIONS #
#############

function backup() {
	if [[ -f "$1" ]] {
		if [[ ! -d "$HOME/backups" ]] {
			echo "Creating backup directory at $HOME/backups"
			mkdir $HOME/backups
		}

		pushd -q $(dirname $1)
		# Format: hostname.path.to.file.<timestamp in extended ISO 8601 format (no time zone at the end, assume CE(S)T)>
		backupFile="$HOME/backups/$HOST$(pwd -P | sed 's|/|.|g').$(basename $1)-$(date +%Y-%m-%dT%H:%M:%S)"
		if [[ -f "$backupFile" ]] {
			echo "File already exists: $backupFile"
			return 1
		} else {
			cp $(basename $1) $backupFile
			echo "Backed up as $backupFile"
		}
		popd -q
	} else {
		echo "Not a file: $1"
		return 1
	}
	
	if [[ ! -f $backupFile ]] {
		echo "Failed to back up."
		return 1
	}
}


###############################
# HOST-SPECIFIC CONFIGURATION #
###############################

if [[ -f "$HOME/.zshrc.local" ]] {
	source "$HOME/.zshrc.local"
}

