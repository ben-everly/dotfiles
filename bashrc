#!/bin/bash

source ~/.shrc

shopt -s histappend

for file in ~/.bash/* ; do
    if [ -f "$file" ]; then
        source "$file"
    fi
done

export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
