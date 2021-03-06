#!/bin/zsh

autoload -Uz compinit && compinit
autoload -U colors && colors
autoload bashcompinit && bashcompinit

source ~/.shrc

for file in ~/.zsh/* ; do
    if [ -f "$file" ]; then
        source "$file"
    fi
done

setopt GLOB_COMPLETE
setopt interactivecomments

precmd() { eval "$PROMPT_COMMAND" }

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
