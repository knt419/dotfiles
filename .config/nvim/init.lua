--____________________________________________________________________
----------------------------------------------------------------------\
--    _________  _______   ________  ___      ___ ___  ______ ______   \
--   |\   ___  \|\   ___\ |\   __  \|\  \    /  /|\  \|\   __\| __  \   \
--   \ \  \_ \  \ \  \__| \ \  \|\  \ \  \  /  / | \  \ \  \ \  \ \  \   \
--    \ \  \\ \  \ \   __\ \ \  \\\  \ \  \/  / / \ \  \ \  \ \__\ \  \   \
--     \ \  \\ \  \ \  \_|__\ \  \\\  \ \    / /   \ \  \ \  \|__|\ \  \   \
--      \ \__\\ \__\ \_______\ \_______\ \__/ /     \ \__\ \__\    \ \__\   \
--       \|__| \|__|\|_______|\|_______|\|__|/       \|__|\|__|     \|__|    \
--____________________________________________________________________________\
--____________________________________________________________________________|

local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

-- reset autocmd
cmd[[augroup MyAutoCmd]]
cmd[[autocmd!]]
cmd[[augroup END]]
cmd[[augroup MySetUpCmd]]
cmd[[autocmd!]]
cmd[[augroup END]]

-- disable plugins
local disabled_built_ins = {
  'gzip',
  'man',
  'matchit',
  'matchparen',
  'shada_plugin',
  'tarPlugin',
  'tar',
  'zipPlugin',
  'zip',
  'netrwPlugin',
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'logipat',
}

for i = 1, 14 do
    g['loaded_' .. disabled_built_ins[i]] = 1
end

-- option
opt.encoding="utf-8"
opt.fileencoding="utf-8"
opt.fileencodings="iso-2022-jp,cp932,euc-jp,utf-8"

opt.backup=false
opt.writebackup=false
opt.swapfile=false
--opt.backupdir-=.

opt.fsync=false
opt.autoread=false
opt.hidden=true
opt.switchbuf="useopen"
opt.confirm=true
opt.number=true
opt.ruler=true
opt.signcolumn="yes"
opt.display="uhex,lastline"
opt.scrolloff=5
opt.foldmethod="marker"
opt.foldenable=true
opt.foldlevelstart=10
opt.lazyredraw=true

opt.guifont="HackGen35Nerd Console:h12"
opt.guifontwide="HackGen35Nerd Console:h12"
opt.linespace=2
opt.showmatch=false
opt.tabstop=4
opt.expandtab=true
opt.shiftwidth=4
opt.shiftround=true
opt.smarttab=true
opt.smartindent=true
opt.autoindent=true
opt.complete={ '.','w','b' }
opt.conceallevel=0

opt.clipboard="unnamedplus"
opt.startofline=false
opt.list=true
--opt.listchars = { tab = 'ﾂｻ' , trail = '-', eol = '竊ｲ', extends = 'ﾂｻ', precedes = 'ﾂｫ', nbsp = '%' }
--opt.listchars = { tab = '»' , trail = '-', eol = '↲', extends = '»', precedes = '«', nbsp = '%' }
--opt.fillchars= {eob= ' '}
opt.virtualedit="block"
--opt.backspace={ 'indent','eol','start' }
opt.whichwrap="b,s,h,l,<,>,[,]"
opt.mouse="a"
opt.synmaxcol=300
opt.updatetime=300

opt.ignorecase=true
opt.smartcase=true
opt.incsearch=true
opt.wrapscan=true
opt.hlsearch=true
opt.infercase=true

opt.diffopt={'filler','vertical','internal', algorithm = 'histogram','indent-heuristic'}
opt.splitright=true

opt.laststatus=2
opt.cmdheight=2
opt.showtabline=2
opt.wildmenu=true
opt.wildmode= { list = 'full' }
opt.wrap=true
opt.showcmd=true
opt.showmode=false
--opt.iskeyword+=-
opt.linebreak=true
opt.breakindent=true
opt.breakindentopt= { shift = 2 }
opt.showbreak='↪'
--opt.showbreak='竊ｪ'
opt.tags=''

opt.inccommand="split"
opt.pumblend=10
opt.winblend=10

g.mapleader = " "

-- keymap {{{
cmd[[nnoremap <silent> <Esc> <Esc>:<C-u>nohlsearch<CR><Esc>]]
cmd[[nnoremap <silent> <Esc><Esc> :<C-u>bdelete<CR>]]
cmd[[nnoremap <silent> Y y$]]
cmd[[xnoremap <silent> Y "+y]]
cmd[[nnoremap <silent> x "_x]]
cmd[[nnoremap <silent> X "_X]]
cmd[[nnoremap <silent> cd :<C-u>cd %:h<CR>]]
cmd[[nnoremap ss :<C-u>%s///g<Left><Left>]]
cmd[[xnoremap <silent> <expr> p 'pgv"'.v:register.'y`>']]
cmd[[xnoremap . :normal .<CR>]]
cmd[[nnoremap <silent> U <C-r>]]
cmd[[nnoremap <silent> <BS> <C-^>]]
cmd[[nnoremap <silent> + <C-a>]]
cmd[[nnoremap <silent> - <C-x>]]
cmd[[noremap  <silent> <C-j> }]]
cmd[[noremap  <silent> <C-k> {]]
cmd[[noremap  <silent> <C-l> $]]
cmd[[noremap  <silent> <C-;> $]]
cmd[[noremap  <silent> <C-h> ^]]
cmd[[noremap  <silent> os :<C-u>e ++enc=cp932<CR>]]
cmd[[noremap  <silent> oe :<C-u>e ++enc=euc-jp<CR>]]
cmd[[noremap  <silent> ou :<C-u>e ++enc=utf-8<CR>]]
cmd[[noremap  q; :q]]

cmd[[vnoremap < <gv]]
cmd[[vnoremap > >gv]]

cmd[[nnoremap <silent> : ;]]
api.nvim_set_keymap("n", ";", ":", { noremap =true })
cmd[[nnoremap <silent> <CR><CR> o<Esc>]]
cmd[[nnoremap <silent> <Leader>q :<C-u>bd<CR>]]
cmd[[nnoremap <silent> <Leader>w :<C-u>w<CR>:<C-u>bd<CR>]]
cmd[[nnoremap <silent> <Leader>n :<C-u>enew<CR>]]
cmd[[nmap <silent> <C-n> *]]
cmd[[nmap <silent> <C-p> #]]
cmd[[cnoremap <C-v> <C-r>+]]
cmd[[cnoremap <C-c> <C-r><C-w>]]
cmd[[inoremap <silent> <Esc> <Esc>:<C-u>set iminsert=0<CR>]]
cmd[[inoremap <silent> jj <Esc>:<C-u>set iminsert=0<CR>]]

cmd[[inoremap <C-l> <C-g>U<Right>]]
cmd[[inoremap <C-;> <C-g>U<C-o>$]]
cmd[[inoremap <C-j> <C-g>U<C-o>o]]
cmd[[inoremap <C-k> <C-g>U<C-o>O]]

cmd[[nnoremap <S-Left>  <C-w><]]
cmd[[nnoremap <S-Right> <C-w>>]]
cmd[[nnoremap <S-Up>    <C-w>-]]
cmd[[nnoremap <S-Down>  <C-w>+]]
--cmd[[nnoremap <expr><Tab> <SID>my_ntab_function()
--cmd[[nnoremap <expr><S-Tab> <SID>my_ntab_r_function()
cmd[[nnoremap <C-Left>  <C-w>h]]
cmd[[nnoremap <C-Right> <C-w>l]]
cmd[[nnoremap <C-Up>    <C-w>k]]
cmd[[nnoremap <C-Down>  <C-w>j]]

-- keymap for japanese ime
--cmd[[nnoremap あ a]]
--cmd[[nnoremap い i]]
--cmd[[nnoremap う u]]
--cmd[[nnoremap お o]]
--cmd[[nnoremap っd dd]]
--cmd[[nnoremap っy yy]]
--cmd[[inoremap っj <Esc>]]

require'plugins'

cmd[[filetype plugin indent on]]

-- autocmd
cmd[[autocmd MyAutoCmd QuickFixCmdPost *grep* cwindow]]
cmd[[autocmd MyAutoCmd VimResized * execute "normal <C-w>="]]
cmd[[autocmd MyAutoCmd TermOpen * setlocal nonumber]]
cmd[[autocmd MyAutoCmd CursorMoved,CursorMovedI,WinLeave * if &cursorline | setlocal nocursorline | endif]]
cmd[[autocmd MyAutoCmd CursorHold,CursorHoldI * setlocal cursorline]]
cmd[[autocmd MyAutoCmd BufEnter * silent! lcd %:p:h]]
cmd[[autocmd MyAutoCmd BufWritePost plugins.lua PackerCompile]]
cmd[[augroup syntaxhighlight]]
cmd[[autocmd!]]
cmd[[autocmd Syntax * if 100 < line("$") | syntax sync minlines=100 | endif]]
cmd[[augroup END]]

opt.background='dark'
cmd[[colorscheme deep-space]]
