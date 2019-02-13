# include
[ -f $HOME/.git-completion.bash ] && source $HOME/.git-completion.bash
[ -f $HOME/.git-prompt.sh ]       && source $HOME/.git-prompt.sh
[ -f $HOME/.fzf.bash ]            && source $HOME/.fzf.bash
[ -f $HOME/enhancd/init.sh ]      && source $HOME/enhancd/init.sh
[ -f $HOME/.cargo/env ]           && source $HOME/.cargo/env

# env
export PS1=$'\[\e[30;104;1m\] \u@\h \[\e[0m\e[94;47m\]\ue0b0 \[\e[30;47m\]\w \ue0b1 `git rev-parse --abbrev-ref HEAD 2>/dev/null` \[\e[0m\e[37m\]\ue0b0\n\[\e[94;1m\]$ \[\e[0m\]'
if [ -f $HOME/.git-prompt.sh ]; then
    export GIT_PS1_SHOWCOLORHINTS=true
    export GIT_PS1_SHOWUPSTREAM=true
    export PS1=$'\[\e[30;104m\] \u@\h \[\e[0m\e[94;47m\]\ue0b0\[\e[30;47m\] \w \ue0b1$(__git_ps1) \[\e[0m\e[37m\]\ue0b0\n\[\e[94;1m\]$ \[\e[0m\]'
fi
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN:$HOME/.cargo/bin
if type rg >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
else
    export FZF_DEFAULT_COMMAND='ag --follow --nocolor --nogroup --hidden -g ""'
fi
export FZF_DEFAULT_OPTS='--reverse --ansi --select-1 --exit-0'
export FZF_COMPLETION_TRIGGER=',,'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# bash option
shopt -s autocd
set -o vi

# alias
if [ "$(uname)" == 'Darwin' ] || [ "$(uname)" == 'Linux' ]; then
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

# gd - cd to selected local repository
gd() {
    local dir
    dir=$(ghq list --full-path | fzf +m) &&
        cd "$dir"
    }

# local
[ -f $HOME/.bashrc_local ]        && source $HOME/.bashrc_local
