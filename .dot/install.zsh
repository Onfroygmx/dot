#!/usr/bin/env zsh
#!/bin/zsh
#   _____          _        _ _
#  |_   _|        | |      | | |
#    | | _ __  ___| |_ __ _| | |
#    | || '_ \/ __| __/ _` | | |
#   _| || | | \__ \ || (_| | | |
#   \___/_| |_|___/\__\__,_|_|_|
#
# https://patorjk.com/software/taag/#p=display&c=bash&f=Doom&t=Install
### Install basic tools
## zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Onfroygmx/dot/master/.dot/install.zsh)"
## curl -fsSL https://raw.githubusercontent.com/Onfroygmx/dot/master/.dot/install.zsh | zsh

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

# Define other variables
PLUGIN_DIR="$XDG_CONFIG_HOME/plugins"
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
LESSHISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/less/history"
MYSQL_HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/mysql/history"

function zcompile-many() {
  local f
  for f; do zcompile -R -- "$f".zwc "$f"; done
}

printf "\n$fg[cyan]Create dot structure$reset_color\n"


printf "$fg[green]Clone: Onfroygmx/dot$reset_color\n"
git clone --bare https://github.com/Onfroygmx/dot.git $HOME/.dotgit
git --git-dir=$HOME/.dotgit --work-tree=$HOME checkout

printf "\n$fg[green]Create other folders$reset_color\n"
# Create other dir
[[ ! -d "$PLUGIN_DIR" ]] && mkdir -pv $PLUGIN_DIR
[[ ! -d "$XDG_DATA_HOME" ]] && mkdir -pv $XDG_DATA_HOME

printf "\n$fg[yellow]Create directory file structure for history management$reset_color\n"
## Create history files and folders
# $HISTFILE belongs in the data home, not with the configs
if [[ ! -f "$HISTFILE" ]]; then
    mkdir -pv "$HISTFILE:h" && touch "$HISTFILE"
fi
if [[ ! -f "$LESSHISTFILE" ]]; then
    mkdir -pv "$LESSHISTFILE:h" && touch "$LESSHISTFILE"
fi
if [[ ! -f "$MYSQL_HISTFILE" ]]; then
    mkdir -pv "$MYSQL_HISTFILE:h" && touch "$MYSQL_HISTFILE"
fi

printf "\n$fg[green]Set permission 700 to all created folders and move bare repository$reset_color\n"
find $XDG_CONFIG_HOME -type d -print0 | xargs -0 chmod -v 700
mv -v .dotgit $XDG_CONFIG_HOME

printf "\n$fg[green]Link config files to root folder$reset_color\n"
# Link configuration files to correct place
ln -sv $ZDOTDIR/zshenv $HOME/.zshenv
ln -sv $XDG_CONFIG_HOME/cfg/nano/nanorc $HOME/.nanorc
ln -sv $XDG_CONFIG_HOME/cfg/git/gitconfig $HOME/.gitconfig
ln -sv $XDG_CONFIG_HOME/cfg/git/gitmessage $HOME/.gitmessage
ln -sv $XDG_CONFIG_HOME/cfg/git/gitignore_global $HOME/.gitignore_global


printf "\n$fg[green]Clone external Plugins$reset_color\n"

PLUGINS=(
    zchee/zsh-completions
    zsh-users/zsh-completions
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-history-substring-search
)

printf "$fg[yellow]Clone: zmod$reset_color\n"
git clone https://github.com/Onfroygmx/zmod.git $PLUGIN_DIR/zmod

printf "\n$fg[yellow]Clone: scopatz/nanorc$reset_color\n"
git clone --depth 1 https://github.com/scopatz/nanorc.git $PLUGIN_DIR/nano-syntax-highighting

for plug in $PLUGINS; do
    printf "\n$fg[yellow]Clone: $plug$reset_color\n"
    git clone --depth 1 https://github.com/$plug.git $PLUGIN_DIR/$plug
done

printf "\n$fg[green]Compile all source files in $PLUGIN_DIR folder$reset_color\n"
zcompile-many $PLUGIN_DIR/zmod/zmod.zsh
zcompile-many $PLUGIN_DIR/zsh-users/zsh-syntax-highlighting/{zsh-syntax-highlighting.zsh,highlighters/*/*.zsh}
zcompile-many $PLUGIN_DIR/zsh-users/zsh-autosuggestions/{zsh-autosuggestions.zsh,src/**/*.zsh}
zcompile-many $PLUGIN_DIR/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh


printf "\n$fg[cyan]Install fininshed, restart ZSH$reset_color\n"
