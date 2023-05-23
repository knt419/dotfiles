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
local api = vim.api

-- option
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings = "iso-2022-jp,cp932,euc-jp,utf-8"

opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.backupdir:remove(".")

opt.autoread = false
opt.switchbuf = "useopen"
opt.confirm = true
opt.number = true
opt.signcolumn = "yes"
opt.display = "uhex,lastline"
opt.scrolloff = 5
opt.foldmethod = "marker"
opt.foldenable = true
opt.foldlevelstart = 10
opt.lazyredraw = false
opt.termguicolors = true

opt.guifont = "HackGen Console NF:h13"
opt.guifontwide = "HackGen Console NF:h13"
opt.emoji = true
opt.linespace = 0
opt.showmatch = false
opt.tabstop = 4
opt.expandtab = true
opt.shiftwidth = 4
opt.shiftround = true
opt.smartindent = true
opt.complete = {".", "w", "b"}
opt.conceallevel = 0
opt.helplang = "ja,en"

opt.clipboard:append{'unnamedplus'}
opt.startofline = false
opt.list = true
opt.listchars = {tab = "» ", trail = "·", eol = "↲", extends = "»", precedes = "«", nbsp = "%"}
opt.fillchars = {eob = "\u{0020}"}
opt.virtualedit = "block"
opt.whichwrap = "b,s,h,l,<,>,[,]"
opt.mouse = "a"
opt.synmaxcol = 300
opt.updatetime = 300

opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true
opt.infercase = true

opt.diffopt = {"filler", "vertical", "internal", algorithm = "histogram", "indent-heuristic"}
opt.splitright = true

opt.laststatus = 3
opt.cmdheight = 2
opt.showtabline = 2
opt.wildmode = {list = "full"}
opt.wrap = true
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
opt.splitkeep = "screen"

g.mapleader = " "
g.is_windows = fn.has("win16") or fn.has("win32") or fn.has("win64")
g.do_filetype_lua = 1
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

if g.is_windows then
    g.clipboard = {
        name = "win32yank.exe",
        copy = {
            ['+'] = {'win32yank.exe', '-i', '--crlf'},
            ['*'] = {'win32yank.exe', '-i', '--crlf'},
        },
        paste = {
            ['+'] = {'win32yank.exe', '-o', '--lf'},
            ['*'] = {'win32yank.exe', '-o', '--lf'},
        }
    }
end

env.VISUAL = "nvim --remote"

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
keymap.set("n", "<C-l>", "$", {silent = true})
keymap.set("n", "<C-;>", "$", {silent = true})
keymap.set("n", "os", "<Cmd>e ++enc=cp932<CR>", {silent = true})
keymap.set("n", "oe", "<Cmd>e ++enc=euc-jp<CR>", {silent = true})
keymap.set("n", "ou", "<Cmd>e ++enc=utf-8<CR>", {silent = true})
keymap.set("n", "q;", ":q")

keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

keymap.set("n", ";", ":")
keymap.set("n", "<CR><CR>", "o<Esc>", {silent = true})
keymap.set("n", "<Leader>n", "<Cmd>enew<CR>", {silent = true})
keymap.set("n", "<C-n>", "*", {silent = true})
keymap.set("n", "<C-p>", "#", {silent = true})
keymap.set("c", "<C-v>", "<C-r>+", {silent = true})
keymap.set("c", "<C-c>", "<C-r><C-w>")
keymap.set("i", "<Esc>", "<Esc><Cmd>set iminsert=0<CR>", {silent = true})
keymap.set("i", "jj", "<Esc><Cmd>set iminsert=0<CR>", {silent = true})

keymap.set("n", "<S-Left>", "<C-w><")
keymap.set("n", "<S-Right>", "<C-w>>")
keymap.set("n", "<S-Up>", "<C-w>-")
keymap.set("n", "<S-Down>", "<C-w>+")

keymap.set("n", "<Tab>", function()
                            if fn.winlayout()[1] == "leaf" then
                                if fn.tabpagenr("$") <= 1
                                    and fn.len(fn.getbufinfo({buflisted = 1})) <= 1 then
                                        return "<Cmd>echo 'no buffer to switch.'<CR>"
                                else
                                    return "<Cmd>bn<CR>"
                                end
                            else
                                return "<C-w>w"
                            end
                        end, {expr = true})
keymap.set("n", "<S-Tab>", function()
                            if fn.winlayout()[1] == "leaf" then
                                if fn.tabpagenr("$") <= 1
                                    and fn.len(fn.getbufinfo({buflisted = 1})) <= 1 then
                                        return "<Cmd>echo 'no buffer to switch.'<CR>"
                                else
                                    return "<Cmd>bp<CR>"
                                end
                            else
                                return "<C-w>W"
                            end
                        end, {expr = true})

keymap.set("n", "<C-Left>", "<C-w>h")
keymap.set("n", "<C-Right>", "<C-w>l")
keymap.set("n", "<C-Up>", "<C-w>k")
keymap.set("n", "<C-Down>", "<C-w>j")

-- load plugins
require"plugins"

-- autocmd
api.nvim_create_autocmd({"VimEnter", "VimResized"}, {
    pattern = "*",
    command = "normal <C-w>="
})
api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function ()
        vim.wo.number = false
        -- vim.env.VISUAL = "nvim --server " .. vim.env.NVIM .. " --remote"
    end
})
api.nvim_create_autocmd({"CursorMoved", "CursorMovedI", "WinLeave"}, {
    pattern = "*",
    callback = function ()
        if vim.wo.cursorline == true then
            vim.wo.cursorline = false
        end
    end
})
api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
    pattern = "*",
    command = "setlocal cursorline"
})
api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function() vim.highlight.on_yank{higroup="IncSearch", timeout=700} end
})

cmd.colorscheme("onenord")
