#!/usr/bin/env zsh

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
