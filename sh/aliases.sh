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
alias nvimsql='nvim +"set filetype=sql"'
alias dc='docker compose'
alias fd='fdfind'

tabtocsv() {
	sed -i 's/\"/\"\"/g' $1
	sed -i 's/$/\"/g' $1
	sed -i 's/^/\"/g' $1
	sed -i 's/\t/\",\"/g' $1
}

# Auto-connect claude to a running claudecode.nvim
claude() {
	local lockdir="$HOME/.claude/ide" cwd="$PWD"
	local lock pid folder len mtime best_port="" best_len=-1 best_mtime=-1

	for lock in $(find "$lockdir" -maxdepth 1 -name '*.lock' -type f 2>/dev/null); do
		pid=$(jq -r '.pid // empty' "$lock" 2>/dev/null)
		[ -n "$pid" ] && kill -0 "$pid" 2>/dev/null || continue

		while IFS= read -r folder; do
			[ -n "$folder" ] || continue
			case "$cwd" in
				"$folder"|"$folder"/*)
					len=${#folder}
					mtime=$(stat -c %Y "$lock" 2>/dev/null || echo 0)
					if [ "$len" -gt "$best_len" ] || { [ "$len" -eq "$best_len" ] && [ "$mtime" -gt "$best_mtime" ]; }; then
						best_len=$len
						best_mtime=$mtime
						best_port=$(basename "$lock" .lock)
					fi
					;;
			esac
		done < <(jq -r '.workspaceFolders[]?' "$lock" 2>/dev/null)
	done

	if [ -n "$best_port" ]; then
		CLAUDE_CODE_SSE_PORT="$best_port" ENABLE_IDE_INTEGRATION=true command claude "$@"
	else
		command claude "$@"
	fi
}
