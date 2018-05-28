call plug#begin(g:plug_repo_dir)

Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/neosnippet'
Plug 'honza/vim-snippets'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neco-syntax'
Plug 'Chiel92/vim-autoformat'
Plug 'thinca/vim-qfreplace'
Plug 'tyru/caw.vim'
Plug 'brooth/far.vim', { 'on': ['Far','Farp'] }
Plug 'rhysd/try-colorscheme.vim', { 'on': 'TryColorscheme' }
Plug 'y0za/vim-reading-vimrc', { 'on': ['ReadingVimrcList', 'ReadingVimrcLoad', 'ReadingVimrcNext'] }
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
Plug 'maximbaz/lightline-ale'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'lilydjwg/colorizer'
Plug 'junegunn/limelight.vim'
Plug 'itchyny/vim-parenmatch'
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy'
Plug 'mhinz/vim-startify'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'AlessandroYorba/Alduin'
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
Plug 'tpope/vim-surround'
Plug 'cocopon/vaffle.vim'
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install -all' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/neovim-remote'
Plug 'lambdalisue/gina.vim'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'Shougo/neco-vim', { 'for': 'vim' }
Plug 'cespare/vim-toml', { 'for': 'toml' }

if exists('g:nyaovim_version')
    Plug 'rhysd/nyaovim-popup-tooltip'
    Plug 'rhysd/nyaovim-markdown-preview'
    Plug 'rhysd/nyaovim-mini-browser'
endif

call plug#end()

if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" plugin variables

let g:lightline = {
            \ 'colorscheme': 'gruvbox',
            \ 'active': {
            \    'left': [
            \      ['mode', 'paste'],
            \      ['readonly', 'modified', 'linter_errors', 'linter_warnings', 'linter_ok'],
            \    ],
            \    'right': [
            \      ['lineinfo', 'percentage'],
            \      ['filetype', 'fileformat', 'fileencoding']
            \    ]
            \ },
            \ 'tabline': {
            \   'left': [['buffers']],
            \   'right': [['repostatus','branch','repository']]
            \ },
            \ 'component': {
            \   'lineinfo': "\ue0a1".'%2l:%-v',
            \   'percentage': '%p%%'
            \ },
            \ 'component_function': {
            \    'readonly': 'LightlineReadonly',
            \    'repository': 'gina#component#repo#name',
            \    'branch': 'LightlineBranch',
            \    'bufferinfo': 'lightline#buffer#bufferinfo',
            \    'repostatus': 'LightlineRepoStatus'
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
let g:operator#flashy#flash_time = 300
let g:operator#flashy#group      = 'Visual'

let g:ale_linters = {
            \ 'ruby': ['rubocop'],
            \ }
let g:ale_fixers = {
            \ 'ruby': ['rubocop'],
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
let $VISUAL = 'nvr --remote-wait'

let g:deoplete#enable_at_startup       = 1
let g:deoplete#source#go#gocode_binary = '$HOME/go/bin/gocode'
let g:deoplete#auto_complete_delay     = 0
let g:deoplete#enable_camel_case       = 0
let g:deoplete#enable_ignore_case      = 0
let g:deoplete#enable_refresh_always   = 0
let g:deoplete#auto_refresh_delay      = 100
let g:deoplete#enable_smart_case       = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_list                = 10000

let g:neosnippet#disable_runtime_snippets = { '_' : 1, }
let g:neosnippet#enable_snipmate_compatibility = 1

let g:neosnippet#snippets_directory = g:plug_repo_dir . '/github.com/honza/vim-snippets/snippets'

" plugin keymaps

map *  <Plug>(asterisk-z*)<Plug>(is-nohl-1)
map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
map #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)
map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)
map  y <Plug>(operator-flashy)
inoremap <silent> <C-l> <C-r>=lexima#insmode#leave(1, '<LT>C-g>U<LT>Right>')<CR>
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

nmap w <Plug>(smartword-w)
nmap b <Plug>(smartword-b)
nmap e <Plug>(smartword-e)
nmap ge <Plug>(smartword-ge)
nmap Y <Plug>(operator-flashy)$
nmap <silent> <S-n> <Plug>(ale_next_wrap)
nmap <silent> <S-p> <Plug>(ale_previous_wrap)
nmap <Space>c <Plug>(caw:hatpos:toggle)
vmap <Space>c <Plug>(caw:hatpos:toggle)

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
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
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

autocmd! neosnippet CursorMoved *
autocmd MyAutoCmd FileType vaffle nmap <ESC> <Plug>(vaffle-quit)
autocmd MyAutoCmd FileType go nnoremap <buffer> gr (go-run)
autocmd MyAutoCmd FileType go nnoremap <buffer> gt (go-test)
autocmd MyAutoCmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd MyAutoCmd FileType go :match goErr /\<err\>/
autocmd MyAutoCmd FileType go set noexpandtab tabstop=4 shiftwidth=4
autocmd MyAutoCmd BufWrite * :Autoformat
autocmd MyAutoCmd InsertEnter * inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

if &runtimepath =~# '/denite.nvim'
    call denite#custom#option('default', 'prompt', '>')

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
