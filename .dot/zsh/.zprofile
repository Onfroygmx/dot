#!/usr/bin/env zsh
#!/bin/zsh
#   ______                 __ _ _
#  |___  /                / _(_) |
#     / / _ __  _ __ ___ | |_ _| | ___
#    / / | '_ \| '__/ _ \|  _| | |/ _ \
#  ./ /__| |_) | | | (_) | | | | |  __/
#  \_____/ .__/|_|  \___/|_| |_|_|\___|
#        | |
#        |_|
#
## This file is sourced before zshrc

###############################
# EXPORT ENVIRONMENT VARIABLE #
###############################

# Set specific path variables
MODULE_DIR=$ZDOTDIR/modules
PLUGIN_DIR=$XDG_CONFIG_HOME/plugins

# editor
export EDITOR='nano'
export VISUAL='nano'
export PAGER='less'
# Set the default Less options.
# -i: Causes searches to ignore case
# -M: Causes less to prompt even more verbosely than more.
# -R: Like -r, but only ANSI "color" escape sequences are output in "raw" form, the screen appearance is maintained.
# -S: Causes lines longer than the screen width to be truncated rather than wrapped.
# z-4: if the screen is x lines, -z-4 sets the scrolling window to x-4 lines.
export LESS='-i -M -R -S -z-4'


################################
# Set PATHS #
################################

# Add completion add the begining of fpath and custom functions at the end
fpath=( "$PLUGIN_DIR/zsh-users/zsh-completions/src" "${fpath[@]}" )

# Set the list of directories that man searches for manuals.
manpath=(
  /usr/local/share/man
  /usr/share/man
  $manpath
)

# Set standard path
path=(
  /usr/local/{sbin,bin}
  /usr/{sbin,bin}
  /{sbin,bin}
  ~/bin
  $path
)

case $OSTYPE in
	darwin*)
		source $ZDOTDIR/zprofile.darwin
		;;
	linux-gnu*)
		source $ZDOTDIR/zprofile.linux
		;;
esac

# Ensure path arrays do not contain duplicates.
typeset -gU fpath manpath path FPATH MANPATH PATH
