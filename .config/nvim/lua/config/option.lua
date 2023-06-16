local g = vim.g
local opt = vim.opt

opt.fileencoding = "utf-8"
opt.fileencodings = "ucs-bom,utf-8,iso-2022-jp,cp932,euc-jp"

opt.writebackup = false
opt.swapfile = false
opt.backupdir:remove(".")
opt.history = 50
opt.shada = [['10,<30,f0,s5]]

opt.autoread = false
opt.autochdir = true
opt.switchbuf = "useopen"
opt.confirm = true
opt.number = true
opt.signcolumn = "yes"
opt.display = "uhex,lastline"
opt.scrolloff = 5
opt.termguicolors = true

opt.guifont = "HackGen Console NF:h13"
opt.guifontwide = "HackGen Console NF:h13"
opt.tabstop = 4
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true

opt.clipboard:append{'unnamedplus'}
opt.list = true
opt.listchars = {tab = "» ", trail = "·", eol = "↲", extends = "»", precedes = "«", nbsp = "%"}
opt.fillchars = {eob = "\u{0020}"}
opt.virtualedit = "block"
opt.whichwrap = "b,s,h,l,<,>,[,]"
opt.mouse = "a"
opt.synmaxcol = 300

opt.ignorecase = true
opt.smartcase = true
opt.infercase = true

opt.diffopt = {"filler", "vertical", "internal", algorithm = "histogram", "indent-heuristic"}

opt.laststatus = 3
opt.wildmode = {list = "full"}
opt.iskeyword:append("-")
opt.linebreak = true
opt.breakindent = true
opt.breakindentopt = {shift = 2}
opt.showbreak = "↪"

opt.inccommand = "split"
opt.pumblend = 10
opt.winblend = 10
opt.splitkeep = "screen"

g.mapleader = " "
g.is_windows = vim.fn.has("win64") == 1
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
