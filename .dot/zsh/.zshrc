#!/usr/bin/env zsh
#!/bin/zsh
#   ______    _
#  |___  /   | |
#     / / ___| |__  _ __ ___
#    / / / __| '_ \| '__/ __|
#  ./ /__\__ \ | | | | | (__
#  \_____/___/_| |_|_|  \___|
#

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

  logfile=$(mktemp "$ZSH_CACHE_DIR/xtrace"/zsh_xtrace.XXXXXXXX)
  exec 3>&2 2>$logfile

  setopt XTRACE PROMPT_SUBST
fi

#
# Zprofile
#
if [[ "$ZSH_PROFILE" = true ]]; then
  LC_NUMERIC="en_US.UTF-8" zprof | awk 'NR == 3 { print "Startup Time: ", $3/$8*100, "ms"}'
  now=$(date +"%Y-%m-%d_%H:%M:%S")
  LC_NUMERIC="en_US.UTF-8" zprof >> $ZSH_CACHE_DIR/zprof/$now.zprofile
fi
#
# Ztrace
#
if [[ "$ZSH_XTRACE" = true ]]; then
  unsetopt XTRACE
  exec 2>&3 3>&-
fi
