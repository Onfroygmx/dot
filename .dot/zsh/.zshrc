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

#
# Zprofile
#
# To launch:
# ZSH_PROFILE=true zsh -ic zprof
if [[ "$ZSH_PROFILE" = true ]]; then
  [[ ! -d "$ZSH_CACHE_DIR/zprof" ]] && mkdir -p "$ZSH_CACHE_DIR/zprof"
  zmodload zsh/zprof
fi
#
# Ztrace
#
# To launch:
# ZSH_XTRACE=true zsh
if [[ "$ZSH_XTRACE" = true ]]; then
  [[ ! -d "$ZSH_CACHE_DIR/xtrace" ]] && mkdir -p "$ZSH_CACHE_DIR/xtrace"
  (( ${+EPOCHREALTIME} )) || zmodload zsh/datetime

  PS4='+$EPOCHREALTIME %N:%i> '

  tracefile=$(mktemp "$ZSH_CACHE_DIR/xtrace"/zsh_xtrace.XXXXXXXX)
  exec 3>&2 2>$tracefile

  setopt XTRACE PROMPT_SUBST
fi


PROMPT='%F{green}%n%f %F{cyan}%(4~|%-1~/.../%2~|%~)%f %F{magenta}%B>%b%f '
RPROMPT='%(?.%F{green}.%F{red}[%?] - )%B%D{%H:%M:%S}%b%f'

source $PLUGIN_DIR/zmod/zmod.zsh

#declare -A MODULES
MODULES=(
  aliases
#  history
#  colored-man
#  dircolor
  completions
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

#
# Zprofile
#
if [[ "$ZSH_PROFILE" = true ]]; then
  LC_NUMERIC="en_US.UTF-8" zprof | awk 'NR == 3 { print "Startup Time: ", $3/$8*100, "ms"}'
  now=$(date +"%Y-%m-%d_%H:%M:%S")
  prof_file=$ZSH_CACHE_DIR/zprof/$now.zprofile
  LC_NUMERIC="en_US.UTF-8" zprof >> $prof_file
  print -P "Profile logged to: %F{yellow}${prof_file}%f"
fi
#
# Ztrace
#
if [[ "$ZSH_XTRACE" = true ]]; then
  unsetopt XTRACE
  exec 2>&3 3>&-
  print -P "Trace logged to: %F{yellow}${tracefile}%f"
fi

STARTUP_Z=$EPOCHREALTIME
