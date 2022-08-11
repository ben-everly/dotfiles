#!/bin/zsh

fpath+=($HOME/.zsh/pure)
autoload -Uz compinit && compinit
autoload -U colors && colors
autoload bashcompinit && bashcompinit
autoload -U promptinit; promptinit
prompt pure

setopt globcomplete
setopt interactivecomments

setopt correct
SPROMPT='%F{red}%R%f -> %F{green}%r%f [nyae]? '

setopt sharehistory
setopt histignorealldups
setopt histreduceblanks

export HISTFILE=~/.zsh_history
export HISTSIZE=1000000000
export SAVEHIST=1000000000

source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

export WORDCHARS=${WORDCHARS//[\/]}

typeset -U path

export VOLTA_HOME="$HOME/.volta"
path+=("$VOLTA_HOME/bin")

export PNPM_HOME="/home/beneverly/.local/share/pnpm"
path+=("$PNPM_HOME")

if [ -f /home/beneverly/.oberd/env ]; then #oberd_env
  source /home/beneverly/.oberd/env #oberd_env
fi #oberd_env

bindkey -v
bindkey -M viins '\e.' insert-last-word
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '^k' history-substring-search-up
bindkey '^j' history-substring-search-down

precmd() { (retval=$?;tput cup "$LINES";exit $retval) }
