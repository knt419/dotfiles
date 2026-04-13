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
    {
        'FrenzyExists/aquarium-vim',
        lazy = false,
        config = function()
            cmd.autocmd('BufEnter,ColorScheme * highlight NonText NONE | highlight default link NonText LineNr')
            cmd.colorscheme('aquarium')
        end
    },
    -- {
    --     'oxfist/night-owl.nvim',
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         -- load the colorscheme here
    --         require('night-owl').setup()
    --         vim.cmd.colorscheme('night-owl')
    --     end,
    -- },

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
        'rachartier/tiny-cmdline.nvim',
        lazy = false,
        init = function()
            vim.o.cmdheight = 0
        end,
        config = function()
            require('vim._core.ui2').enable({})
            require('tiny-cmdline').setup({
                menu_col_offset = 1,
                native_types = {},
                on_reposition = require('tiny-cmdline').adapters.blink,
            })
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
            { 'j',      '<Plug>(accelerated_jk_gj)' },
            { 'k',      '<Plug>(accelerated_jk_gk)' },
            { '<down>', '<Plug>(accelerated_jk_gj)' },
            { '<up>',   '<Plug>(accelerated_jk_gk)' },
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
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            dashboard = {
                enabled = true,
                preset = {
                    header = table.concat(
                        {
                            '                                                                      ▄██████▄        ',
                            '                                                                  ▄█▀▀▀▀▀██▀▀▀▀▀█▄    ',
                            ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗          ▐█      ▐▌      █▌   ',
                            ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║          ▐█▄    ▄██▄    ▄█▌   ',
                            ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║  ▄█▄    ▄▄███████▀▀███████▄▄  ',
                            ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║   ▀    ████     ▄  ▄     ████ ',
                            ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║        ████     █  █     ████ ',
                            ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝        ▀███▄            ▄███▀ ',
                            '                                                                  ▀▀████████████▀▀    '
                        }, '\n')
                },
                sections = {
                    { section = "header" },
                    { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                    { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
                    { section = "startup" },
                  },
                },
            explorer = { enabled = true },
            indent = { enabled = true },
            notifier = { enabled = true },
            picker = {
                enabled = true,
                ui_select = true,
                sources = {
                    files = {
                        hidden = true,
                        cmd = "fd",
                    },
                    grep = {
                        hidden = true,
                        cmd = "rg",
                        regex = true,
                    },
                },
                win = {
                    input = {
                        keys = {
                            ["<Esc>"] = { "close", mode = { "n", "i" } },
                        },
                    },
                },
            },
            statuscolumn = {
                enabled = true,
                left = { 'git' },
                right = { 'sign' },
                git = {
                    pattens = { 'GitSign', 'MiniDiffSign' },
                }
            },
            styles = {
                notification = {
                    wo = { wrap = true } -- Wrap notifications
                }
            }
        },
        keys = {
            { "<leader><leader>",  function() Snacks.picker.pickers() end,  desc = "Builtin" },
            { "<leader>fo", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
            { "<leader>s", function() Snacks.dashboard() end, desc = "Dashboard" },
            { "<leader>g",  function() Snacks.picker.grep() end,  desc = "Grep" },
            { "<leader>fb", function() Snacks.explorer() end,     desc = "File Explorer" },
            { "<Esc><Esc>", function() Snacks.bufdelete() end,    desc = "Delete Buffer" },
        }
    },
    {
        'januswel/fencja.vim',
        event = 'BufRead'
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
        'godlygeek/tabular',
        cmd = 'Tabularize'
    },
    {
        'junegunn/vim-easy-align',
        keys = {
            { '<CR>', '<Plug>(LiveEasyAlign)', mode = 'x' }
        }
    },
    {
        'rickhowe/diffchar.vim',
        event = 'OptionSet diff'
    },

    -- lsp/completion
    {
        'mason-org/mason-lspconfig.nvim',
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
        -- lazy = false,
        ---@module 'blink.cmp'
        ---@type blink.cmp.config
        opts = {
            keymap = {
                preset = 'enter',
                ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
            },
            cmdline = {
                enabled = true,
                completion = {
                    menu = { auto_show = true },
                },
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
