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
vim.scriptencoding = "utf-8"

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
    "netrw",
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

opt.guifont = "HackGen Console NF:h12"
opt.guifontwide = "HackGen Console NF:h12"
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
opt.listchars = {tab = "» ", trail = "·", eol = "↲", extends = "»", precedes = "«", nbsp = "%"}
opt.fillchars = {eob = "\u{0020}"}
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
keymap.set("n", "<Esc>", "<Esc><Cmd>nohlsearch<CR><Esc>", {silent = true})
keymap.set("n", "<Esc><Esc>", "<Cmd>bdelete<CR>", {silent = true})
keymap.set("n", "Y", "y$", {silent = true})
keymap.set("x", "Y", '"+y', {silent = true})
keymap.set("n", "x", '"_x', {silent = true})
keymap.set("n", "X", '"_X', {silent = true})
keymap.set("n", "cd", "<Cmd>cd %:h<CR>", {silent = true})
keymap.set("n", "rr", ":<C-u>%s///g<Left><Left>", {silent = true})
keymap.set("x", "p", '"_xP', {silent = true})
keymap.set("x", ".", ":normal .<CR>", {silent = true})
keymap.set("n", "U", "<C-r>", {silent = true})
keymap.set("n", "<BS>", "<C-^>", {silent = true})
keymap.set("n", "+", "<C-a>", {silent = true})
keymap.set("n", "-", "<C-x>", {silent = true})
keymap.set("", "<C-j>", "}", {silent = true})
keymap.set("", "<C-k>", "{", {silent = true})
keymap.set("", "<C-l>", "$", {silent = true})
keymap.set("", "<C-;>", "$", {silent = true})
keymap.set("", "<C-h>", "^", {silent = true})
keymap.set("", "os", "<Cmd>e ++enc=cp932<CR>", {silent = true})
keymap.set("", "oe", "<Cmd>e ++enc=euc-jp<CR>", {silent = true})
keymap.set("", "ou", "<Cmd>e ++enc=utf-8<CR>", {silent = true})
keymap.set("", "q;", ":q")

keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

keymap.set("n", ";", ":")
keymap.set("n", "<CR><CR>", "o<Esc>", {silent = true})
keymap.set("n", "<Leader>q", "<Cmd>bd<CR>", {silent = true})
keymap.set("n", "<Leader>w", "<Cmd>w<CR><Cmd>bd<CR>", {silent = true})
keymap.set("n", "<Leader>n", "<Cmd>enew<CR>", {silent = true})
keymap.set("n", "<Leader><CR>", "<Cmd>lua ReloadConfig()<CR>", {silent = false})
keymap.set("n", "<C-n>", "*", {silent = true})
keymap.set("n", "<C-p>", "#", {silent = true})
keymap.set("c", "<C-v>", "<C-r>+", {silent = true})
keymap.set("c", "<C-c>", "<C-r><C-w>")
keymap.set("i", "<Esc>", "<Esc><Cmd>set iminsert=0<CR>", {silent = true})
keymap.set("i", "jj", "<Esc><Cmd>set iminsert=0<CR>", {silent = true})

keymap.set("i", "<C-l>", "<C-g>U<Right>")
keymap.set("i", "<C-;>", "<C-g>U<C-o>$")
keymap.set("i", "<C-j>", "<C-g>U<C-o>o")
keymap.set("i", "<C-k>", "<C-g>U<C-o>O")

keymap.set("n", "<S-Left>", "<C-w><")
keymap.set("n", "<S-Right>", "<C-w>>")
keymap.set("n", "<S-Up>", "<C-w>-")
keymap.set("n", "<S-Down>", "<C-w>+")
keymap.set("n", "<Tab>", "v:lua.my_ntab_function()", {expr = true})
keymap.set("n", "<S-Tab>", "v:lua.my_ntab_r_function()", {expr = true})
keymap.set("n", "<C-Left>", "<C-w>h")
keymap.set("n", "<C-Right>", "<C-w>l")
keymap.set("n", "<C-Up>", "<C-w>k")
keymap.set("n", "<C-Down>", "<C-w>j")

-- keymap for japanese ime
keymap.set("n", "あ", "a")
keymap.set("n", "い", "i")
keymap.set("n", "う", "u")
keymap.set("n", "お", "o")
keymap.set("n", "っd", "dd")
keymap.set("n", "っy", "yy")
keymap.set("i", "っ", "<Esc>")

require"plugins"

_G.my_ntab_function = function()
    if fn.winlayout()[1] == "leaf" then
        if fn.tabpagenr("$") <= 1 then
            if fn.len(fn.getbufinfo({buflisted = 1})) <= 1 then
                return "<Cmd>echo 'no buffer to switch.'<CR>"
            else
                return "<Cmd>bn<CR>"
            end
        else
            return "<Cmd>bn<CR>"
        end
    else
        return "<C-w>w"
    end
end

_G.my_ntab_r_function = function()
    if fn.winlayout()[1] == "leaf" then
        if fn.tabpagenr("$") <= 1 then
            if fn.len(fn.getbufinfo({buflisted = 1})) <= 1 then
                return "<Cmd>echo 'no buffer to switch.'<CR>"
            else
                return "<Cmd>bp<CR>"
            end
        else
            return "<Cmd>bp<CR>"
        end
    else
        return "<C-w>W"
    end
end

_G.ReloadConfig = function()
    for name, _ in pairs(package.loaded) do
        if name:match("^user") and not name:match("nvim-tree") then
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
cmd.colorscheme("material")
