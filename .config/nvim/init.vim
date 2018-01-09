set encoding=utf-8
scriptencoding utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932
set t_Co=256
if has('termguicolors')
    set termguicolors
endif

set nobackup
set noswapfile
set autoread
set hidden
set switchbuf=useopen
set confirm
set number
set ruler
set title

set showmatch
set matchtime=1
set tabstop=4
set expandtab
set shiftwidth=4
set smartindent
set autoindent

set clipboard=unnamed
set cursorline
set list
set listchars=tab:»\ ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set virtualedit=block
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set mouse=a

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

set laststatus=2
set showtabline=2
set guioptions-=e
set wildmenu
set wrap
set showcmd
set noshowmode
set iskeyword+=-

if has('nvim')
    set sh=bash
    set inccommand=split
    tnoremap <space>q <C-\><C-n>
    tnoremap <C-n> <C-\><C-n>:<C-u>bn<CR>
    tnoremap <C-p> <C-\><C-n>:<C-u>bp<CR>
endif

filetype plugin indent on

nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR><Esc>
nnoremap <silent> Y y$
vnoremap <silent> v $h
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> x "_x
nnoremap <silent> X "_X
nnoremap <silent> + <C-a>
nnoremap <silent> - <C-x>
noremap  <silent> <C-j> }
noremap  <silent> <C-k> {
noremap  <silent> <C-l> $
noremap  <silent> <C-h> ^

nnoremap <silent> SS :<C-u>source $HOME/.config/nvim/init.vim<CR>

nnoremap <silent> : ;
nnoremap <silent> ; :
nnoremap <silent> <space>q :<C-u>bd<CR>
inoremap jj <Esc>

inoremap <C-h> <C-g>U<Left>
inoremap <C-l> <C-g>U<Right>
inoremap <C-;> <ESC>$a

nnoremap <S-Left>  <C-w><
nnoremap <S-Right> <C-w>>
nnoremap <S-Up>    <C-w>-
nnoremap <S-Down>  <C-w>+
nnoremap <C-Left>  <C-w>h
nnoremap <C-Right> <C-w>l
nnoremap <C-Up>    <C-w>k
nnoremap <C-Down>  <C-w>j


" os specific
if has('win32') || has('win64')
    set shellslash
    set shell=cmd
    set shellcmdflag=/c
elseif has('mac')
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" reset autocmd
augroup MyAutoCmd
    autocmd!
augroup END

" local
if filereadable(expand('$HOME/.config/nvim/init.vim.local'))
    source $HOME/.config/nvim/init.vim.local
endif

" dein
if &compatible
    set  nocompatible
endif

let s:dein_dir = expand('$HOME/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let g:rc_dir    = expand('$HOME/.config/nvim/dein')
    let s:toml      = g:rc_dir . '/dein.toml'
    let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})
    call dein#end()
    call dein#save_state()
endif

"if there is something not installed, install it
if dein#check_install()
    call dein#install()
endif

set background=dark
colorscheme bubblegum-256-dark
syntax enable
