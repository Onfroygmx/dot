#!/usr/bin/env zsh
#!/bin/zsh

#Source plugin files
for plug in $PLUGINS; do
  zmod load "$ZDOTDIR/plugins.d/${plug:t}.zsh" "$plug"
done

autoload -Uz compinit
@zcompinit "$ZSH_COMPDUMP"
