" option {{{
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
set display=uhex,lastline
set scrolloff=5
set foldmethod=marker
set foldenable
set foldlevelstart=10
" set lazyredraw

set showmatch
set matchtime=1
set tabstop=4
set expandtab
set shiftwidth=4
set smartindent
set autoindent
set complete=.,w,b

set clipboard=unnamedplus
set nostartofline
set list
set listchars=tab:»\ ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set virtualedit=block
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set mouse=a
set synmaxcol=200

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

set diffopt=filler,vertical

set laststatus=2
set cmdheight=2
set showtabline=2
set guioptions-=e
set wildmenu
set wildmode=list:full
set wrap
set showcmd
set noshowmode
set iskeyword+=-
set linebreak
set breakindent
set showbreak=↪
" }}}

" os specific
if has('win32') || has('win64')
    set shellslash
endif

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"

" reset autocmd
augroup MyAutoCmd
    autocmd!
augroup END

if &compatible
    set  nocompatible
endif

let g:plugin_mgr = 'vimplug'

let g:vim_indent_cont = &shiftwidth * 3

" dein {{{
if g:plugin_mgr == 'dein'

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
endif
"}}}

" vimplug {{{
if g:plugin_mgr == 'vimplug'
    let g:plug_path = expand('$HOME/.local/share/nvim/site/autoload/plug.vim')
    let g:plug_repo_dir = expand('$HOME/.local/share/nvim/plugged')

    if !filereadable(g:plug_path)
        execute '!curl -fLo ' . g:plug_path . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $HOME/.config/nvim/init.vim
    endif

    runtime plugins.vim
    autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | q | endif
endif
"}}}

" nvim {{{
if has('nvim')
    set inccommand=split
    nnoremap <Space>t :<C-u>terminal<CR>
    tnoremap <Space>q <C-\><C-n>
    tnoremap jj <C-\><C-n>
    tnoremap <C-t> <C-\><C-n>:<C-u>bn<CR>
    tnoremap <S-t> <C-\><C-n>:<C-u>bp<CR>
    let g:terminal_color_0  = '#0c0c0c' " Black
    let g:terminal_color_1  = '#d78787' " Red
    let g:terminal_color_2  = '#afd787' " Green
    let g:terminal_color_3  = '#f7f7af' " Yellow
    let g:terminal_color_4  = '#87afd7' " Blue
    let g:terminal_color_5  = '#d7afd7' " Magenta
    let g:terminal_color_6  = '#afd7d7' " Cyan
    let g:terminal_color_7  = '#e6e6e6' " White
    let g:terminal_color_8  = '#0a0a0a' " BrightBlack
    let g:terminal_color_9  = '#df8787' " BrightRed
    let g:terminal_color_10 = '#afdf87' " BrightGreen
    let g:terminal_color_11 = '#ffffaf' " BrightYellow
    let g:terminal_color_12 = '#87afdf' " BrightBlue
    let g:terminal_color_13 = '#dfafdf' " BrightMagenta
    let g:terminal_color_14 = '#afdfdf' " BrightCyan
    let g:terminal_color_15 = '#eeeeee' " BrightWhite
endif
"}}}
filetype plugin indent on

" keymap {{{
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR><Esc>
" nnoremap <silent> Y y$
vnoremap <silent> v $h
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

nnoremap <silent> SS :<C-u>source $HOME/.config/nvim/init.vim<CR>

nnoremap <silent> : ;
nnoremap <silent> ; :
nnoremap <silent> <CR> o<ESC>
nnoremap <silent> <Space>q :<C-u>bd<CR>
nnoremap <silent> <Space>w :<C-u>w<CR>:<C-u>bd<CR>
nnoremap <silent> <Space>e :<C-u>enew<CR>
inoremap jj <ESC>:<C-u>set iminsert=0<CR>
inoremap <silent> <ESC> <ESC>:<C-u>set iminsert=0<CR>

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
inoremap っj <ESC>
" }}}

" autocmd
autocmd MyAutoCmd FilterWritePre * if &diff | setlocal wrap< | endif
autocmd MyAutoCmd QuickFixCmdPost *grep* cwindow
autocmd MyAutoCmd VimResized * execute "normal \<C-w>="
autocmd MyAutoCmd FileType * execute 'setlocal ' . (search('^\t.*\n\t.*\n\t', 'n') ? 'no' : '') . 'expandtab'
autocmd MyAutoCmd TermOpen * setlocal nonumber
autocmd MyAutoCmd CursorMoved,CursorMovedI,WinLeave * if &cursorline | setlocal nocursorline | endif
autocmd MyAutoCmd CursorHold,CursorHoldI * setlocal cursorline

" local
if filereadable(expand('$HOME/.config/nvim/init.vim.local'))
    source $HOME/.config/nvim/init.vim.local
endif

set background=dark
colorscheme alduin
syntax enable
