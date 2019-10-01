"____________________________________________________________________
"--------------------------------------------------------------------\
"    _________  _______   ________  ___      ___ ___  ______ ______   \
"   |\   ___  \|\   ___\ |\   __  \|\  \    /  /|\  \|\   __\| __  \   \
"   \ \  \_ \  \ \  \__| \ \  \|\  \ \  \  /  / | \  \ \  \ \  \ \  \   \
"    \ \  \\ \  \ \   __\ \ \  \\\  \ \  \/  / / \ \  \ \  \ \__\ \  \   \
"     \ \  \\ \  \ \  \_|__\ \  \\\  \ \    / /   \ \  \ \  \|__|\ \  \   \
"      \ \__\\ \__\ \_______\ \_______\ \__/ /     \ \__\ \__\    \ \__\   \
"       \|__| \|__|\|_______|\|_______|\|__|/       \|__|\|__|     \|__|    \
"____________________________________________________________________________\
"____________________________________________________________________________|

" option {{{
set encoding=utf-8
scriptencoding utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=iso-2022-jp,cp932,euc-jp,utf-8
set t_Co=256
if has('termguicolors')
    set termguicolors
endif

set nobackup
set nowritebackup
set noswapfile
set backupdir-=.
set nofsync
set noautoread
set hidden
set switchbuf=useopen
set confirm
set number
set ruler
set signcolumn=yes
set display=uhex,lastline
set scrolloff=5
set foldmethod=marker
set foldenable
set foldlevelstart=10
set lazyredraw

set guifont=HackGen35Console:h12
set guifontwide=HackGen35Console:h12
set linespace=2
set noshowmatch
set tabstop=4
set expandtab
set shiftwidth=4
set smartindent
set autoindent
set complete=.,w,b
set conceallevel=0

set clipboard=unnamedplus
set nostartofline
set list
set listchars=tab:»\ ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
silent! set fillchars=eob:\ ,
set virtualedit=block
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set mouse=a
set synmaxcol=300
set updatetime=300

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

set diffopt=filler,vertical,internal,algorithm:histogram,indent-heuristic
set splitright

set laststatus=2
set cmdheight=2
set showtabline=2
set wildmenu
set wildmode=list:full
set wrap
set showcmd
set noshowmode
set iskeyword+=-
set linebreak
set breakindent
set breakindentopt=shift:2
set showbreak=↪
set tags=
" }}}

" disable runtime plugins {{{
let g:loaded_2html_plugin      = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_logipat           = 1
let g:loaded_logiPat           = 1
let g:loaded_matchparen        = 1
let g:loaded_netrw             = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_rrhelper          = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_sql_completion    = 1
let g:loaded_syntax_completion = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:vimsyn_embed             = 1
" }}}

let mapleader = "\<Space>"
let g:vim_indent_cont = &shiftwidth * 3
let $LANG = 'ja_JP.UTF-8'

" nvim/vim {{{
if has('nvim')
    set inccommand=split
    nnoremap <Leader>t :<C-u>terminal<CR>
    tnoremap <Leader>q <C-\><C-n>
    tnoremap <C-t> <C-\><C-n>:<C-u>bn<CR>
else
    set ttyfast
    set guioptions-=e
endif
"}}}

" reset autocmd
augroup MyAutoCmd
    autocmd!
augroup END
augroup MySetUpCmd
    autocmd!
augroup END

" vimplug {{{
let g:plug_path = expand('$HOME/.local/share/nvim/site/autoload/plug.vim')
let g:plug_repo_dir = expand('$HOME/.local/share/nvim/plugged')

if !filereadable(g:plug_path)
    execute '!curl -fLo ' . g:plug_path . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd MySetUpCmd VimEnter * PlugInstall --sync | source $HOME/.config/nvim/init.vim
endif

execute 'set runtimepath^=$HOME/.local/share/nvim/site/'
runtime plugins.vim
autocmd MySetUpCmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | q | endif
"}}}


filetype plugin indent on

" keymap {{{
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR><Esc>
nnoremap <silent> Y y$
xnoremap <silent> Y "+y
nnoremap <silent> x "_x
nnoremap <silent> X "_X
nnoremap <silent> cd :<C-u>cd %:h<CR>
nnoremap <silent> ss :<C-u>%s///g<Left><Left>
xnoremap <silent> <expr> p 'pgv"'.v:register.'y`>'
nnoremap <silent> U <C-r>
nnoremap <silent> <BS> <C-^>
nnoremap <silent> + <C-a>
nnoremap <silent> - <C-x>
noremap  <silent> <C-j> }
noremap  <silent> <C-k> {
noremap  <silent> <C-l> $
noremap  <silent> <C-h> ^
noremap  <silent> os :<C-u>e ++enc=cp932<CR>
noremap  <silent> oe :<C-u>e ++enc=euc-jp<CR>
noremap  <silent> ou :<C-u>e ++enc=utf-8<CR>

nnoremap <silent> SS :<C-u>source $HOME/.config/nvim/init.vim<CR>

nnoremap <silent> : ;
nnoremap <silent> ; :
nnoremap <silent> <CR><CR> o<Esc>
nnoremap <silent> <Leader>q :<C-u>bd<CR>
nnoremap <silent> <Leader>w :<C-u>w<CR>:<C-u>bd<CR>
nnoremap <silent> <Leader>n :<C-u>enew<CR>
inoremap jj <Esc>:<C-u>set iminsert=0<CR>

inoremap <C-h> <C-g>U<Left>
inoremap <C-l> <C-g>U<Right>
inoremap <C-;> <C-g>U<C-o>$
inoremap <C-j> <C-g>U<C-o>o
inoremap <C-k> <C-g>U<C-o>O

nnoremap <S-Left>  <C-w><
nnoremap <S-Right> <C-w>>
nnoremap <S-Up>    <C-w>-
nnoremap <S-Down>  <C-w>+
nnoremap <C-Left>  <C-w>h
nnoremap <C-Right> <C-w>l
nnoremap <C-Up>    <C-w>k
nnoremap <C-Down>  <C-w>j

" keymap for japanese ime
nnoremap あ a
nnoremap い i
nnoremap う u
nnoremap お o
nnoremap っd dd
nnoremap っy yy
inoremap っj <Esc>
" }}}

" autocmd
autocmd MyAutoCmd DiffUpdated,FilterWritePre * if &diff | setlocal wrap< | endif
autocmd MyAutoCmd QuickFixCmdPost *grep* cwindow
autocmd MyAutoCmd VimResized * execute "normal \<C-w>="
autocmd MyAutoCmd TermOpen * setlocal nonumber
autocmd MyAutoCmd TermOpen * IndentLinesDisable
autocmd MyAutoCmd FileType help,startify IndentLinesDisable
autocmd MyAutoCmd CursorMoved,CursorMovedI,WinLeave * if &cursorline | setlocal nocursorline | endif
autocmd MyAutoCmd CursorHold,CursorHoldI * setlocal cursorline
autocmd MyAutoCmd BufEnter * silent! lcd %:p:h
augroup syntaxhighlight
    autocmd!
    autocmd Syntax * if 100 < line('$') | syntax sync minlines=100 | endif
augroup END

" command
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
command! -nargs=? -complete=file Diff if '<args>'=='' | browse diffsplit|else| diffsplit <args>|endif

" local
if filereadable(expand('$HOME/.config/nvim/init.vim.local'))
    source $HOME/.config/nvim/init.vim.local
endif

set background=dark
silent! colorscheme allomancer
syntax enable
