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
opt.backupdir:remove('.')

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
--opt.listchars = { tab = '»', trail = '-', eol = '↲', extends = '»', precedes = '«', nbsp = '%' }
--opt.listchars = { tab = "\u{00BB}", trail = "\u{0020}", eol = "\u{21B2}", extends = "\u{00BB}", precedes = "\u{00AB}", nbsp = "\u{0025}" }
opt.fillchars = { eob = "\u{0020}"}
opt.virtualedit="block"
opt.backspace = { 'indent','eol','start' }
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
opt.iskeyword:append('-')
opt.linebreak=true
opt.breakindent=true
opt.breakindentopt= { shift = 2 }
opt.showbreak='↪'
opt.tags=''

opt.inccommand="split"
opt.pumblend=10
opt.winblend=10

g.mapleader = " "
g.is_windows = fn.has('win16') or fn.has('win32') or fn.has('win64')


-- keymap {{{
api.nvim_set_keymap('n', '<Esc>', '<Esc>:<C-u>nohlsearch<CR><Esc>', { noremap = true, silent = true})
api.nvim_set_keymap('n', '<Esc><Esc>', ':<C-u>bdelete<CR>', { noremap = true, silent = true})
api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true, silent = true})
api.nvim_set_keymap('x', 'Y', '"+y', { noremap = true, silent = true})
api.nvim_set_keymap('n', 'x', '"_x', { noremap = true, silent = true})
api.nvim_set_keymap('n', 'X', '"_X', { noremap = true, silent = true})
api.nvim_set_keymap('n', 'cd', ':<C-u>cd %:h<CR>', { noremap = true, silent = true})
api.nvim_set_keymap('n', 'ss', ':<C-u>%s///g<Left><Left>', { noremap = true, silent = true})
api.nvim_set_keymap('x', 'p', '"_xP', { noremap = true, silent = true})
api.nvim_set_keymap('x', '.', ':normal .<CR>', { noremap = true, silent = true})
api.nvim_set_keymap('n', 'U', '<C-r>', { noremap = true, silent = true})
api.nvim_set_keymap('n', '<BS>', '<C-^>', { noremap = true, silent = true})
api.nvim_set_keymap('n', '+', '<C-a>', { noremap = true, silent = true})
api.nvim_set_keymap('n', '-', '<C-x>', { noremap = true, silent = true})
api.nvim_set_keymap('', '<C-j>', '}', { noremap = true, silent = true})
api.nvim_set_keymap('', '<C-k>', '{', { noremap = true, silent = true})
api.nvim_set_keymap('', '<C-l>', '$', { noremap = true, silent = true})
api.nvim_set_keymap('', '<C-;>', '$', { noremap = true, silent = true})
api.nvim_set_keymap('', '<C-h>', '^', { noremap = true, silent = true})
api.nvim_set_keymap('', 'os', ':<C-u>e ++enc=cp932<CR>', { noremap = true, silent = true})
api.nvim_set_keymap('', 'oe', ':<C-u>e ++enc=euc-jp<CR>', { noremap = true, silent = true})
api.nvim_set_keymap('', 'ou', ':<C-u>e ++enc=utf-8<CR>', { noremap = true, silent = true})
api.nvim_set_keymap('', 'q;', ':q', { noremap = true })

api.nvim_set_keymap('v', '<', '<gv', { noremap = true })
api.nvim_set_keymap('v', '>', '>gv', { noremap = true })

api.nvim_set_keymap("n", ";", ":", { noremap =true })
api.nvim_set_keymap("n", "<CR><CR>", "o<Esc>", { noremap =true, silent = true })
api.nvim_set_keymap("n", "<Leader>q", ":<C-u>bd<CR>", { noremap =true, silent = true })
api.nvim_set_keymap("n", "<Leader>w", ":<C-u>w<CR>:<C-u>bd<CR>", { noremap =true, silent = true })
api.nvim_set_keymap("n", "<Leader>n", ":<C-u>enew<CR>", { noremap =true, silent = true })
api.nvim_set_keymap("n", "<C-n>", "*", { silent = true })
api.nvim_set_keymap("n", "<C-p>", "#", { silent = true })
api.nvim_set_keymap("c", "<C-v>", "<C-r>+", { noremap =true, silent = true })
api.nvim_set_keymap("c", "<C-c>", "<C-r><C-w>", { noremap =true })
api.nvim_set_keymap("i", "<Esc>", "<Esc>:<C-u>set iminsert=0<CR>", { noremap =true, silent = true })
api.nvim_set_keymap("i", "jj", "<Esc>:<C-u>set iminsert=0<CR>", { noremap =true, silent = true })

api.nvim_set_keymap("i", "<C-l>", "<C-g>U<Right>", { noremap =true })
api.nvim_set_keymap("i", "<C-;>", "<C-g>U<C-o>$", { noremap =true })
api.nvim_set_keymap("i", "<C-j>", "<C-g>U<C-o>o", { noremap =true })
api.nvim_set_keymap("i", "<C-k>", "<C-g>U<C-o>O", { noremap =true })

api.nvim_set_keymap("n", "<S-Left>", "<C-w><", { noremap =true })
api.nvim_set_keymap("n", "<S-Right>", "<C-w>>", { noremap =true })
api.nvim_set_keymap("n", "<S-Up>", "<C-w>-", { noremap =true })
api.nvim_set_keymap("n", "<S-Down>", "<C-w>+", { noremap =true })
api.nvim_set_keymap("n", "<Tab>", 'v:lua.my_ntab_function()', { noremap =false, expr = true })
api.nvim_set_keymap("n", "<S-Tab>", 'v:lua.my_ntab_r_function()', { noremap =false, expr = true })
api.nvim_set_keymap("n", "<C-Left>", "<C-w>h", { noremap =true })
api.nvim_set_keymap("n", "<C-Right>", "<C-w>l", { noremap =true })
api.nvim_set_keymap("n", "<C-Up>", "<C-w>k", { noremap =true })
api.nvim_set_keymap("n", "<C-Down>", "<C-w>j", { noremap =true })

-- keymap for japanese ime
api.nvim_set_keymap("n", "あ", "a", { noremap =true })
api.nvim_set_keymap("n", "い", "i", { noremap =true })
api.nvim_set_keymap("n", "う", "u", { noremap =true })
api.nvim_set_keymap("n", "お", "o", { noremap =true })
api.nvim_set_keymap("n", "っd", "dd", { noremap =true })
api.nvim_set_keymap("n", "っy", "yy", { noremap =true })
api.nvim_set_keymap("i", "っ", "<Esc>", { noremap =true })

require'plugins'

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.my_ntab_function = function()
  if fn.winnr('$') == 1 then
    if fn.tabpagenr('$') <= 1 then
      if fn.len(fn.getbufinfo({ buflisted = 1 })) <= 1 then
        return t":<C-u>echo 'no buffer to switch.'<CR>"
      else
        return t":<C-u>bn<CR>"
      end
    else
      return t":<C-u>tabnext<CR>"
    end
  else
    return t"<C-w>w"
  end
end

_G.my_ntab_r_function = function()
  if fn.winnr('$') == 1 then
    if fn.tabpagenr('$') <= 1 then
      if fn.len(fn.getbufinfo({ buflisted = 1 })) <= 1 then
        return t":<C-u>echo 'no buffer to switch.'<CR>"
      else
        return t":<C-u>bp<CR>"
      end
    else
      return t":<C-u>tabp<CR>"
    end
  else
    return t"<C-w>W"
  end
end

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
