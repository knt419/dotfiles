if exists('g:GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Font', 'CaskaydiaCove NFM 13')
endif

" local
if filereadable(expand('$HOME/.config/nvim/ginit.vim.local'))
    source $HOME/.config/nvim/ginit.vim.local
endif
