#!/usr/bin/env zsh
#!/bin/zsh
#   _____          _        _ _
#  |_   _|        | |      | | |
#    | | _ __  ___| |_ __ _| | |
#    | || '_ \/ __| __/ _` | | |
#   _| || | | \__ \ || (_| | | |
#   \___/_| |_|___/\__\__,_|_|_|
#
### Install base
## curl -fsSL https://raw.githubusercontent.com/Onfroygmx/dot/main/.dot/install.zsh | zsh

## Autoload zsh functions
#################################################
autoload -U colors && colors

## Export work folders
#################################################
export XDG_CONFIG_HOME=$HOME/.dot
export XDG_DATA_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"/data

# ZSH specifi dirs
export ZDOTDIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"/zsh

export PLUGIN_DIR="$XDG_CONFIG_HOME/plugins"

function zcompile-many() {
  local f
  for f; do zcompile -R -- "$f".zwc "$f"; done
}

printf "\n$fg[cyan]Create dot structure$reset_color\n"
printf "$fg[yellow]Clone: Onfroygmx/dot$reset_color\n"
git clone --bare https://github.com/Onfroygmx/dot.git $HOME/.dotgit
git --git-dir=$HOME/.dotgit --work-tree=$HOME checkout

printf "\n$fg[yellow]Create other folders$reset_color\n"
# Create other dir
[[ ! -d "$PLUGIN_DIR" ]] && mkdir -pv $PLUGIN_DIR
[[ ! -d "$XDG_DATA_HOME" ]] && mkdir -pv $XDG_DATA_HOME

printf "\n$fg[yellow]Set permission 700 to all created folders$reset_color\n"
find $XDG_CONFIG_HOME -type d -print0 | xargs -0 chmod -v 700

printf "\n$fg[yellow]Move bare repo$reset_color\n"
mv -v .dotgit $XDG_CONFIG_HOME


printf "\n$fg[cyan]Clone external Plugins$reset_color\n"
printf "$fg[yellow]Clone: zmod$reset_color\n"
git clone https://github.com/Onfroygmx/zmod.git $PLUGIN_DIR/zmod

printf "\n$fg[yellow]Clone: scopatz/nanorc$reset_color\n"
git clone --depth 1 https://github.com/scopatz/nanorc.git $PLUGIN_DIR/nano-syntax-highighting


printf "\n$fg[cyan]Setup environment files$reset_color\n"
printf "$fg[yellow]Link config files to root folder$reset_color\n"
## Set zshenv file
[[ ! -f $HOME/.zshenv && -f $ZDOTDIR/zshenv ]] && ln -sv $ZDOTDIR/zshenv $HOME/.zshenv
# Link configuration files to correct place
ln -sv $XDG_CONFIG_HOME/cfg/nano/nanorc $HOME/.nanorc
ln -sv $XDG_CONFIG_HOME/cfg/git/gitconfig $HOME/.gitconfig

printf "\n$fg[yellow]Setup local git for dot files$reset_color\n"
git dot config --local user.name "dotOnf"
git dot config --local credential.helper 'store --file $XDG_CONFIG_HOME/cfg/git/git-credentials'

printf "\n$fg[yellow]Create firectory file structure for history management$reset_color\n"
# $HISTFILE(S) belongs in the data home, not with the configs
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
LESSHISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/less/history"
MYSQL_HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/mysql/history"
## Create history files and folders if does not exist.
if [[ ! -f "$HISTFILE" ]]; then
    mkdir -pv "$HISTFILE:h" && touch "$HISTFILE"
fi
if [[ ! -f "$LESSHISTFILE" ]]; then
    mkdir -pv "$LESSHISTFILE:h" && touch "$LESSHISTFILE"
fi
if [[ ! -f "$MYSQL_HISTFILE" ]]; then
    mkdir -pv "$MYSQL_HISTFILE:h" && touch "$MYSQL_HISTFILE"
fi

printf "\n$fg[yellow]Compile all source files in $PLUGIN_DIR folder$reset_color\n"
zcompile-many $PLUGIN_DIR/zmod/zmod.zsh


printf "\n$fg[green]Install fininshed, restart ZSH$reset_color\n"
