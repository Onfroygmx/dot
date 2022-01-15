#!/usr/bin/env zshé
#!/bin/zsh

builtin source $PLUGIN_DIR/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh

# Set history search options
HISTORY_SUBSTRING_SEARCH_FUZZY=set
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=set

# Bind ^[[A/^[[B for history search after sourcing the file
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

OS=$(uname -s)
if [ "$OS" = "Darwin" ]; then
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
elif [ "$OS" = "Linux" ]; then
    # https://superuser.com/a/1296543
    # key dict is defined in /etc/zsh/zshrc
    bindkey "$key[Up]" history-substring-search-up
    bindkey "$key[Down]" history-substring-search-down
fi
