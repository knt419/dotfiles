set termguicolors
set t_Co=256
set number 
set title 
set showmatch 
set matchtime=1
set tabstop=4 
set expandtab
set shiftwidth=4
set smartindent
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
set wrapscan

set laststatus=2
set wildmenu
set wrap
set encoding=utf8
set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932
set showcmd
set noshowmode
set hidden
filetype plugin indent on

nnoremap <ESC><ESC> :nohlsearch<CR>
nnoremap SS :source $HOME/.config/nvim/init.vim<CR>

inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<Left>

nnoremap : ;
nnoremap ; :

"win
if has('win32')
    set shellslash
	set shell=C:/msys64/usr/bin/bash.exe
	set shellcmdflag=-c
endif

"local
if filereadable(expand('$HOME/.config/nvim/init.vim.local'))
    source $HOME/.config/nvim/init.vim.local
endif

" reset augroup
augroup MyAutoCmd
    autocmd!
augroup END

"dein
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

syntax on
