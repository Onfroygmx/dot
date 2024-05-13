#!/usr/bin/env zsh
#!/bin/zsh
#   ______    _
#  |___  /   | |
#     / / ___| |__  _ __ ___
#    / / / __| '_ \| '__/ __|
#  ./ /__\__ \ | | | | | (__
#  \_____/___/_| |_|_|  \___|
#

setopt no_beep

# Debug
# source $MODULE_DIR/debug/debug_on.zsh

PROMPT='%F{green}%n%f %F{cyan}%(4~|%-1~/.../%2~|%~)%f %F{magenta}%B>%b%f '
RPROMPT='%(?.%F{green}.%F{red}[%?] - )%B%D{%H:%M:%S}%b%f'

source $PLUGIN_DIR/zmod/zmod.zsh

#declare -A MODULES
MODULES=(
  aliases
  history
  colored-man
  dircolor
  completions
  broot
)

PLUGINS=(
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-history-substring-search
)

# Source module files
for module in $MODULES; do
  zmod load "$MODULE_DIR/$module/$module.zsh" "module/$module"
done

# Debug
# source $MODULE_DIR/debug/debug_off.zsh

STARTUP_Z=$EPOCHREALTIME

# source /Users/onf/.config/broot/launcher/bash/br
