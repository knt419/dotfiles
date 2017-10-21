# include
[ -f $HOME/.bashrc_local ] && source $HOME/.bashrc_local
[ -f $HOME/.fzf.bash ]     && source $HOME/.fzf.bash

# env
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--reverse --ansi --select-1 --exit-0'

# alias
alias ls='ls --show-control-chars -F --color --ignore={NTUSER.*,ntuser.*}'
alias ..='cd ..'
alias ...='cd ../..'
alias vi=nvim


# command

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
