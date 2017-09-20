if [ -f $HOME/.bashrc_local ]; then
    . $HOME/.bashrc_local
fi
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
alias ls='ls --show-control-chars -F --color --ignore={NTUSER.*,ntuser.*}'
alias ..='cd ..'
alias ...='cd ../..'
alias vi=nvim
