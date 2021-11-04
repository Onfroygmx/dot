#!/usr/bin/env zsh

zmodload zsh/complist
zmodload zsh/computil


setopt complete_in_word     # Complete from both ends of a word.
setopt always_to_end        # Move cursor to the end of a completed word.
setopt auto_menu            # Show completion menu on a successive tab press.
setopt auto_list            # Automatically list choices on ambiguous completion.
setopt auto_param_flash     # If completed parameter is a directory, add a trailing slash.
setopt extended_glob        # Needed for file modification glob modifiers with compinit.
unsetopt menu_complete      # Do not autoselect the first completion entry.
#unsetopt flow_control      # Disable start/stop characters in shell editor.
#setopt path_dirs           # Perform path search even on command names with slashes.

ZSH_CACHE=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache
# Enable completion caching & store cache file
zstyle ':completion:*'              cache-path $ZSH_CACHE
zstyle ':completion:*'              use-cache true

zstyle ':completion:*'              squeeze-slashes true
zstyle ':completion:*'              insert-tab true
zstyle ':completion:*'              expand yes
# case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*'              matcher-list "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=*" "l:|=* r:|=*"
zstyle ':completion:*'              list-colors ""
zstyle ':completion:*'              menu select=2 _complete _ignored _approximate
zstyle ':completion:*'              group-name ''
zstyle ':completion:*'              verbose yes
zstyle ':completion:*'              special-dirs true



# Use ls-colors for completions
function _set-list-colors() {
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
	unfunction _set-list-colors
}
sched 0 _set-list-colors  # deferred since LC_COLORS might not be available yet
