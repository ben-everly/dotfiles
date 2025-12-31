#!/bin/zsh

source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

zstyle ':zim:git' aliases-prefix 'g'
zstyle ':zim:input' double-dot-expand yes

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[comment]='fg=242'
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${HOME}/.zim
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${HOME}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh
unalias gh 2>/dev/null

alias ls='eza --group-directories-first --icons'

zmodload -F zsh/terminfo +p:terminfo

# ------------------------------
# Post-init module configuration
# ------------------------------

autoload bashcompinit && bashcompinit

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

export WORDCHARS=${WORDCHARS//[\/]}

typeset -U path

export PNPM_HOME="/home/beneverly/.local/share/pnpm"
path+=("$PNPM_HOME")
if which ruby >/dev/null && which gem >/dev/null; then
  path+=("$(ruby -r rubygems -e 'puts Gem.user_dir')/bin")
fi
if which go >/dev/null; then
  path+=("$(go env GOPATH)/bin")
fi

if [[ -f /home/beneverly/.oberd/env ]]; then #oberd_env
  source /home/beneverly/.oberd/env #oberd_env
fi #oberd_env

bindkey -v
bindkey -M viins '\e.' insert-last-word
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '^k' history-substring-search-up
bindkey '^j' history-substring-search-down

precmd() { (retval=$?;tput cup "$LINES";exit $retval) }

# opencode
export PATH=/home/beneverly/.opencode/bin:$PATH
