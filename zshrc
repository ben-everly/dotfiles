#!/bin/zsh

source ~/.shrc

autoload bashcompinit
bashcompinit
autoload -U colors
colors

for file in ~/.zsh/* ; do
    if [ -f "$file" ]; then
        source "$file"
    fi
done

precmd() { eval "$PROMPT_COMMAND" }

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
