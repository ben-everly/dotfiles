#!/bin/bash

 reset="\e[0m"
 black="\e[1;32m"
 blue="\e[0;34m"
 cyan="\e[0;36m"
 green="\e[0;32m"
 pink="\e[0;35m"
 red="\e[0;31m"
 orange="\e[1;31m"
 white="\e[0;37m"
 brown="\e[0;33m"
 purple="\e[1;35m"

prompt() {
    # build the prompt
    local userStyle=''
    local hostStyle=''

    # sudo -s
    if [ "$EUID" -eq 0 ]; then
        userStyle="\[$red\]"
    else
        userStyle="\[$green\]"
    fi

    # connected via ssh
    if [ "$SSH_TTY" ]; then
        hostStyle="\[$red\]"
    else
        hostStyle="\[$brown\]"
    fi

    # set the terminal title to the current working directory
    PS1="\[\033]0;\w\007\]"

    PS1+="\[$userStyle\]\u" # username
    PS1+="\[$reset$black\]@"
    PS1+="\[$hostStyle\]\h" # host
    PS1+="\[$reset$black\]:"
    PS1+="\[$cyan\]\w" # working directory
    PS1+="\[$reset$black\]\$ \[$reset\]" # $ (and reset color)

    export PS1
}

git_prompt() {
    local branch=''
    if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
        if [ "$branch" == "HEAD" ]; then
            branch='detached*'
        fi
        printf '\n'"$purple"'%s'"$reset"'\n' "[$branch]"
    fi
}


export PROMPT_COMMAND="git_prompt;prompt;$PROMPT_COMMAND"
