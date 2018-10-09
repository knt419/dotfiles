call plug#begin(g:plug_repo_dir)

Plug 'Shougo/denite.nvim'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/neosnippet'
Plug 'honza/vim-snippets'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neco-syntax'
Plug 'Chiel92/vim-autoformat'
Plug 'thinca/vim-qfreplace'
Plug 'brooth/far.vim', { 'on': ['Far','Farp'] }
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'lilydjwg/colorizer'
Plug 'itchyny/vim-parenmatch'
Plug 'mhinz/vim-startify'
Plug 'w0rp/ale'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'cohama/lexima.vim'
Plug 'junegunn/vim-easy-align'
Plug 'rhysd/accelerated-jk'
Plug 'kana/vim-smartword', { 'on': '<Plug>(smartword-' }
Plug 'haya14busa/vim-asterisk', { 'on': '<Plug>(asterisk-' }
Plug 'haya14busa/is.vim', { 'on': '<Plug>(asterisk-' }
Plug 'terryma/vim-multiple-cursors'
Plug 'cocopon/vaffle.vim'
Plug 'airblade/vim-rooter'
Plug 'mhinz/neovim-remote'
Plug 'lambdalisue/gina.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'mechatroner/rainbow_csv', { 'for': 'csv' }

" Plug 'rhysd/try-colorscheme.vim', { 'on': 'TryColorscheme' }
" Plug 'y0za/vim-reading-vimrc', { 'on': ['ReadingVimrcList', 'ReadingVimrcLoad', 'ReadingVimrcNext'] }
" Plug 'cocopon/colorswatch.vim'

" Plug 'AlessandroYorba/Alduin'
Plug 'jeetsukumaran/vim-nefertiti'

if has('win32') || has('win64')
    Plug 'junegunn/fzf', { 'dir': '$HOME/.fzf', 'do': './install -all' }
    Plug 'junegunn/fzf.vim'
    autocmd! FileType fzf
    autocmd FileType fzf set laststatus=0 noshowmode noruler
                \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
else
    Plug 'lotabout/skim', { 'dir': '$HOME/.skim', 'do': './install' }
    Plug 'lotabout/skim.vim'
    autocmd! FileType skim
    autocmd FileType skim set laststatus=0 noshowmode noruler
                \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endif

if !exists('g:gui_oni')
    Plug 'itchyny/lightline.vim'
    Plug 'mgee/lightline-bufferline'
    Plug 'maximbaz/lightline-ale'
    " Plug 'shinchu/lightline-gruvbox.vim'
    Plug 'tpope/vim-surround'
    Plug 'Shougo/deoplete.nvim'
    Plug 'zchee/deoplete-go', { 'do': 'make' }
    Plug 'zchee/deoplete-jedi', { 'for': 'python' }
    Plug 'Shougo/neco-vim', { 'for': 'vim' }
    Plug 'tpope/vim-commentary'
endif

if exists('g:nyaovim_version')
    Plug 'rhysd/nyaovim-popup-tooltip'
    Plug 'rhysd/nyaovim-markdown-preview'
    Plug 'rhysd/nyaovim-mini-browser'
endif

call plug#end()

if has('conceal')
    set conceallevel=2 concealcursor=i
endif

if !exists('g:gui_oni')
    source $HOME/.config/nvim/lightline-themecolor.vim
endif

" plugin variables

let g:lightline = {
            \ 'colorscheme': 'themecolor',
            \ 'active': {
            \    'left': [
            \      ['mode', 'paste'],
            \      ['readonly', 'modified', 'linter_errors', 'linter_warnings', 'linter_ok'],
            \    ],
            \    'right': [
            \      ['filetype', 'fileformat', 'fileencoding', 'lineinfo', 'percentage']
            \    ]
            \ },
            \ 'tabline': {
            \   'left': [['buffers']],
            \   'right': [['repostatus','branch','repository']]
            \ },
            \ 'component': {
            \   'lineinfo': "\ue0a1".'%2l:%2v',
            \   'percentage': '%p%%'
            \ },
            \ 'component_function': {
            \    'readonly': 'LightlineReadonly',
            \    'repository': 'gina#component#repo#name',
            \    'branch': 'LightlineBranch',
            \    'bufferinfo': 'lightline#buffer#bufferinfo',
            \    'repostatus': 'LightlineRepoStatus',
            \    'filetype': 'LightlineFiletype',
            \    'fileformat': 'LightlineFileformat'
            \ },
            \ 'component_expand': {
            \   'buffers': 'lightline#bufferline#buffers',
            \   'linter_warnings': 'lightline#ale#warnings',
            \   'linter_errors': 'lightline#ale#errors',
            \   'linter_ok': 'lightline#ale#ok'
            \ },
            \ 'component_type': {
            \   'buffers': 'tabsel',
            \   'linter_warnings': 'warning',
            \   'linter_errors': 'error'
            \ },
            \ 'separator': {'left': "\ue0b0", 'right': "\ue0b2"},
            \ 'subseparator': {'left': "\ue0b1", 'right': "\ue0b3"}
            \ }

let g:loaded_matchparen          = 1

let g:highlightedyank_highlight_duration = 300

let g:ale_linters = {
            \ 'ruby': ['rubocop'],
            \ }
let g:ale_fixers = {
            \ 'ruby': ['rubocop'],
            \ 'go': ['gofmt'],
            \ }

let g:vaffle_show_hidden_files = 1
let g:loaded_netrwPlugin       = 1
let g:fzf_layout               = { 'down': '~70%' }
let g:rooter_change_directory_for_non_project_files = 'home'

let g:go_hightlight_functions         = 1
let g:go_hightlight_methods           = 1
let g:go_hightlight_structs           = 1
let g:go_hightlight_interfaces        = 1
let g:go_hightlight_operators         = 1
let g:go_hightlight_build_constraints = 1
let g:go_fmt_command                  = "goimports"
let g:go_def_mapping_enabled          = 0
let g:go_def_reuse_buffer             = 1
let $VISUAL = 'nvr --remote-wait'

let g:deoplete#enable_at_startup       = 1
let g:deoplete#source#go#gocode_binary = '$HOME/go/bin/gocode'
let g:deoplete#auto_complete_delay     = 0

let g:neosnippet#disable_runtime_snippets = { '_' : 1, }
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#enable_auto_clear_markers = 0
let g:neosnippet#snippets_directory = g:plug_repo_dir . '/github.com/honza/vim-snippets/snippets'

let g:ale_cache_executable_check_failures = 1
let g:ale_echo_delay = 20
let g:ale_history_enabled = 0
let g:ale_pattern_options = {'\.min.js$': {'ale_enabled': 0}}
let g:ale_lint_delay = 10000
let g:ale_lint_on_insert_leave = 1
let g:ale_set_highlights = 0
let g:ale_sign_warning = "\uf071"
let g:ale_sign_error = "\uf05e"
let g:ale_warn_about_trailing_whitespace = 0
let g:lightline#ale#warnings = "\uf071"
let g:lightline#ale#errors = "\uf05e"
let g:lightline#ale#ok = "\uf00c"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"

let g:gitgutter_grep = ''
let g:gitgutter_map_keys = 0

let g:nefertiti_base_brightness_level = 14

highlight link HighlightedyankRegion Visual

" plugin keymaps

map *  <Plug>(asterisk-z*)<Plug>(is-nohl-1)
map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
map #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)
map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)
inoremap <silent> <C-l> <C-r>=lexima#insmode#leave(1, '<LT>C-g>U<LT>Right>')<CR>
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

nmap w <Plug>(smartword-w)
nmap b <Plug>(smartword-b)
nmap e <Plug>(smartword-e)
nmap ge <Plug>(smartword-ge)
nmap <silent> <S-n> <Plug>(ale_next_wrap)
nmap <silent> <S-p> <Plug>(ale_previous_wrap)

nnoremap <C-t> :bn<CR>
nnoremap <S-t> :bp<CR>

nnoremap <silent> <Space>s :<C-u>Startify<CR>
nnoremap <silent> <Space>v :<C-u>Vaffle<CR>
nnoremap <silent> <Space>p :<C-u>History<CR>
nnoremap <silent> <Space>r :<C-u>GFiles<CR>
nnoremap <silent> <Space>f :<C-u>Denite file_rec<CR>
nnoremap <silent> <Space>m :<C-u>Denite file_mru<CR>
nnoremap <silent> <Space>y :<C-u>Denite neoyank<CR>
nnoremap <silent> <Space>b :<C-u>Denite buffer<CR>
nnoremap <silent> <Space>d :<C-u>Denite directory_mru<CR>
nnoremap <silent> <Space>g :<C-u>Denite grep<CR>

vmap <CR> <Plug>(LiveEasyAlign)

imap <expr> <C-k> pumvisible()? "\<Plug>(neosnippet_expand_or_jump)" : "\<C-g>U\<C-o>O"
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
imap <expr> <Tab> pumvisible() ? "\<C-n>" :
            \ neosnippet#jumpable() ?
            \ "\<Plug>(neosnippet_jump)" : "\<C-r>=lexima#insmode#leave(1, '<LT>Tab>')\<CR>"
smap <expr> <Tab> neosnippet#jumpable() ?
            \ "\<Plug>(neosnippet_jump)" : "\<Tab>"

" functions

function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ."  ". entry_path'
endfunction

function! LightlineReadonly()
    return &readonly ? "\ue0a2" : ''
endfunction

function! LightlineBranch()
    let branch = gina#component#repo#branch()
    return branch !=# '' ? "\ue0a0".branch : ''
endfunction

function! LightlineRepoStatus()
    let ahead = gina#component#traffic#ahead() > 0 ?
                \ "\u2191 ".gina#component#traffic#ahead() : ''
    let behind = gina#component#traffic#behind() > 0 ?
                \ "\u2193 ".gina#component#traffic#behind() : ''
    let unstaged = gina#component#status#unstaged() > 0 ? '+' : ''
    return behind.ahead.unstaged
endfunction

function! LightlineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : 'no ft') : WebDevIconsGetFileTypeSymbol()
endfunction

function! LightlineFileformat()
    return winwidth(0) > 70 ? (WebDevIconsGetFileFormatSymbol() . ' ' . &fileformat) : WebDevIconsGetFileFormatSymbol()
endfunction

function! MyDeniteReplace(context)
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
                \ neosnippet#expandable() ?
                \ neosnippet#mappings#expand_impl() : deoplete#close_popup()
endfunction

autocmd MyAutoCmd FileType vaffle nmap <ESC> <Plug>(vaffle-quit)
autocmd MyAutoCmd FileType go nnoremap <buffer> gr (go-run)
autocmd MyAutoCmd FileType go nnoremap <buffer> gt (go-test)
autocmd MyAutoCmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd MyAutoCmd FileType go :match goErr /\<err\>/
autocmd MyAutoCmd FileType go set noexpandtab tabstop=4 shiftwidth=4
autocmd MyAutoCmd BufWrite * :Autoformat
autocmd MyAutoCmd InsertEnter * inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
autocmd MyAutoCmd InsertLeave * silent! pclose!

if &runtimepath =~# 'deoplete.nvim'
    call deoplete#custom#option({
                \ 'ignore_sources': {'_': ['file']},
                \ 'ignore_case': v:false,
                \ 'auto_refresh_delay': 100,
                \ })
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
    call denite#custom#map('normal', '<Space><Space>', '<denite:toggle_select_all>')
    call denite#custom#map('normal', 'r', '<denite:do_action:qfreplace>')
    call denite#custom#map('normal', '<ESC>', '<denite:quit>')
    call denite#custom#source('file_mru', 'matchers', ['matcher_fuzzy', 'matcher_ignore_globs'])
    call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',['*://*', '*~', '*.(o|exe|bak|pyc|sw[po]|class)'])
    call denite#custom#action('file', 'qfreplace', function('MyDeniteReplace'))
endif
