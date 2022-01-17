#!/usr/bin/env zsh

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
