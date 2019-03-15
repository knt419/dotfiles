call plug#begin(g:plug_repo_dir)

" denite
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins'}
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/neomru.vim'
Plug 'thinca/vim-qfreplace'

" editor display
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'lilydjwg/colorizer'
Plug 'itchyny/vim-parenmatch'
Plug 'mhinz/vim-startify'
Plug 'editorconfig/editorconfig-vim'

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
" Plug 'cocopon/vaffle.vim'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'}
Plug 'airblade/vim-rooter'
Plug 'mhinz/neovim-remote'

" git
Plug 'lambdalisue/gina.vim'
Plug 'airblade/vim-gitgutter'

" language support
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'mechatroner/rainbow_csv', { 'for': 'csv' }
Plug 'tpope/vim-dadbod'

" colorscheme
" Plug 'AlessandroYorba/Alduin'
Plug 'jeetsukumaran/vim-nefertiti'

Plug 'junegunn/fzf', { 'dir': '$HOME/.fzf', 'do': './install -all' }
Plug 'junegunn/fzf.vim'

" except oni, veonim
if !exists('g:gui_oni') && !exists('g:veonim')
    " statusline
    Plug 'itchyny/lightline.vim'
    Plug 'mgee/lightline-bufferline'
    Plug 'maximbaz/lightline-ale'
    " lsp/completion
    " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'ncm2/ncm2'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-github'
    Plug 'ncm2/ncm2-syntax'
    Plug 'Shougo/neco-syntax'
    Plug 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': 'make release',
                \ }
endif

" gonvim
if exists('g:gonvim_running')
    Plug 'akiyosi/gonvim-fuzzy'
    Plug 'equalsraf/neovim-gui-shim'
endif

" nyaovim
if exists('g:nyaovim_version')
    Plug 'rhysd/nyaovim-popup-tooltip'
    Plug 'rhysd/nyaovim-markdown-preview'
    Plug 'rhysd/nyaovim-mini-browser'
endif

call plug#end()

if has('conceal')
    set conceallevel=2 concealcursor=i
endif

if !exists('g:gui_oni') && !exists('g:veonim')
    source $HOME/.config/nvim/lightline-themecolor.vim
else
    set cmdheight=1
    set laststatus=0
endif

" plugin variables

let g:lightline = {
            \ 'colorscheme': 'themecolor',
            \ 'active': {
            \    'left': [
            \      ['mode', 'paste'],
            \      ['readonly', 'modified','linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok'],
            \      ['readonly', 'modified'],
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
            \   'lineinfo': "\ue0a1".'%3l:%3v',
            \   'percentage': '%3p%%'
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
            \   'linter_checking': 'lightline#ale#checking',
            \   'linter_warnings': 'lightline#ale#warnings',
            \   'linter_errors': 'lightline#ale#errors',
            \   'linter_ok': 'lightline#ale#ok'
            \ },
            \ 'component_type': {
            \   'buffers': 'tabsel',
            \   'linter_warnings': 'warning',
            \   'linter_errors': 'error',
            \   'linter_checking': 'left',
            \   'linter_ok': 'left'
            \ },
            \ 'separator': {'left': "\ue0b0", 'right': "\ue0b2"},
            \ 'subseparator': {'left': "\ue0b1", 'right': "\ue0b3"}
            \ }

let g:loaded_matchparen          = 1
let g:indentLine_faster          = 1

let g:highlightedyank_highlight_duration = 300

let g:ale_linters = {
            \ 'ruby': ['rubocop'],
            \ }
let g:ale_fixers = {
            \ 'ruby': ['rubocop'],
            \ }
let g:LanguageClient_autoStart = 1
let g:LanguageClient_rootMarkers = {
            \ 'go': ['.git', 'go.mod'],
            \ }

let g:LanguageClient_serverCommands = {
            \ 'go': ['bingo'],
            \ 'vim': ['efm-langserver'],
            \ }

let g:vaffle_show_hidden_files = 1
let g:loaded_netrwPlugin       = 1
let g:fzf_layout               = { 'down': '~70%' }
let g:rooter_change_directory_for_non_project_files = 'home'
let g:startify_change_to_vcs_root = 0
let g:startify_change_to_dir = 0
let g:startify_fortune_use_unicode = 1
let g:startify_enable_unsafe = 0

let g:webdevicons_enable = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:webdevicons_enable_denite = 1
let g:webdevicons_enable_startify = 1

let $VISUAL = 'nvr --remote-wait'

let g:deoplete#enable_at_startup      = 1
let g:deoplete#auto_complete_delay    = 0

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
let g:lightline#ale#indicator_checking = "\uf110"
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
vmap v     <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

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

nnoremap <silent> <Leader>s :<C-u>Startify<CR>
nnoremap <silent> <Leader>v :<C-u>Vaffle<CR>
nnoremap <silent> <Leader>e :<C-u>Defx<CR>
nnoremap <silent> <Leader>p :<C-u>History<CR>
nnoremap <silent> <Leader>r :<C-u>GFiles<CR>
nnoremap <silent> <Leader>f :<C-u>Denite file_rec<CR>
nnoremap <silent> <Leader>m :<C-u>Denite file_mru<CR>
nnoremap <silent> <Leader>y :<C-u>Denite neoyank<CR>
nnoremap <silent> <Leader>b :<C-u>Denite buffer<CR>
nnoremap <silent> <Leader>d :<C-u>Denite directory_mru<CR>
nnoremap <silent> <Leader>g :<C-u>Denite grep<CR>

vmap <CR> <Plug>(LiveEasyAlign)

imap <expr> <Tab> pumvisible() ? "\<C-n>" :
            \ "\<C-r>=lexima#insmode#leave(1, '<LT>Tab>')\<CR>"

if exists('veonim')

    VeonimExt 'veonim/ext-go'
    VeonimExt 'veonim/ext-json'
    VeonimExt 'veonim/ext-html'
    VeonimExt 'vscode:extension/sourcegraph.javascript-typescript'

    " workspace functions
    nnoremap <silent> <Leader>f :Veonim files<cr>
    nnoremap <silent> <Leader>v :Veonim explorer<cr>
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
    return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . '  ' . &filetype : 'no ft') : WebDevIconsGetFileTypeSymbol()
endfunction

function! LightlineFileformat()
    return winwidth(0) > 70 ? (WebDevIconsGetFileFormatSymbol() . '  ' . &fileformat) : WebDevIconsGetFileFormatSymbol()
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
    if &runtimepath =~# 'deoplete.nvim'
        return !pumvisible() ?
                    \ lexima#expand('<CR>', 'i') :
                    \ deoplete#close_popup()
    else
        return lexima#expand('<CR>', 'i')
    endif
endfunction

function! s:defx_my_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> <CR>
                \ defx#do_action('open')
    nnoremap <silent><buffer><expr> c
                \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> m
                \ defx#do_action('move')
    nnoremap <silent><buffer><expr> p
                \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> l
                \ defx#do_action('open')
    nnoremap <silent><buffer><expr> o
                \ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> i
                \ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> d
                \ defx#do_action('remove')
    nnoremap <silent><buffer><expr> r
                \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> x
                \ defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yy
                \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .
                \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> h
                \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~
                \ defx#do_action('cd')
    nnoremap <silent><buffer><expr> q
                \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space>
                \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *
                \ defx#do_action('toggle_select_all')
endfunction

autocmd MyAutoCmd FileType vaffle nmap <ESC> <Plug>(vaffle-quit)
autocmd MyAutoCmd FileType go nnoremap <buffer> gr (go-run)
autocmd MyAutoCmd FileType go nnoremap <buffer> gt (go-test)
autocmd MyAutoCmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd MyAutoCmd FileType go :match goErr /\<err\>/
autocmd MyAutoCmd FileType go set noexpandtab tabstop=4 shiftwidth=4
autocmd MyAutoCmd InsertEnter * inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
autocmd MyAutoCmd InsertLeave * silent! pclose!
autocmd MyAutoCmd FileType defx call s:defx_my_settings()
autocmd MyAutoCmd FileType fzf set laststatus=0 noshowmode noruler
            \| autocmd MyAutoCmd BufLeave <buffer> set laststatus=2 showmode ruler

if &runtimepath =~# 'deoplete.nvim'
    call deoplete#custom#option({
                \ 'ignore_sources': {'_': ['file', 'tag']},
                \ 'ignore_case': v:false,
                \ 'auto_refresh_delay': 100,
                \ 'num_processes': 1,
                \ })
    call deoplete#custom#var(
                \ 'file', 'enable_buffer_path', v:false
                \ )
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
    call denite#custom#action('file', 'qfreplace', function('MyDeniteReplace'))
endif

