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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
