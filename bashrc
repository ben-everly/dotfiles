#!/bin/bash

source ~/.shrc

shopt -s histappend

for file in ~/.bash/* ; do
    if [ -f "$file" ]; then
        source "$file"
    fi
done

if [ -f "/usr/local/etc/profile.d/bash_completion.sh" ]; then
    . "/usr/local/etc/profile.d/bash_completion.sh"
fi

export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
