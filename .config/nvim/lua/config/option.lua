local g = vim.g
local opt = vim.opt
local env = vim.env

function Foldtext()
    local line = vim.fn.getline(vim.v.foldstart)
    local endline = vim.fn.getline(vim.v.foldend):gsub('^[ \t]+', '')
    local count = vim.v.foldend - vim.v.foldstart + 1

    return {
        { line, 'Label' },
        { '  ...  ', 'Comment' },
        { endline, 'Label' },
        { string.format('  // %d lines ', count), 'Comment' },
    }
end
opt.foldtext = 'v:lua.Foldtext()'

opt.fileencoding = 'utf-8'
opt.fileencodings = 'ucs-bom,utf-8,iso-2022-jp,cp932,euc-jp'

opt.writebackup = false
opt.swapfile = false
opt.backupdir:remove('.')
opt.history = 50
opt.shada = [['10,<30,f0,s5]]

opt.autoread = false
-- opt.autochdir = true
opt.switchbuf = 'useopen'
opt.confirm = true
opt.number = true
opt.signcolumn = 'yes'
opt.display = 'uhex,lastline'
opt.scrolloff = 5
opt.sidescrolloff = 10
opt.termguicolors = true
opt.foldlevel = 99

opt.guifont = 'OperatorMono Nerd Font:h16'
opt.guifontwide = 'HackGen Console NF:h15'
opt.tabstop = 4
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true

opt.clipboard:append { 'unnamedplus' }
opt.list = true
opt.listchars = { tab = '» ', trail = '·', eol = '↲', extends = '»', precedes = '«', nbsp = '%' }
opt.fillchars = { eob = '\u{0020}', diff = '/', fold = ' ', foldclose = '' }
opt.virtualedit = 'block'
opt.whichwrap = 'b,s,h,l,<,>,[,]'
opt.mouse = 'a'
opt.synmaxcol = 300

opt.ignorecase = true
opt.smartcase = true
opt.infercase = true

opt.diffopt = { 'filler', 'vertical', 'internal', algorithm = 'histogram', 'indent-heuristic', inline = 'char', context = 3, linematch = 60,
    'followwrap' }

opt.laststatus = 3
opt.showtabline = 2
opt.wildmode = { list = 'full' }
opt.iskeyword:append({ '-', '_' })
opt.linebreak = true
opt.breakindent = true
opt.breakindentopt = { shift = 2 }
opt.showbreak = '↪'

opt.inccommand = 'split'
opt.pumblend = 10
opt.winblend = 10
opt.splitkeep = 'screen'
opt.winborder = 'rounded'

opt.sh = 'nu'
opt.shelltemp = false
opt.shellredir = 'out+err> %s'
opt.shellcmdflag = '--stdin --no-newline -c'
opt.shellslash = true
opt.shellxescape = ''
opt.shellxquote = ''
opt.shellquote = ''

env.CC = 'gcc'

g.mapleader = ' '
g.is_windows = vim.fn.has('win64') == 1
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0
g.did_install_default_menus = 1
g.did_install_syntax_menu = 1
g.loaded_syntax_completion = 1
g.loaded_sql_completion = 1
g.skip_loading_mswin = 1
g.did_indent_on = 1

g.neovide_opacity = 0.95
g.neovide_cursor_vfx_mode = 'torpedo'

if g.is_windows then
    g.clipboard = {
        name = 'win32yank.exe',
        copy = {
            ['+'] = { 'win32yank.exe', '-i', '--crlf' },
            ['*'] = { 'win32yank.exe', '-i', '--crlf' },
        },
        paste = {
            ['+'] = { 'win32yank.exe', '-o', '--lf' },
            ['*'] = { 'win32yank.exe', '-o', '--lf' },
        }
    }
end

vim.diagnostic.config {
    jump = {
        on_jump = function(_, bufnr)
            vim.diagnostic.open_float { bufnr = bufnr, scope = 'cursor', focus = false }
        end,
    },
}

require('vim._core.ui2').enable({
	enable = true,
	msg = {
		targets = {
			[''] = 'msg',
			empty = 'cmd',
			bufwrite = 'msg',
			confirm = 'cmd',
			emsg = 'pager',
			echo = 'msg',
			echomsg = 'msg',
			echoerr = 'pager',
			completion = 'cmd',
			list_cmd = 'pager',
			lua_error = 'pager',
			lua_print = 'msg',
			progress = 'pager',
			rpc_error = 'pager',
			quickfix = 'msg',
			search_cmd = 'cmd',
			search_count = 'cmd',
			shell_cmd = 'pager',
			shell_err = 'pager',
			shell_out = 'pager',
			shell_ret = 'msg',
			undo = 'msg',
			verbose = 'pager',
			wildlist = 'cmd',
			wmsg = 'msg',
			typed_cmd = 'cmd',
		},
		cmd = {
			height = 0.5,
		},
		dialog = {
			height = 0.5,
		},
		msg = {
			height = 0.3,
			timeout = 5000,
		},
		pager = {
			height = 0.5,
		},
	},
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'msg',
    callback = function()
        local ui2 = require('vim._core.ui2')
        local win = ui2.wins and ui2.wins.msg
        if win and vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_set_option_value(
                'winhighlight',
                'NormalFloat:MsgArea',
                { scope = 'local', win = win }
            )
        end
    end,
})

local ui2 = require('vim._core.ui2')
local msgs = require('vim._core.ui2.messages')
local orig_set_pos = msgs.set_pos
msgs.set_pos = function(tgt)
    orig_set_pos(tgt)
    if (tgt == 'msg' or tgt == nil) and vim.api.nvim_win_is_valid(ui2.wins.msg) then
        pcall(vim.api.nvim_win_set_config, ui2.wins.msg, {
            relative = 'editor',
            anchor = 'NE',
            row = 1,
            col = vim.o.columns - 1,
            border = 'rounded',
        })
    end
end
