#!/bin/bash

alias ls='ls -F --color=auto'
alias ll='ls -l'
alias la='ls -al'

alias grep='grep --color=auto --exclude=*.min.js --exclude-dir=.git'
alias less='less -rSFX'

alias :q='exit'

alias vim='nvim'

tabtocsv() {
	sed -i 's/\"/\"\"/g' $1
	sed -i 's/$/\"/g' $1
	sed -i 's/^/\"/g' $1
	sed -i 's/\t/\",\"/g' $1
}
