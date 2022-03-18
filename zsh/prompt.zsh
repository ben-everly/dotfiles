PROMPT=''
if [ "$EUID" -eq 0 ]; then
	PROMPT+="%{$fg[red]%}"
else
	PROMPT+="%{$fg[green]%}"
fi
PROMPT+="%n%{$FG[245]%}@"
if [ "$SSH_TTY" ]; then
	PROMPT+="%{$fg[red]%}"
else
	PROMPT+="%{$fg[yellow]%}"
fi
PROMPT+="%M%{$FG[245]%}:%{$fg[cyan]%}%~%{$FG[245]%}$%{$reset_color%} "

git_prompt() {
    local branch=''
    if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
        if [ "$branch" "==" "HEAD" ]; then
            branch='detached*'
            local tag="[$(git describe --tags)]"
        fi
        echo "%{$fg_bold[magenta]%}[$branch]$tag%{$reset_color%}"
    fi
}

function vi_mode_prompt() {
    local VIM_NORMAL="%{$fg_bold[yellow]%}[NORMAL]%{$reset_color%}"
    local VIM_INSERT="%{$fg_bold[green]%}[INSERT]%{$reset_color%}"
    echo "${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
}

function zle-line-init zle-keymap-select {
    RPS1="$(git_prompt)$(vi_mode_prompt)"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
