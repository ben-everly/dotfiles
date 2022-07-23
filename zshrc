#!/bin/zsh

fpath+=($HOME/.zsh/pure)
autoload -Uz compinit && compinit
autoload -U colors && colors
autoload bashcompinit && bashcompinit
autoload -U promptinit; promptinit
prompt pure
typeset -U path

source ~/.shrc

setopt globcomplete
setopt interactivecomments

setopt sharehistory
setopt histignorealldups
setopt histreduceblanks

export HISTFILE=~/.zsh_history
export HISTSIZE=1000000000
export SAVEHIST=1000000000

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f /home/beneverly/.oberd/env ]; then #oberd_env
  source /home/beneverly/.oberd/env #oberd_env
fi #oberd_env

bindkey -v
bindkey -M viins '\e.' insert-last-word

bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

precmd() { (retval=$?;tput cup "$LINES";exit $retval) }

export PNPM_HOME="/home/beneverly/.local/share/pnpm"
path+=("$PNPM_HOME")
