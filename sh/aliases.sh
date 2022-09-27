#!/bin/sh

export LESS='RSFXm'
alias la='l'

alias ag='ag --pager="less"'

alias :q='exit'

alias myvim='nvim +"set filetype=mysql"'

alias dc='docker-compose'

alias xml='xmlstarlet'
alias xmlformat='xml format'
alias jsonformat='jq'
alias sqlformat='sql-formatter-cli'

tabtocsv() {
	sed -i 's/\"/\"\"/g' $1
	sed -i 's/$/\"/g' $1
	sed -i 's/^/\"/g' $1
	sed -i 's/\t/\",\"/g' $1
}
