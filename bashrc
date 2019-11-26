export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export GREP_OPTIONS='--color=auto --exclude=*.min.js --exclude-dir=.git'
export EDITOR=vim
export PAGER=less

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

if [ -d /usr/local/opt/coreutils/libexec/gnubin ]; then
    PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
    export PATH
fi

if [ -f "/usr/local/etc/profile.d/bash_completion.sh" ]; then
    . "/usr/local/etc/profile.d/bash_completion.sh"
fi
