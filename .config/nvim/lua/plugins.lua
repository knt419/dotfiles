-- plugin install
local cmd = vim.cmd
local fn = vim.fn
local opt = vim.opt

local lazypath = fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local result = vim.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath
    }, { text = true }):wait()
    if result.code ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { result,                         'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

opt.rtp:prepend(lazypath)

local plugins = {

    -- colorscheme
    {
        'FrenzyExists/aquarium-vim',
        lazy = false,
        config = function()
            -- vim.g.aqua_transparency = 1
            cmd.autocmd('BufEnter,ColorScheme * highlight NonText NONE | highlight default link NonText LineNr')
            cmd.colorscheme('aquarium')
        end
    },
    -- {
    --     'rebelot/kanagawa.nvim',
    --     lazy = false,
    --     config = function()
    --         cmd.autocmd('BufEnter,ColorScheme * highlight NonText NONE | highlight default link NonText LineNr')
    --         cmd.colorscheme('kanagawa-wave')
    --     end
    -- },
    -- {
    --     'catppuccin/nvim',
    --     name = 'catppuccin',
    --     -- 'dgox16/oldworld.nvim',
    --     lazy = false,
    --     config = function()
    --         require('catppuccin').setup({
    --             transparent_background = true,
    --         })
    --         cmd.autocmd('BufEnter,ColorScheme * highlight NonText NONE | highlight default link NonText LineNr')
    --         cmd.colorscheme('catppuccin-macchiato')
    --     end
    -- },
    -- {
    --     'knt419/nova.nvim',
    --     lazy = false,
    --     config = function()
    --         vim.g.nova_transparent_bg = true
    --         cmd.autocmd('BufEnter,ColorScheme * highlight NonText NONE | highlight default link NonText LineNr')
    --         cmd.colorscheme('nova')
    --     end
    -- },

    -- editor display
    {
        'nvim-zh/colorful-winsep.nvim',
        event = 'BufReadPost',
        config = true
    },
    {
        'kevinhwang91/nvim-hlslens',
        event = 'CmdlineEnter',
        config = true,
        dependencies = {
            'petertriho/nvim-scrollbar',
        },
    },
    {
        'petertriho/nvim-scrollbar',
        event = 'FileType',
        ft = 'snacks_dashboard',
        opts = {
            marks = {
                Search = { color = 'orange' },
            }
        },
    },
    -- {
    --     'tadaa/vimade',
    --     event = 'BufReadPost',
    --     opts = {
    --         recipe = { 'minimalist', { animate = true } },
    --         basebg = '#2a2a2a',
    --     }
    -- },
    {
        'rachartier/tiny-cmdline.nvim',
        event = 'FileType',
        ft = 'snacks_dashboard',
        init = function()
            vim.o.cmdheight = 0
        end,
        config = function()
            require('tiny-cmdline').setup({
                menu_col_offset = 1,
                native_types = {},
                on_reposition = require('tiny-cmdline').adapters.blink,
            })
        end,
    },
    {
        'rebelot/heirline.nvim',
        event = 'FileType',
        ft = 'snacks_dashboard',
        config = require('config.heirline'),
    },
    {
        'nvim-tree/nvim-web-devicons',
        config = true,
    },
    {
        'nvim-mini/mini.hipatterns',
        event = 'VeryLazy',
        version = '*',
    },
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'VeryLazy',
        build = ':TSUpdate',
        init = require('config.treesitter'),
    },
    {
        'nvim-mini/mini.diff',
        event = 'FileType',
        ft = 'snacks_dashboard',
        version = '*',
        config = true,
    },
    {
        'nvim-mini/mini.pairs',
        event = 'BufReadPost',
        version = '*',
        config = true,
    },
    {
        'lilibyte/tabhula.nvim',
        event = 'BufReadPost',
        config = true,
    },
    {
        'rainbowhxch/accelerated-jk.nvim',
        keys = {
            { 'j',      '<Plug>(accelerated_jk_gj)' },
            { 'k',      '<Plug>(accelerated_jk_gk)' },
            { '<down>', '<Plug>(accelerated_jk_gj)' },
            { '<up>',   '<Plug>(accelerated_jk_gk)' },
        }
    },
    {
        'echasnovski/mini.surround',
        event = 'BufReadPost',
        config = true,
    },
    {
        'kana/vim-smartword',
        keys = {
            { 'w',  '<Plug>(smartword-w)' },
            { 'b',  '<Plug>(smartword-b)' },
            { 'e',  '<Plug>(smartword-e)' },
        }
    },
    {
        'kana/vim-niceblock',
        event = 'ModeChanged *:[vV\x16]*',
    },
    -- {
    --     'xiyaowong/transparent.nvim',
    --     lazy = false,
    --     opts = {
    --         extra_groups = {
    --             'FloatBorder', 'NvimTreeNormal', 'NvimTreeNormalNC', 'Tabline', 'TablineFill', 'Pmenu',
    --             'BlinkCmpMenuBorder', 'GitSignsDelete', 'GitSignsDelete', 'GitSignsDelete', 'MiniDiffSignAdd',
    --             'MiniDiffSignChange', 'MiniDiffSignDelete', 'DiagnosticSignError', 'DiagnosticSignWarn',
    --             'DiagnosticSignInfo', 'DiagnosticSignHint', 'Folded'
    --         },
    --     },
    -- },

    -- file/directory open/read
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = require('config.snacks'),
        keys = {
            { '<leader><leader>', function() Snacks.picker.pickers() end,  desc = 'Builtin' },
            { '<leader>fo',       function() Snacks.picker.smart() end,    desc = 'Smart Find Files' },
            { '<leader>s',        function() Snacks.dashboard() end,       desc = 'Dashboard' },
            { '<leader>gg',       function() Snacks.picker.grep() end,     desc = 'Grep' },
            { '<leader>fb',       function() Snacks.explorer() end,        desc = 'File Explorer' },
            { '<Esc><Esc>',       function() Snacks.bufdelete() end,       desc = 'Delete Buffer' },
            { '<leader>t',        function() Snacks.terminal.toggle() end, desc = 'Toggle Terminal' },
            {
                '<leader>gi',
                function()
                    vim.api.nvim_set_current_dir(vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand('%:p')), ':h'))
                    Snacks.terminal.toggle('gitui')
                end,
                desc = 'Gitui'
            }
        }
    },
    {
        'januswel/fencja.vim',
        event = 'BufReadPre',
    },
    {
        'mikavilpas/yazi.nvim',
        version = '*', -- use the latest stable version
        event = 'VeryLazy',
        dependencies = {
            { 'nvim-lua/plenary.nvim', lazy = true },
        },
        keys = {
            { '<leader>y', mode = { 'n', 'v' }, '<cmd>Yazi<cr>', desc = 'Open yazi at the current file', },
            { '<c-up>', '<cmd>Yazi toggle<cr>', desc = 'Resume the last yazi session', },
        },
        ---@type YaziConfig | {}
        opts = {
            open_for_directories = false,
            keymaps = {
                show_help = '<f1>',
            },
        },
    },

    -- file editing support
    {
        'hat0uma/csvview.nvim',
        ft = 'csv',
        ---@module 'csvview'
        ---@type CsvView.Options
        opts = {
            parser = { comments = { '#', '//' } },
            view = { display_mode = 'border' },
            keymaps = {
                textobject_field_inner = { 'if', mode = { 'o', 'x' } },
                textobject_field_outer = { 'af', mode = { 'o', 'x' } },
                jump_next_field_end = { '<Tab>', mode = { 'n', 'v' } },
                jump_prev_field_end = { '<S-Tab>', mode = { 'n', 'v' } },
                jump_next_row = { '<Enter>', mode = { 'n', 'v' } },
                jump_prev_row = { '<S-Enter>', mode = { 'n', 'v' } },
            },
        },
        cmd = { 'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle' },
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'markdown' },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            completions = {
                lsp = {
                    enabled = true
                }
            },
            heading = {
                sign = false,
            },
        },
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
    },
    {
        'junegunn/vim-easy-align',
        keys = {
            { '<CR>', '<Plug>(LiveEasyAlign)', mode = 'x' }
        }
    },

    -- lsp/completion
    {
        'mason-org/mason-lspconfig.nvim',
        event = 'VeryLazy',
        config = true,
        dependencies = {
            {
                'mason-org/mason.nvim',
                build = ':MasonUpdate',
                cmd = 'Mason',
                config = true,
            },
            {
                'neovim/nvim-lspconfig',
                config = require('config.lspconfig'),
                dependencies = {
                    'saghen/blink.cmp',
                },
            },
        },
    },
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'BufReadPost',
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },
    {
        'saghen/blink.cmp',
        version = '1.*',
        optional = true,
        dependencies = {
            'fang2hou/blink-copilot',
            {
                'L3MON4D3/LuaSnip',
                version = 'v2.*',
                build = 'make install_jsregexp',
            },
            {
                'xzbdmw/colorful-menu.nvim',
                config = true,
            },
        },
        event = 'BufReadPost',
        ---@module 'blink.cmp'
        ---@type blink.cmp.config
        opts = require('config.blink'),
        opts_extend = { 'sources.default' },
    },
    {
        'smjonas/inc-rename.nvim',
        config = true,
        keys = {
            {
                '<Leader>rn',
                function()
                    return ':IncRename ' .. fn.expand('<cword>')
                end,
                expr = true,
                silent = true
            },
        }
    },
}

local lazyopt = {
    defaults = {
        lazy = true,
    },
    concurrency = 8,
    git = {
        timeout = 300
    },
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip',
                'man',
                'matchit',
                'matchparen',
                'netrw',
                'netrwFileHandlers',
                'netrwPlugin',
                'netrwSettings',
                'spellfile',
                'tar',
                'tarPlugin',
                'tohtml',
                'tutor',
                'vimball',
                'vimballPlugin',
                'zip',
                'zipPlugin',
                'logiPat',
                'rrhelper',
                'editorconfig',
            },
        }
    }
}

require('lazy').setup(plugins, lazyopt)
