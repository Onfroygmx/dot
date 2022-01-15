#!/usr/bin/env zsh
#!/bin/zsh
#          _ _
#     __ _| (_) __ _ ___  ___  ___
#    / _` | | |/ _` / __|/ _ \/ __|
#   | (_| | | | (_| \__ \  __/\__ \
#    \__,_|_|_|\__,_|___/\___||___/
#

## LS
alias ls='ls --color=auto --group-directories-first -F'
alias ll='ls --time-style=+"%d.%m.%Y %H:%M" -l'
alias la='ll -avh'

# Quickly edit some files
alias zshrc='nano $ZDOTDIR/.zshrc'

# Enable colors for some commands
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ip='ip --color=auto'
alias tree='tree -C'

# Enable ignore list for tree
alias treeclean='tree -ahC -I "$(paste -d\| -s $MODULE_DIR/aliases/.treeignore)" --dirsfirst'
alias treedir='tree -adhpC -I "$(paste -d\| -s $MODULE_DIR/aliases/.treeignore)"'

## Base operation with security
alias cp='cp -iv'       # Confirm before overwriting something
alias mv='mv -iv'       # Confirm before overwriting something
alias rm='rm -iv'       # Confirm before deleting anything
alias chmod='chmod --preserve-root -v'
alias chown='chown --preserve-root -v'

# Ccopy and download
alias pcp='rsync -r --progress'     # Copy with progress bar and speed
alias pch='rsync -ah --progress'    # Copy with progress bar and speed
alias wget='wget --continue --progress=bar --timestamping'
alias curl='curl --continue-at - --location --progress-bar --remote-name --remote-time'

# utilities
showpath() print -rC1 -- $path
#(( $+commands[tree]  )) && alias tree='tree -a -I .git --dirsfirst'

# Lists the ten most used commands.
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
#alias history-statc="fc -l 1 | awk '{ CMD[$2]++; count++; } END { for (a in CMD) print CMD[a] " " CMD[a]*100/count "% " a }' | grep -v "./" | sort -nr | head -20 | column -c3 -s " " -t | nl"

# Home bare repository for git/tree operations
alias dot='git --git-dir=$XDG_CONFIG_HOME/.dotgit/ --work-tree=$HOME'
alias treedot='tree -ahC -L 4 --dirsfirst -I .dotgit $XDG_CONFIG_HOME'
alias treedotclean='treedot -I completions\|.dotgit\|zmod'
alias backupdot='tar -cvjf /Volumes/DATA/BACKUP/dotfile/dotfile-$(date +%Y-%m-%d_%H-%M-%S).tar.gz .dot'
