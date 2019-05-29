call plug#begin(g:plug_repo_dir)

" denite/fzf
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins'}
Plug 'Shougo/neomru.vim'
Plug 'thinca/vim-qfreplace'
Plug 'junegunn/fzf', { 'dir': '$HOME/.fzf', 'do': './install -all' }
Plug 'junegunn/fzf.vim'

" editor display
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'lilydjwg/colorizer'
Plug 'itchyny/vim-parenmatch'
Plug 'mhinz/vim-startify'

" text/input manipulation
Plug 'cohama/lexima.vim'
Plug 'junegunn/vim-easy-align'
Plug 'machakann/vim-highlightedyank'
Plug 'rhysd/accelerated-jk'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-smartword', { 'on': '<Plug>(smartword-' }
Plug 'haya14busa/vim-asterisk', { 'on': '<Plug>(asterisk-' }
Plug 'haya14busa/is.vim', { 'on': '<Plug>(asterisk-' }
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'

" file/directory
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'}
Plug 'mhinz/neovim-remote'

" git
Plug 'tpope/vim-fugitive'

" language support
Plug 'sheerun/vim-polyglot'
Plug 'mechatroner/rainbow_csv', { 'for': 'csv' }
Plug 'tpope/vim-dadbod'
Plug 'editorconfig/editorconfig-vim'

" colorscheme
Plug 'jeetsukumaran/vim-nefertiti'
Plug 'Nequo/vim-allomancer'
Plug 'knt419/lightline-colorscheme-themecolor'

" statusline, except oni, veonim, gonvim
if !exists('g:gui_oni') && !exists('g:veonim') && !exists('g:gonvim_running')
    Plug 'itchyny/lightline.vim'
    Plug 'mgee/lightline-bufferline'
endif

" lsp/completion, except oni, veonim,
if !exists('g:gui_oni') && !exists('g:veonim')
    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
    set completeopt=noinsert,menuone,noselect
    set shortmess+=c
endif

" gonvim
if exists('g:gonvim_running')
    Plug 'akiyosi/gonvim-fuzzy'
    Plug 'equalsraf/neovim-gui-shim'
endif

if !has('win32') && !has('win64')
    Plug 'airblade/vim-rooter'
endif

call plug#end()

if has('conceal')
    set conceallevel=2 concealcursor=i
endif

if exists('g:gui_oni') || exists('g:veonim') || exists('g:gonvim_running')
    set cmdheight=1
    set laststatus=0
endif

" plugin variables

let g:lightline = {
            \ 'colorscheme': 'themecolor',
            \ 'active': {
            \    'left': [
            \      ['mode', 'paste'],
            \      ['readonly', 'cocstatus', 'changes'],
            \    ],
            \    'right': [
            \      ['filetype', 'fileformat', 'fileencoding', 'lineinfo', 'percentage']
            \    ]
            \ },
            \ 'tabline': {
            \   'left': [['buffers']],
            \   'right': [['repostatus','repository']]
            \ },
            \ 'component': {
            \   'lineinfo': "\ue0a1".'%3l:%3v',
            \   'percentage': '%3p%%',
            \ },
            \ 'component_function': {
            \    'readonly': 'LightlineReadonly',
            \    'repository': 'LightlineRepository',
            \    'repostatus': 'LightlineRepoStatus',
            \    'filetype': 'LightlineFiletype',
            \    'fileformat': 'LightlineFileformat',
            \    'changes': 'LightlineChanges',
            \    'cocstatus': 'coc#status'
            \ },
            \ 'component_expand': {
            \   'buffers': 'lightline#bufferline#buffers',
            \ },
            \ 'component_type': {
            \   'buffers': 'tabsel',
            \ },
            \ 'separator': {'left': "\ue0b0", 'right': "\ue0b2"},
            \ 'subseparator': {'left': "\ue0b1", 'right': "\ue0b3"}
            \ }

let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#unicode_symbols = 1

let g:loaded_matchparen          = 1
let g:indentLine_faster          = 1

let g:highlightedyank_highlight_duration = 300

let g:startify_skiplist = [
       \ '*\\AppData\\Local\\Temp\\*',
       \ ]

let g:loaded_netrwPlugin       = 1
let g:fzf_layout               = { 'down': '~70%' }
let g:rooter_change_directory_for_non_project_files = 'home'
let g:startify_change_to_vcs_root                   = 0
let g:startify_change_to_dir                        = 0
let g:startify_fortune_use_unicode                  = 0
let g:startify_enable_unsafe                        = 0

let g:webdevicons_enable                 = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:webdevicons_enable_denite          = 1
let g:webdevicons_enable_startify        = 1

let $VISUAL = 'nvr --remote-wait'

let g:nefertiti_base_brightness_level = 14

let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-yaml']

highlight link HighlightedyankRegion Visual

" plugin keymaps

map *  <Plug>(asterisk-z*)<Plug>(is-nohl-1)
map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
map #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)
map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)
inoremap <silent> <C-l> <C-r>=lexima#insmode#leave(1, '<LT>C-g>U<LT>Right>')<CR>
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
vmap v     <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

nmap w <Plug>(smartword-w)
nmap b <Plug>(smartword-b)
nmap e <Plug>(smartword-e)
nmap ge <Plug>(smartword-ge)
nmap <silent> <S-n> <Plug>(coc-diagnostic-next)
nmap <silent> <S-p> <Plug>(coc-diagnostic-prev)

nnoremap <C-t> :bn<CR>
nnoremap <S-t> :bp<CR>

nnoremap <silent> <Leader>s :<C-u>Startify<CR>
nnoremap <silent> <Leader>e :<C-u>Defx<CR>
nnoremap <silent> <Leader>p :<C-u>History<CR>
nnoremap <silent> <Leader>r :<C-u>GFiles<CR>
nnoremap <silent> <Leader>f :<C-u>Denite file_rec<CR>
nnoremap <silent> <Leader>m :<C-u>Denite file_mru<CR>
nnoremap <silent> <Leader>b :<C-u>Denite buffer<CR>
nnoremap <silent> <Leader>d :<C-u>Denite directory_mru<CR>
nnoremap <silent> <Leader>g :<C-u>Denite grep<CR>
xnoremap <silent> <Leader>f  <Plug>(coc-format-selected)
nnoremap <silent> <Leader>f  <Plug>(coc-format-selected)

vmap <CR> <Plug>(LiveEasyAlign)

imap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ "\<C-r>=lexima#insmode#leave(1, '<LT>Tab>')\<CR>"

if exists('g:veonim')
    " extensions for web dev
    let g:vscode_extensions = [
                \'vscode.typescript-language-features',
                \'vscode.json-language-features',
                \'vscode.css-language-features',
                \'vscode.markdown-language-features',
                \'vscode.html-language-features',
                \'rust-lang.rust',
                \'ms-vscode.go',
                \'ms-python.python',
                \]

    " workspace functions
    nnoremap <silent> <Leader>f :Veonim files<cr>
    nnoremap <silent> <Leader>e :Veonim explorer<cr>
    nnoremap <silent> <Leader>b :Veonim buffers<cr>

    " searching text
    nnoremap <silent> <space>fw :Veonim grep-word<cr>
    vnoremap <silent> <space>fw :Veonim grep-selection<cr>
    nnoremap <silent> <space>fa :Veonim grep<cr>
    nnoremap <silent> <space>ff :Veonim grep-resume<cr>
    nnoremap <silent> <space>fb :Veonim buffer-search<cr>

    " color picker
    nnoremap <silent> sc :Veonim pick-color<cr>

    " language server functions
    nnoremap <silent> sr :Veonim rename<cr>
    nnoremap <silent> sd :Veonim definition<cr>
    nnoremap <silent> st :Veonim type-definition<cr>
    nnoremap <silent> si :Veonim implementation<cr>
    nnoremap <silent> sf :Veonim references<cr>
    nnoremap <silent> sh :Veonim hover<cr>
    nnoremap <silent> sl :Veonim symbols<cr>
    nnoremap <silent> so :Veonim workspace-symbols<cr>
    nnoremap <silent> sq :Veonim code-action<cr>
    nnoremap <silent> sp :Veonim show-problem<cr>
    nnoremap <silent> sk :Veonim highlight<cr>
    nnoremap <silent> sK :Veonim highlight-clear<cr>
    nnoremap <silent> <c-n> :Veonim next-problem<cr>
    nnoremap <silent> <c-p> :Veonim prev-problem<cr>
    nnoremap <silent> ,n :Veonim next-usage<cr>
    nnoremap <silent> ,p :Veonim prev-usage<cr>
    nnoremap <silent> <space>pt :Veonim problems-toggle<cr>
    nnoremap <silent> <space>pf :Veonim problems-focus<cr>
    nnoremap <silent> <d-o> :Veonim buffer-prev<cr>
    nnoremap <silent> <d-i> :Veonim buffer-next<cr>

endif

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" functions

function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ."  ". entry_path'
endfunction

function! LightlineReadonly()
    return &readonly ? "\ue0a2" : ''
endfunction

function! LightlineRepository()
    if !exists("b:git_dir")
        return ''
    endif
    return fnamemodify(FugitiveGitDir(), ":h:t")
endfunction

function! LightlineRepoStatus()
    return exists('g:coc_git_status') ? g:coc_git_status : ''
endfunction

function! LightlineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . '  ' . &filetype : 'no ft') : WebDevIconsGetFileTypeSymbol()
endfunction

function! LightlineChanges()
    return exists('b:coc_git_status') ? b:coc_git_status : ''
endfunction

function! LightlineFileformat()
    return winwidth(0) > 70 ? (WebDevIconsGetFileFormatSymbol() . '  ' . &fileformat) : WebDevIconsGetFileFormatSymbol()
endfunction

function! s:my_denite_replace(context)
    let qflist = []
    for target in a:context['targets']
        if !has_key(target, 'action__path') | continue | endif
        if !has_key(target, 'action__line') | continue | endif
        if !has_key(target, 'action__text') | continue | endif
        call add(qflist, {
                    \ 'filename': target['action__path'],
                    \ 'lnum': target['action__line'],
                    \ 'text': target['action__text']
                    \ })
    endfor
    call setqflist(qflist)
    call qfreplace#start('')
endfunction

function! s:my_cr_function()
    return !pumvisible() ?
                    \ lexima#expand('<CR>', 'i') :
                    \ "\<C-y>"
endfunction

function! s:my_defx_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> <CR> defx#do_action('open')
    nnoremap <silent><buffer><expr> c defx#do_action('copy')
    nnoremap <silent><buffer><expr> m defx#do_action('move')
    nnoremap <silent><buffer><expr> p defx#do_action('paste')
    nnoremap <silent><buffer><expr> l defx#do_action('open')
    nnoremap <silent><buffer><expr> o defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> i defx#do_action('new_file')
    nnoremap <silent><buffer><expr> d defx#do_action('remove')
    nnoremap <silent><buffer><expr> r defx#do_action('rename')
    nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .  defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> h defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
    nnoremap <silent><buffer><expr> q defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> * defx#do_action('toggle_select_all')
endfunction

autocmd MyAutoCmd ColorScheme * :highlight Comment gui=none
autocmd MyAutoCmd FileType go :match goErr /\<err\>/
autocmd MyAutoCmd InsertEnter * inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
autocmd MyAutoCmd InsertLeave * silent! pclose!
autocmd MyAutoCmd FileType defx call s:my_defx_settings()
autocmd MyAutoCmd FileType fzf set laststatus=0 noshowmode noruler
            \| autocmd MyAutoCmd BufLeave <buffer> set laststatus=2 showmode ruler

if &runtimepath =~# 'coc.nvim'
    autocmd MyAutoCmd CursorHold * silent call CocActionAsync('highlight')
endif

if &runtimepath =~# 'denite.nvim'
    call denite#custom#option('default', 'prompt', "\ue62b")

    if executable('rg')
        call denite#custom#var('file_rec', 'command',
                    \ ['rg', '--files', '--glob', '!.git', '--hidden'])
        call denite#custom#var('grep', 'command', ['rg', '--threads', '1', '--hidden'])
        call denite#custom#var('grep', 'default_opts',
                    \ ['--vimgrep', '--no-heading'])
        call denite#custom#var('grep', 'recursive_opts', [])
        call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
        call denite#custom#var('grep', 'separator', ['--'])
        call denite#custom#var('grep', 'final_opts', [])
    else
        call denite#custom#var('file_rec', 'command',
                    \ ['ag', '--follow', '--nocolor', '--nogroup',
                    \  '--hidden', '-g', ''])
        call denite#custom#var('grep', 'command', ['ag'])
        call denite#custom#var('grep', 'default_opts',
                    \ ['-i', '--vimgrep'])
        call denite#custom#var('grep', 'recursive_opts', [])
        call denite#custom#var('grep', 'pattern_opt', [])
        call denite#custom#var('grep', 'separator', ['--'])
        call denite#custom#var('grep', 'final_opts', [])
    endif

    call denite#custom#map('insert', '<ESC>', '<denite:enter_mode:normal>')
    call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>')
    call denite#custom#map('insert', '<Tab>', '<denite:move_to_next_line>')
    call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>')
    call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>')
    call denite#custom#map('insert', '<S-Tab>', '<denite:move_to_previous_line>')
    call denite#custom#map('insert', '<Up>', '<denite:move_to_previous_line>')
    call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>')
    call denite#custom#map('normal', 'v', '<denite:do_action:vsplit>')
    call denite#custom#map('normal', '<Leader><Leader>', '<denite:toggle_select_all>')
    call denite#custom#map('normal', 'r', '<denite:do_action:qfreplace>')
    call denite#custom#map('normal', '<ESC>', '<denite:quit>')
    call denite#custom#source('file_mru', 'matchers', ['matcher_fuzzy', 'matcher_ignore_globs'])
    call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',['*://*', '*~', '*.(o|exe|bak|pyc|sw[po]|class)'])
    call denite#custom#action('file', 'qfreplace', function('s:my_denite_replace'))
endif

