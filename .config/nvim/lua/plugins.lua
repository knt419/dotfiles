-- plugin install
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

local lazypath = fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    fn.system(
        {
            'git',
            'clone',
            '--filter=blob:none',
            'https://github.com/folke/lazy.nvim.git',
            '--branch=stable', -- latest stable release
            lazypath
        }
    )
end

opt.rtp:prepend(lazypath)

local plugins = {

    -- colorscheme
    -- {
    --     'FrenzyExists/aquarium-vim',
    --     event = 'VeryLazy',
    --     config = function()
    --         cmd.autocmd('BufEnter,ColorScheme * highlight NonText NONE | highlight default link NonText LineNr')
    --         cmd.colorscheme('aquarium')
    --     end
    -- },
    {
        'oxfist/night-owl.nvim',
        lazy = false,  -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            require('night-owl').setup()
            vim.cmd.colorscheme('night-owl')
        end,
    },

    -- editor display
    {
        'nvim-zh/colorful-winsep.nvim',
        event = 'WinNew',
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
        event = { 'BufNewFile', 'BufRead' },
        opts = {
            marks = {
                Search = { color = 'orange' },
            }
        },
    },
    {
        'tadaa/vimade',
        event = 'WinNew',
        opts = {
            recipe = { 'minimalist', { animate = true } },
            basebg = '#2a2a2a',
        }
    },
    {
        'rcarriga/nvim-notify',
        opts = {
            render = 'compact',
            background_colour = '#000000',
        },
    },
    {
        'folke/noice.nvim',
        event = { 'CmdlineEnter', 'BufNewFile', 'BufRead' },
        config = require('config.noice'),
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
            'smjonas/inc-rename.nvim',
        }
    },
    {
        'nvimdev/indentmini.nvim',
        event = { 'BufNewFile', 'BufRead' },
        config = function()
            require('indentmini').setup {
                char = '│',
                exclude = { 'mason', 'lazy', 'starter' }
            }
            cmd.highlight('default link IndentLine LineNr')
        end,
    },
    {
        'tamton-aquib/staline.nvim',
        event = { 'BufNewFile', 'BufRead' },
        config = require('config.staline'),
    },
    {
        'nvim-tree/nvim-web-devicons',
        config = true,
    },
    {
        'norcalli/nvim-colorizer.lua',
        event = { 'BufNewFile', 'BufRead' },
        config = true,
    },
    {
        'echasnovski/mini.starter',
        lazy = false,
        config = require('config.starter'),
    },
    {
        'rickhowe/diffchar.vim',
        event = 'OptionSet diff'
    },
    {
        'nvim-treesitter/nvim-treesitter',
        event = { 'BufWritePre', 'BufReadPre' },
        config = require('config.treesitter'),
    },
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufWritePre', 'BufReadPre' },
        config = function()
            require('gitsigns').setup {}
            require('scrollbar.handlers.gitsigns').setup {}
        end,
        dependencies = {
            'petertriho/nvim-scrollbar',
            'nvim-lua/plenary.nvim',
        },
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
    },
    {
        'lilibyte/tabhula.nvim',
        event = 'InsertEnter',
        config = true,
    },
    {
        'rainbowhxch/accelerated-jk.nvim',
        keys = {
            { 'j', '<Plug>(accelerated_jk_gj)' },
            { 'k', '<Plug>(accelerated_jk_gk)' },
            { '<down>', '<Plug>(accelerated_jk_gj)' },
            { '<up>', '<Plug>(accelerated_jk_gk)' },
        }
    },
    {
        'echasnovski/mini.surround',
        event = { 'BufNewFile', 'BufRead' },
        config = true,
    },
    {
        'kana/vim-smartword',
        keys = {
            { 'w',  '<Plug>(smartword-w)' },
            { 'b',  '<Plug>(smartword-b)' },
            { 'e',  '<Plug>(smartword-e)' },
            { 'ge', '<Plug>(smartword-ge)' }
        }
    },
    {
        'kana/vim-niceblock',
        event = 'ModeChanged *:[vV\x16]*',
    },
    {
        'haya14busa/vim-asterisk',
        keys = {
            { '*',  '<Plug>(asterisk-z*)' },
            { 'g*', '<Plug>(asterisk-gz*)' },
            { '#',  '<Plug>(asterisk-#)' },
            { 'g#', '<Plug>(asterisk-g#)' }
        }
    },
    {
        'terryma/vim-expand-region',
        keys = {
            { 'v',     '<Plug>(expand_region_expand)', mode = 'x' },
            { '<C-v>', '<Plug>(expand_region_shrink)', mode = 'x' }
        }
    },
    {
        'cappyzawa/trim.nvim',
        event = { 'BufNewFile', 'BufRead' },
        opts = {
            ft_blocklist = { 'diff', 'gitcommit', 'qf', 'help', 'markdown', 'dashboard' },
            highlight = true,
        }
    },
    {
        'xiyaowong/transparent.nvim',
        lazy = false,
        opts = {
            extra_groups = {
                'NormalFloat', 'FloatBorder', 'NvimTreeNormal', 'NvimTreeNormalNC', 'Tabline', 'TablineFill', 'Pmenu',
            },
        },
    },


    -- terminal
    {
        'numToStr/FTerm.nvim',
        config = function()
            local shcmd = vim.env.SHELL or 'nu'
            local visual
            if not vim.env.NVIM then
                visual = 'nvim --remote'
            else
                visual = 'nvim --server ' .. vim.env.NVIM .. ' --remote'
            end
            require('FTerm').setup {
                cmd = shcmd,
                blend = 10,
                dimensions = {
                    height = 0.9,
                    width = 0.9,
                },
                env = {
                    VISUAL = visual,
                },
            }
            vim.api.nvim_create_user_command('FtermGituiOpen', function()
                local fterm = require('FTerm')
                local gitui = fterm:new({
                    ft = 'fterm_gitui',
                    cmd = 'gitui',
                    blend = 10,
                    dimensions = {
                        height = 0.9,
                        width = 0.9,
                    },
                })
                gitui:open()
            end, {})
        end,
        keys = {
            { '<Leader>t', function() require('FTerm').toggle() end },
            { '<Leader>gi', function()
                vim.api.nvim_set_current_dir(vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand('%:p')), ':h'))
                vim.cmd.FtermGituiOpen()
            end },
        }
    },

    -- file/directory open/read
    {
        'aymericbeaumet/vim-symlink', --not compatible with neovim's autochdir
        event = 'BufReadPre',
        dependencies = {
            'moll/vim-bbye',
        }
    },
    {
        'moll/vim-bbye',
        keys = {
            { '<Esc><Esc>', '<Cmd>Bdelete<CR>', silent = true }
        }
    },
    {
        'jemag/telescope-diff.nvim',
        config = function()
            require('telescope').load_extension('diff')
        end,
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        keys = {
            { '<Leader>di', function() require('telescope').extensions.diff.diff_files({ hidden = true }) end },
            { '<Leader>dc', function() require('telescope').extensions.diff.diff_current({ hidden = true }) end },
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        config = require('config.telescope'),
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            {
                'danielfalk/smart-open.nvim',
                branch = '0.2.x',
                dependencies = {
                    {
                        'kkharji/sqlite.lua',
                        init = function()
                            if g.is_windows then
                                g.sqlite_clib_path = fn.substitute(fn.stdpath('data'), '\\', '/', 'g') .. '/sqlite3.dll'
                            end
                        end,
                    },
                    {
                        'nvim-telescope/telescope-fzf-native.nvim',
                        build = 'make'
                    },
                },
            },
        },
        keys = {
            { '<Leader>gr',        '<Cmd>Telescope live_grep theme=ivy<CR>',                                  silent = true },
            { '<Leader><Leader>', '<Cmd>Telescope builtin theme=ivy<CR>',                                    silent = true },
            { '<Leader>fb',           function() require('telescope').extensions.file_browser.file_browser() end },
            {
                '<Leader>fo',
                function()
                    require('telescope').extensions.smart_open.smart_open(require(
                        'telescope.themes').get_ivy({ winblend = 10 }))
                end,
                silent = true
            },
        },
    },
    {
        'januswel/fencja.vim',
        event = 'BufRead'
    },

    -- file editing support
    {
        'hat0uma/csvview.nvim',
        ---@module 'csvview'
        ---@type CsvView.Options
        opts = {
            parser = { comments = { '#', '//' } },
            view = { display_mode = 'border' },
            keymaps = {
                -- Text objects for selecting fields
                textobject_field_inner = { 'if', mode = { 'o', 'x' } },
                textobject_field_outer = { 'af', mode = { 'o', 'x' } },
                -- Excel-like navigation:
                -- Use <Tab> and <S-Tab> to move horizontally between fields.
                -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
                -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
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
        'godlygeek/tabular',
        cmd = 'Tabularize'
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
        opts = {},
        dependencies = {
            {
                'mason-org/mason.nvim',
                build = ':MasonUpdate',
                cmd = 'Mason',
                opts = {}
            },
            {
                'neovim/nvim-lspconfig',
                event = { 'BufWritePre', 'BufReadPre' },
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
        event = 'InsertEnter',
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
        event = { 'InsertEnter', 'CmdlineEnter' },
        ---@module 'blink.cmp'
        ---@type blink.cmp.config
        opts = {
            keymap = {
                preset = 'enter',
                ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                    window = {
                        winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
                    },
                },
                menu = {
                    draw = {
                        columns = { { 'kind_icon' }, { 'label', gap = 1 } },
                        components = {
                            label = {
                                text = function(ctx)
                                    return require('colorful-menu').blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require('colorful-menu').blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
            },
            snippets = {
                preset = 'luasnip',
            },
            sources = {
                default = { 'copilot', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    copilot = {
                        name = 'copilot',
                        module = 'blink-copilot',
                        score_offset = 100,
                        async = true,
                    },
                },
            },
            fuzzy = {
                implementation = 'prefer_rust_with_warning',
            },
            ghost_text = { enabled = true },
        },
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
        cache = {
            enabled = false,
        },
        rtp = {
            disabled_plugins = {
                'gzip',
                'health',
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
                'rplugin',
                'getscript',
                'getscriptPlugin',
                'logiPat',
                'rrhelper',
                'editorconfig',
            },
        }
    }
}

require('lazy').setup(plugins, lazyopt)
