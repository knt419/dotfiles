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
vim.loader.enable()

local fn = vim.fn
local g = vim.g
local opt = vim.opt
local api = vim.api

-- option
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings = "iso-2022-jp,utf-8,cp932,euc-jp"

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
g.is_windows = fn.has("win16") == 1 or fn.has("win32") == 1 or fn.has("win64") == 1
g.do_filetype_lua = 0
g.did_load_filetypes = 1
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0
g.did_install_default_menus = 1
g.did_install_syntax_menu = 1
g.loaded_syntax_completion = 1
g.loaded_sql_completion = 1
g.skip_loading_mswin = 1
g.did_indent_on = 1

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

-- load plugins
require"plugins"

-- autocmd
api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
        require"config.keymap"
        require"config.lazyau"
    end
})
