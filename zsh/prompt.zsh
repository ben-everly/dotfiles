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
        printf "\n${fg_bold[magenta]}[%s]%s\n" $branch $tag
    fi
}

export PROMPT_COMMAND="git_prompt;"
