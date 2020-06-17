#!/bin/sh

export LESS='RSFXm'

alias ls='ls -F --color=always'
alias ll='ls -l'
alias la='ls -al'

alias grep='grep --color=always'
alias ag='ag --pager="less"'

alias :q='exit'

alias vim='nvim'
alias myvim='nvim +"set filetype=mysql"'

alias dc='docker-compose'

alias gs='git st'
alias gc='git commit'
alias gd='git diff'
alias gl='git lg'

tabtocsv() {
	sed -i 's/\"/\"\"/g' $1
	sed -i 's/$/\"/g' $1
	sed -i 's/^/\"/g' $1
	sed -i 's/\t/\",\"/g' $1
}
