#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# HISTORY
HISTSIZE=1000
HISTFILESIZE=2000
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend

# COLOUR
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ALIASES
for i in $(find ~/.config/aliases -mindepth 1 -maxdepth 1 -type f); do source "$i"; done

# COMPLETIONS
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi
for cmp in /home/linuxbrew/.linuxbrew/etc/bash_completion.d/*; do source "$cmp"; done

command -v starship &> /dev/null && eval "$(starship init bash)"
command -v zoxide &> /dev/null && eval "$(zoxide init bash)"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# OTHERS
unset PROMPT_COMMAND # Workaround for VSCode Remote SSH Extension + tmux
