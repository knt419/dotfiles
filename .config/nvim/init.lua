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

local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt
local env = vim.env
local keymap = vim.keymap

-- reset autocmd
cmd [[augroup MyAutoCmd]]
cmd [[autocmd!]]
cmd [[augroup END]]

cmd [[cd ~]]

-- disable plugins
local disabled_built_ins = {
  "gzip",
  "man",
  "matchit",
  "matchparen",
  "shada_plugin",
  "tarPlugin",
  "tar",
  "zipPlugin",
  "zip",
  "netrwPlugin",
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "logipat",
  "filetype"
}

for i in pairs(disabled_built_ins) do
  g["loaded_" .. disabled_built_ins[i]] = 1
end

-- option
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings = "iso-2022-jp,cp932,euc-jp,utf-8"

opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.backupdir:remove(".")

opt.fsync = false
opt.autoread = false
opt.hidden = true
opt.switchbuf = "useopen"
opt.confirm = true
opt.number = true
opt.ruler = true
opt.signcolumn = "yes"
opt.display = "uhex,lastline"
opt.scrolloff = 5
opt.foldmethod = "marker"
opt.foldenable = true
opt.foldlevelstart = 10
opt.lazyredraw = false
opt.termguicolors = true

opt.guifont = "HackGen35 Console NF:h12"
opt.guifontwide = "HackGen35Nerd Console NF:h12"
opt.emoji = true
opt.linespace = 2
opt.showmatch = false
opt.tabstop = 4
opt.expandtab = true
opt.shiftwidth = 4
opt.shiftround = true
opt.smarttab = true
opt.smartindent = true
opt.autoindent = true
opt.complete = {".", "w", "b"}
opt.conceallevel = 0

opt.clipboard = "unnamedplus"
opt.startofline = false
opt.list = true
opt.listchars = { tab = '» ', trail = '·', eol = '↲', extends = '»', precedes = '«', nbsp = '%' }
opt.fillchars = { eob = "\u{0020}"}
opt.virtualedit = "block"
opt.backspace = {"indent", "eol", "start"}
opt.whichwrap = "b,s,h,l,<,>,[,]"
opt.mouse = "a"
opt.synmaxcol = 300
opt.updatetime = 300

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.wrapscan = true
opt.hlsearch = true
opt.infercase = true

opt.diffopt = {"filler", "vertical", "internal", algorithm = "histogram", "indent-heuristic"}
opt.splitright = true

opt.laststatus = 2
opt.cmdheight = 2
opt.showtabline = 2
opt.wildmenu = true
opt.wildmode = {list = "full"}
opt.wrap = true
opt.showcmd = true
opt.showmode = false
opt.iskeyword:append("-")
opt.linebreak = true
opt.breakindent = true
opt.breakindentopt = {shift = 2}
opt.showbreak = "↪"
opt.tags = ""

opt.inccommand = "split"
opt.pumblend = 10
opt.winblend = 10

g.mapleader = " "
g.is_windows = fn.has("win16") or fn.has("win32") or fn.has("win64")
g.do_filetype_lua = 1

env.VISUAL = "nvr --remote-wait"
env.PATH = env.PATH .. ":" .. env.HOME .. "/go/bin"

-- keymap {{{
keymap.set("n", "<Esc>", "<Esc><Cmd>nohlsearch<CR><Esc>", {noremap = true, silent = true})
keymap.set("n", "<Esc><Esc>", "<Cmd>bdelete<CR>", {noremap = true, silent = true})
keymap.set("n", "Y", "y$", {noremap = true, silent = true})
keymap.set("x", "Y", '"+y', {noremap = true, silent = true})
keymap.set("n", "x", '"_x', {noremap = true, silent = true})
keymap.set("n", "X", '"_X', {noremap = true, silent = true})
keymap.set("n", "cd", "<Cmd>cd %:h<CR>", {noremap = true, silent = true})
keymap.set("n", "rr", ":<C-u>%s///g<Left><Left>", {noremap = true, silent = true})
keymap.set("x", "p", '"_xP', {noremap = true, silent = true})
keymap.set("x", ".", ":normal .<CR>", {noremap = true, silent = true})
keymap.set("n", "U", "<C-r>", {noremap = true, silent = true})
keymap.set("n", "<BS>", "<C-^>", {noremap = true, silent = true})
keymap.set("n", "+", "<C-a>", {noremap = true, silent = true})
keymap.set("n", "-", "<C-x>", {noremap = true, silent = true})
keymap.set("", "<C-j>", "}", {noremap = true, silent = true})
keymap.set("", "<C-k>", "{", {noremap = true, silent = true})
keymap.set("", "<C-l>", "$", {noremap = true, silent = true})
keymap.set("", "<C-;>", "$", {noremap = true, silent = true})
keymap.set("", "<C-h>", "^", {noremap = true, silent = true})
keymap.set("", "os", "<Cmd>e ++enc=cp932<CR>", {noremap = true, silent = true})
keymap.set("", "oe", "<Cmd>e ++enc=euc-jp<CR>", {noremap = true, silent = true})
keymap.set("", "ou", "<Cmd>e ++enc=utf-8<CR>", {noremap = true, silent = true})
keymap.set("", "q;", ":q", {noremap = true})

keymap.set("v", "<", "<gv", {noremap = true})
keymap.set("v", ">", ">gv", {noremap = true})

keymap.set("n", ";", ":", {noremap = true})
keymap.set("n", "<CR><CR>", "o<Esc>", {noremap = true, silent = true})
keymap.set("n", "<Leader>q", "<Cmd>bd<CR>", {noremap = true, silent = true})
keymap.set("n", "<Leader>w", "<Cmd>w<CR><Cmd>bd<CR>", {noremap = true, silent = true})
keymap.set("n", "<Leader>n", "<Cmd>enew<CR>", {noremap = true, silent = true})
keymap.set("n", "<Leader><CR>", "<Cmd>lua ReloadConfig()<CR>", { noremap = true, silent = false })
keymap.set("n", "<C-n>", "*", {silent = true})
keymap.set("n", "<C-p>", "#", {silent = true})
keymap.set("c", "<C-v>", "<C-r>+", {noremap = true, silent = true})
keymap.set("c", "<C-c>", "<C-r><C-w>", {noremap = true})
keymap.set("i", "<Esc>", "<Esc><Cmd>set iminsert=0<CR>", {noremap = true, silent = true})
keymap.set("i", "jj", "<Esc><Cmd>set iminsert=0<CR>", {noremap = true, silent = true})

keymap.set("i", "<C-l>", "<C-g>U<Right>", {noremap = true})
keymap.set("i", "<C-;>", "<C-g>U<C-o>$", {noremap = true})
keymap.set("i", "<C-j>", "<C-g>U<C-o>o", {noremap = true})
keymap.set("i", "<C-k>", "<C-g>U<C-o>O", {noremap = true})

keymap.set("n", "<S-Left>", "<C-w><", {noremap = true})
keymap.set("n", "<S-Right>", "<C-w>>", {noremap = true})
keymap.set("n", "<S-Up>", "<C-w>-", {noremap = true})
keymap.set("n", "<S-Down>", "<C-w>+", {noremap = true})
keymap.set("n", "<Tab>", "v:lua.my_ntab_function()", {noremap = false, expr = true})
keymap.set("n", "<S-Tab>", "v:lua.my_ntab_r_function()", {noremap = false, expr = true})
keymap.set("n", "<C-Left>", "<C-w>h", {noremap = true})
keymap.set("n", "<C-Right>", "<C-w>l", {noremap = true})
keymap.set("n", "<C-Up>", "<C-w>k", {noremap = true})
keymap.set("n", "<C-Down>", "<C-w>j", {noremap = true})

-- keymap for japanese ime
keymap.set("n", "あ", "a", {noremap = true})
keymap.set("n", "い", "i", {noremap = true})
keymap.set("n", "う", "u", {noremap = true})
keymap.set("n", "お", "o", {noremap = true})
keymap.set("n", "っd", "dd", {noremap = true})
keymap.set("n", "っy", "yy", {noremap = true})
keymap.set("i", "っ", "<Esc>", {noremap = true})

require "plugins"

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.my_ntab_function = function()
  if fn.winnr("$") == 1 then
    if fn.tabpagenr("$") <= 1 then
      if fn.len(fn.getbufinfo({buflisted = 1})) <= 1 then
        return t "<Cmd>echo 'no buffer to switch.'<CR>"
      else
        return t "<Cmd>bn<CR>"
      end
    else
      return t "<Cmd>bn<CR>"
    end
  else
    return t "<C-w>w"
  end
end

_G.my_ntab_r_function = function()
  if fn.winnr("$") == 1 then
    if fn.tabpagenr("$") <= 1 then
      if fn.len(fn.getbufinfo({buflisted = 1})) <= 1 then
        return t "<Cmd>echo 'no buffer to switch.'<CR>"
      else
        return t "<Cmd>bp<CR>"
      end
    else
      return t "<Cmd>bp<CR>"
    end
  else
    return t "<C-w>W"
  end
end

_G.ReloadConfig = function ()
    for name,_ in pairs(package.loaded) do
        if name:match('^user') and not name:match('nvim-tree') then
            package.loaded[name] = nil
        end
    end

    dofile(vim.env.MYVIMRC)
    vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

cmd [[filetype plugin indent on]]

-- autocmd
cmd [[autocmd MyAutoCmd QuickFixCmdPost *grep* cwindow]]
cmd [[autocmd MyAutoCmd VimResized * execute "normal <C-w>="]]
cmd [[autocmd MyAutoCmd TermOpen * setlocal nonumber]]
cmd [[autocmd MyAutoCmd CursorMoved,CursorMovedI,WinLeave * if &cursorline | setlocal nocursorline | endif]]
cmd [[autocmd MyAutoCmd CursorHold,CursorHoldI * setlocal cursorline]]
cmd [[autocmd MyAutoCmd BufEnter * silent! lcd %:p:h]]
cmd [[augroup highlighted_yank]]
cmd [[autocmd!]]
cmd [[autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}]]
cmd [[augroup END]]

opt.background = "dark"
cmd [[colorscheme deep-space]]
