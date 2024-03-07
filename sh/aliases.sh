#!/bin/sh

export LESS='RSFXm'
alias j='jobs'

alias ag='ag --pager="less"'
rg() {
	if [ -t 1 ]; then
		command rg -p "$@" | less
	else
		command rg "$@"
	fi
}

alias :q='exit'
alias myvim='nvim +"set filetype=sql"'
alias dc='docker compose'
alias fd='fdfind'

tabtocsv() {
	sed -i 's/\"/\"\"/g' $1
	sed -i 's/$/\"/g' $1
	sed -i 's/^/\"/g' $1
	sed -i 's/\t/\",\"/g' $1
}
