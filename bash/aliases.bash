#!/bin/bash
export LESS='RSFXm'

alias ls='ls -F --color=always'
alias ll='ls -l'
alias la='ls -al'

alias grep='grep --color=always --exclude=*.min.js --exclude-dir=.git'
alias ag='ag --pager="less"'

alias :q='exit'

alias vim='nvim'

tabtocsv() {
	sed -i 's/\"/\"\"/g' $1
	sed -i 's/$/\"/g' $1
	sed -i 's/^/\"/g' $1
	sed -i 's/\t/\",\"/g' $1
}
