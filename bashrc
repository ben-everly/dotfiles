export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export EDITOR=vim
export PAGER=less

export TERM=xterm-256color

export HISTCONTROL=ignoredups
shopt -s histappend
export PROMPT_COMMAND='history -a'

for file in ~/.bash/* ; do
    if [ -f "$file" ]; then
        . "$file"
    fi
done

if [ -d ~/bin ]; then
    PATH=~/bin:$PATH
    export PATH
fi
