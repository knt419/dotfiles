if exists('g:GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Font', 'Ricty 14')
else
    Guifont! Ricty:h14
    GuiTabline 0
    GuiPopupmenu 0
    call GuiWindowMaximized(1)
endif

" local
if filereadable(expand('$HOME/.config/nvim/ginit.vim.local'))
    source $HOME/.config/nvim/ginit.vim.local
endif
