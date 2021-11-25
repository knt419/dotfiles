-- plugin install
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

cmd[[packadd packer.nvim]]

require'packer'.startup(function()
    use{'wbthomason/packer.nvim', opt = true, cmd = {'PackerUpdate'}}

    -- editor display
    use'lukas-reineke/indent-blankline.nvim'
    use {
      'akinsho/bufferline.nvim',
      requires = 'kyazdani42/nvim-web-devicons'
    }
    use'kyazdani42/nvim-web-devicons'
    use'norcalli/nvim-colorizer.lua'
    use'tweekmonster/startuptime.vim'
    -- use'mhinz/vim-startify'
    use {
      'glepnir/dashboard-nvim',
      requires = {'nvim-telescope/telescope.nvim'},
    }
    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        requires = {'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
          local theme = vim.fn.stdpath('data') .. '/site/pack/packer/start/galaxyline.nvim/example/eviline.lua'
          vim.cmd('luafile ' .. theme)
        end
    }
    -- use'ntpeters/vim-better-whitespace'
    use'rickhowe/diffchar.vim'
    use'romainl/vim-qf'
    use'TaDaa/vimade'
    use'andymass/vim-matchup'
    use'camspiers/animate.vim'
    use'camspiers/lens.vim'
    use'yamatsum/nvim-cursorline'
    use'nvim-treesitter/nvim-treesitter'
    use'nvim-treesitter/nvim-treesitter-textobjects'
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

    -- text/input manipulation
    use'cohama/lexima.vim'
    use'godlygeek/tabular'
    use'machakann/vim-highlightedyank'
    use'rhysd/accelerated-jk'
    -- use'tpope/vim-surround'
use {
  "blackCauldron7/surround.nvim",
  config = function()
    require"surround".setup {mappings_style = "sandwich"}
  end
}

    use'b3nj5m1n/kommentary'
    use'tpope/vim-sleuth'
    use'kana/vim-textobj-user'
    use'kana/vim-textobj-line'
    use'kana/vim-smartword'
    use'kana/vim-niceblock'
    use'haya14busa/vim-asterisk'
    use'terryma/vim-expand-region'
    use{'wincent/ferret', opt = true, cmd = {'<Plug>(FerretAck)'}}
    use'kana/vim-operator-user'
    use'kana/vim-operator-replace'
    use{'tyru/capture.vim', opt = true, cmd = {'Capture'}}
    use'junegunn/vim-easy-align'

    -- file/directory
    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use'januswel/fencja.vim'
    use'voldikss/vim-floaterm'
    use'nathom/filetype.nvim'

    -- git
    use'tpope/vim-fugitive'
    use'int3/vim-extradite'
    use'nvim-lua/plenary.nvim'

    -- language support
    use'mechatroner/rainbow_csv'
    use'tpope/vim-dadbod'
    use'editorconfig/editorconfig-vim'
    use'honza/vim-snippets'
    use'pechorin/any-jump.vim'

    -- colorscheme
    use{'ajmwagar/vim-deus', opt = true}
    use{'sainnhe/edge', opt = true}
    use{'tyrannicaltoucan/vim-quantum', opt = true}
    use'tyrannicaltoucan/vim-deep-space'
    use{'knt419/lightline-colorscheme-themecolor', opt = true}

    -- lsp/completion
    use'neovim/nvim-lspconfig'
    use'hrsh7th/cmp-nvim-lsp'
    use'hrsh7th/cmp-buffer'
    use'hrsh7th/cmp-path'
    use'hrsh7th/cmp-cmdline'
    use'hrsh7th/cmp-vsnip'
    use'hrsh7th/vim-vsnip'
    use'hrsh7th/nvim-cmp'
    use'hrsh7th/cmp-nvim-lua'
    opt.completeopt="menu,menuone,noselect"
end)


-- plugin variables

require'bufferline'.setup{
  options = {
    diagnostics = "nvim_lsp"
  },
  highlights = {
    buffer_selected = {
      gui = "bold"
    }
  }
}

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
}

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true
    },
    matchup = {
        enable = true
    },
}

g.dashboard_default_executive = 'telescope'

local cmp = require'cmp'

cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm(),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'vsnip' },
    },{
        { name = 'buffer' },
    }),
}

cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer'}
    },
})
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
})

if g.is_windows then
    g.FerretNvim = 0
    g.FerretJob  = 0
end

g.did_load_filetypes = 1

g.indentLine_bufTypeExclude = {'help', 'terminal'}
g.indentLine_fileTypeExclude = {'startify', 'dashboard'}
g.lexima_ctrlh_as_backspace = 1
g.better_whitespace_filetypes_blacklist = {'diff', 'gitcommit', 'qf', 'help', 'markdown',}

g.extradite_showhash = 1
g.extradite_diff_split = 'belowright vertical split'

g.FerretExecutable          = 'rg,ag'
g.FerretExecutableArguments = {
            ag = '-i --vimgrep --hidden',
            rg = '--vimgrep --no-heading --hidden',
        }

g.highlightedyank_highlight_duration = 300

g.startify_lists = {
          { type = 'files',     header = {'   MRU',}            },
          { type = 'bookmarks', header = {'   Bookmarks',}      },
      }

g.startify_skiplist = {
            '*\\AppData\\Local\\Temp\\*',
            '*\\nvim\\runtime\\doc\\*',
        }

g.startify_bookmarks = {
    { i = '~/.config/nvim/init.lua'},
    { p = '~/.config/nvim/lua/plugins.lua'},
}
g.startify_change_to_vcs_root  = 1
g.startify_change_to_dir       = 1
g.startify_fortune_use_unicode = 0
g.startify_enable_unsafe       = 1
g.floaterm_winblend            = 40
g.floaterm_position            = 'center'

g.webdevicons_enable                 = 1
g.WebDevIconsUnicodeGlyphDoubleWidth = 1
g.webdevicons_enable_startify        = 1
g.capture_open_command = ''
g.capture_override_buffer = 'newbufwin'

vim.env.VISUAL = 'nvr --remote-wait'
vim.env.PATH   = vim.env.PATH .. ':' .. vim.env.HOME .. '/go/bin'

g.nefertiti_base_brightness_level = 14
g.sierra_Sunset = 1
g.edge_style = 'neon'
g.edge_disable_italic_comment = 1

g.markdown_fenced_languages = {
            'vim',
            'help',
        }

-- plugin keymaps

api.nvim_set_keymap('', '*', '<Plug>(asterisk-z*)', {})
api.nvim_set_keymap('', 'g*', '<Plug>(asterisk-gz*)', {})
api.nvim_set_keymap('', '#', '<Plug>(asterisk-#)', {})
api.nvim_set_keymap('', 'g#', '<Plug>(asterisk-g#)', {})

api.nvim_set_keymap('i', '<C-l>', "<C-r>=lexima#insmode#leave(1, '<C-g>U<Right>')<CR>", { noremap = true, silent = true })
api.nvim_set_keymap('i', '<Tab>', "<C-r>=v:lua.my_itab_function()<CR>", { noremap = true })
api.nvim_set_keymap('n', 'j', '<Plug>(accelerated_jk_gj)', {})
api.nvim_set_keymap('n', 'k', '<Plug>(accelerated_jk_gk)', {})
api.nvim_set_keymap('n', 'w', '<Plug>(smartword-w)', {})
api.nvim_set_keymap('n', 'b', '<Plug>(smartword-b)', {})
api.nvim_set_keymap('n', 'e', '<Plug>(smartword-e)', {})
api.nvim_set_keymap('n', 'ge', '<Plug>(smartword-ge)', {})
api.nvim_set_keymap('n', 's', '<Plug>(operator-replace)', {})
api.nvim_set_keymap('n', 'tt', '<Cmd>FloatermToggle<CR>', { noremap = true, silent = true })

api.nvim_set_keymap('n', '<Up>', ':<C-u>Git push', { noremap = true })
api.nvim_set_keymap('n', '<Down>', ':<C-u>Git pull', { noremap = true })
api.nvim_set_keymap('n', '<Right>', ":<C-u>Git commit -am ''<Left>", { noremap = true })
api.nvim_set_keymap('n', '<Left>', "<Cmd>Telescope find_files<CR>", { noremap = true , silent = true })
api.nvim_set_keymap('n', '<Leader>', '<Plug>(asterisk-z*)', { silent = true })
api.nvim_set_keymap('n', '<Leader>e', "<Cmd>CocCommand explorer<CR>", { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>rf', '<Plug>(coc-references)', { silent = true })
api.nvim_set_keymap('n', '<Leader>rn', '<Plug>(coc-rename)', { silent = true })
api.nvim_set_keymap('n', '<Leader>a', '<Plug>(FerretAck)', { silent = true })
api.nvim_set_keymap('n', '<Leader>s', '<Cmd>Startify<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>df', '<Plug>(coc-definition)', { silent = true })
api.nvim_set_keymap('n', '<Leader>f', '<Cmd>CocList files<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>g', '<Cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>h', "<Cmd>call CocAction('doHover')<CR>", { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>l', '<Plug>(FerretLack)', {})
api.nvim_set_keymap('n', '<Leader>b', '<Cmd>CocList buffers<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>m', '<Cmd>CocList mru<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader><Leader>', '<Cmd>CocList<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>fh', '<Cmd>DashboardFindHistory<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>ff', '<Cmd>DashboardFindFile<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>fa', '<Cmd>DashboardFindWord<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>fb', '<Cmd>DashboardJumpMark<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader>fb', '<Cmd>DashboardNewFile<CR>', { noremap = true, silent = true })

api.nvim_set_keymap('x', 'v', '<Plug>(expand_region_expand)', {})
api.nvim_set_keymap('x', '<C-v>', '<Plug>(expand_region_shrink)', {})
api.nvim_set_keymap('x', '<Leader>f', '<Plug>(coc-format-selected)', { silent = true })
api.nvim_set_keymap('x', '<CR>', '<Plug>(LiveEasyAlign)', {})

--if g:tab_gui
--    nnoremap <C-t> <Cmd>tabnext<CR>
--    nnoremap <S-t> <Cmd>tabprevous<CR>
--else
--    nnoremap <C-t> <Cmd>bn<CR>
--    nnoremap <S-t> <Cmd>bp<CR>
--endif

-- Use `:Format` for format current buffer
--command! -nargs=0 Format :call CocAction('format'
--command! PackUpdate :call minpac#update()
--command! PackClean :call minpac#clean()
--command! PackStatus :call minpac#status()

-- functions

local function StartifyEntryFormat()
    return require'nvim-web-devicons'.get_icon(absolute_path) .. "  " .. entry_path
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.my_itab_function = function()
    if fn.pumvisible() then
        return t'<C-n>'
    else
        return t'<Tab>'
        -- return fn["lexima#insmode#leave"](1, '<Tab>')
    end
end

cmd[[




]]
--[[
function! s:my_lexima_setup()
    call lexima#add_rule({'at': '\%#)', 'char': '-', 'input': '<Del><Right><Esc>ea)<Left>'})
    call lexima#add_rule({'at': '\%#}', 'char': '-', 'input': '<Del><Right><Esc>ea)<Left>'})
    call lexima#add_rule({'at': '\%#"', 'char': '-', 'input': '<Del><Right><Esc>ea)<Left>'})
    call lexima#add_rule({'at': '\%#''', 'char': '-', 'input': '<Del><Right><Esc>ea)<Left>'})
endfunction

function! s:my_icr_function()
    return pumvisible() ?
                \ coc#expandable() ?
                \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand', ''] )\<CR>" :
                \  "\<C-y>" :
                \ lexima#expand('<CR>', 'i'
endfunction

function! s:my_itab_function()
    return pumvisible() ?
                \ "\<C-n>" :
                \ coc#jumpable() ?
                \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-jump', ''] )\<CR>" :
                \ lexima#insmode#leave(1, '<Tab>'
endfunction

function! s:my_diffenter_function()
    DisableWhitespace
endfunction

function! s:my_diffexit_function()
    EnableWhitespace
    diffoff
endfunction
]]
cmd[[autocmd MyAutoCmd ColorScheme * :highlight Comment gui=none]]
cmd[[autocmd MyAutoCmd ColorScheme * :highlight! link NonText vimade_0]]
cmd[[autocmd MyAutoCmd ColorScheme * :highlight! link SpecialKey vimade_0]]
--cmd[[autocmd MyAutoCmd InsertEnter * inoremap <silent> <CR> <C-r>=<SID>my_icr_function()<CR>]]
--cmd[[autocmd MyAutoCmd VimEnter * call <SID>my_lexima_setup()]]
cmd[[autocmd MyAutoCmd BufEnter * :Sleuth]]
cmd[[autocmd MyAutoCmd InsertLeave * silent! pclose!]]
--cmd[[autocmd MyAutoCmd OptionSet diff if &diff | call <SID>my_diffenter_function() | endif]]
--cmd[[autocmd MyAutoCmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&diff')) == 1 | call <SID>my_diffexit_function() | endif]]

--if !g:completion_gui
--    autocmd MyAutoCmd BufWritePre *.go :CocCommand editor.action.organizeImport
--endif
