if exists('g:GtkGuiLoaded')
    call rpcnotify(1, 'Gui', 'Font', 'Ricty 14')
else
    Guifont! Ricty:h14
    GuiTabline 0
endif

