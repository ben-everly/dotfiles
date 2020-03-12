#!/bin/bash

colors=(
   "reset::\e[0m"
   "black::\e[1;32m"
   "blue::\e[0;34m"
   "cyan::\e[0;36m"
   "green::\e[0;32m"
   "pink::\e[0;35m"
   "red::\e[0;31m"
   "orange::\e[1;31m"
   "white::\e[0;37m"
   "brown::\e[0;33m"
   "purple::\e[1;35m"
)

raw_color() {
    for index in "${colors[@]}"; do
        if [[ "${index%%::*}" == $1 ]]; then
            echo "${index##*::}"
        fi
    done
}
color() {
    echo "\[$(raw_color $1)\]"
}

prompt() {
    # build the prompt
    local userStyle=''
    local hostStyle=''

    # sudo -s
    if [ "$EUID" -eq 0 ]; then
        userStyle="$(color red)"
    else
        userStyle="$(color green)"
    fi

    # connected via ssh
    if [ "$SSH_TTY" ]; then
        hostStyle="$(color red)"
    else
        hostStyle="$(color brown)"
    fi

    # set the terminal title to the current working directory
    PS1="\[\033]0;\w\007\]"

    PS1+="$userStyle\u" # username
    PS1+="$(color reset)@"
    PS1+="$hostStyle\h" # host
    PS1+="$(color reset):"
    PS1+="$(color cyan)\w" # working directory
    PS1+="$(color reset)\$ $(color reset)" # $ (and reset color)

    export PS1
}

git_prompt() {
    local branch=''
    if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
        if [ "$branch" "==" "HEAD" ]; then
            branch='detached*'
            local tag="[$(git describe --tags)]"
        fi
        printf "\n$(raw_color purple)[%s]%s$(raw_color reset)\n" $branch $tag
    fi
}

prompt;
export PROMPT_COMMAND="git_prompt;"
