if exists('g:GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Font', 'HackGen35Console 14')
else
    GuiTabline 0
    GuiPopupmenu 0
    call GuiWindowMaximized(1)
endif

" local
if filereadable(expand('$HOME/.config/nvim/ginit.vim.local'))
    source $HOME/.config/nvim/ginit.vim.local
endif
