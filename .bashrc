# include
[ -f $HOME/.bashrc_local ]        && source $HOME/.bashrc_local
[ -f $HOME/.git-completion.bash ] && source $HOME/.git-completion.bash
[ -f $HOME/.git-prompt.sh ]       && source $HOME/.git-prompt.sh
[ -f $HOME/.bashrc_local ]        && source $HOME/.bashrc_local
[ -f $HOME/.fzf.bash ]            && source $HOME/.fzf.bash
[ -f $HOME/enhancd/init.sh ]      && source $HOME/enhancd/init.sh

# export BASE16_SHELL=$HOME/.config/base16-shell/
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# env
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export FZF_DEFAULT_COMMAND='ag --follow --nocolor --nogroup --hidden -g ""'
export FZF_DEFAULT_OPTS='--reverse --ansi --select-1 --exit-0'
export FZF_COMPLETION_TRIGGER=',,'
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# bash option
shopt -s autocd
set -o vi

# alias
if [ "$(uname)" == 'Darwin' ]; then
    alias ls='ls -FG'
else
    alias ls='ls --show-control-chars -F --color --ignore={NTUSER.*,ntuser.*}'
fi
alias ...='cd ../..'
alias ....='cd ../../..'
alias vi=nvim


# command

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}


