-- plugin install
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath
        }
    )
end

opt.rtp:prepend(lazypath)

local plugins = {

    -- colorscheme
    {
        "wadackel/vim-dogrun",
        event = "VeryLazy",
        config = function ()
            cmd.colorscheme"dogrun"
        end
    },

    -- editor display
    {
        "nvim-zh/colorful-winsep.nvim",
        event = "WinNew",
        config = true
    },
    {
        "kevinhwang91/nvim-hlslens",
        event = "CmdlineEnter",
        config = function ()
            require"scrollbar.handlers.search".setup {}
        end,
        dependencies = {
            "petertriho/nvim-scrollbar",
        },
    },
    {
        "petertriho/nvim-scrollbar",
        event = {"BufNewFile", "BufRead"},
        config = function ()
            require"scrollbar".setup {
                marks = {
                    Search = { color = 'orange' },
                }
            }
        end
    },
    {
        "levouh/tint.nvim",
        event = "WinNew",
        config = true,
    },
    {
        "rcarriga/nvim-notify",
        config = function ()
            require"notify".setup {
                render = "compact"
            }
        end
    },
    {
        "folke/noice.nvim",
        event = {"CmdlineEnter", "BufNewFile", "BufRead"},
        config = require"config.noice",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
    {
        'nvimdev/indentmini.nvim',
        event = {"BufNewFile", "BufRead"},
        config = function()
            require"indentmini".setup {
                char = '│',
                exclude = {"mason", "lazy", "starter"}
            }
            cmd.highlight("default link IndentLine Whitespace")
        end,
    },
    {
        "tamton-aquib/staline.nvim",
        event = {"BufNewFile", "BufRead"},
        config = require"config.staline"
    },
    {
        "nvim-tree/nvim-web-devicons",
        config = true,
    },
    {
        "norcalli/nvim-colorizer.lua",
        event = {"BufNewFile", "BufRead"},
        config = function ()
            require"colorizer".setup()
        end,
    },
    {
        "echasnovski/mini.starter",
        lazy = false,
        config = require"config.starter",
    },
    {
        "rickhowe/diffchar.vim",
        event = "OptionSet diff"
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = {"BufWritePre", "BufReadPre"},
        config = require"config.treesitter",
    },
    {
        "lewis6991/gitsigns.nvim",
        event = {"BufWritePre", "BufReadPre"},
        config = function ()
            require"gitsigns".setup {}
            require"scrollbar.handlers.gitsigns".setup {}
        end,
        dependencies = {
            "petertriho/nvim-scrollbar",
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "godlygeek/tabular",
        cmd = "Tabularize"
    },
    {
        "lilibyte/tabhula.nvim",
        event = "InsertEnter",
        config = true,
    },
    {
        "rainbowhxch/accelerated-jk.nvim",
        keys = {
            { "j", "<Plug>(accelerated_jk_gj)" },
            { "k", "<Plug>(accelerated_jk_gk)" }
        }
    },
    {
        "echasnovski/mini.surround",
        event = {"BufNewFile", "BufRead"},
        config = true,
    },
    {
        "tpope/vim-commentary",
        keys = {
            { "gc", "<Plug>Commentary", mode = {"x", "n", "o"} },
            { "gcc", "<Plug>CommentaryLine" }
        }
    },
    {
        "kana/vim-smartword",
        keys = {
            { "w", "<Plug>(smartword-w)" },
            { "b", "<Plug>(smartword-b)" },
            { "e", "<Plug>(smartword-e)" },
            { "ge", "<Plug>(smartword-ge)" }
        }
    },
    {
        "kana/vim-niceblock",
        event = {"BufNewFile", "BufRead"},
    },
    {
        "haya14busa/vim-asterisk",
        keys = {
            { "*", "<Plug>(asterisk-z*)" },
            { "g*", "<Plug>(asterisk-gz*)" },
            { "#", "<Plug>(asterisk-#)" },
            { "g#", "<Plug>(asterisk-g#)" }
        }
    },
    {
        "terryma/vim-expand-region",
        keys = {
            { "v", "<Plug>(expand_region_expand)", mode = "x" },
            { "<C-v>", "<Plug>(expand_region_shrink)", mode = "x" }
        }
    },
    {
        "junegunn/vim-easy-align",
        keys = {
            { "<CR>", "<Plug>(LiveEasyAlign)", mode = "x" }
        }
    },
    {
        "ntpeters/vim-better-whitespace",
        event = {"BufNewFile", "BufRead"},
        config = require"config.whitespace",
    },
    {
        "smjonas/inc-rename.nvim",
        config = function ()
            require"inc_rename".setup{}
        end,
        keys = {
            { "<Leader>rn", function()
                                return ":IncRename " .. fn.expand("<cword>")
                            end, expr = true, silent = true },
        }
    },

    -- file/directory
    {
        "aymericbeaumet/vim-symlink",
        event = "BufReadPre",
    },
    {
        "jemag/telescope-diff.nvim",
        config = function ()
            require"telescope".load_extension("diff")
        end,
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            { "<Leader>di", function () require"telescope".extensions.diff.diff_files({ hidden = true }) end },
            { "<Leader>dc", function () require"telescope".extensions.diff.diff_current({ hidden = true }) end },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        config = require"config.teles",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make"
            },
            {
                "nvim-telescope/telescope-frecency.nvim",
                dependencies = {
                    {
                        "kkharji/sqlite.lua",
                        init = function ()
                            if g.is_windows then
                                g.sqlite_clib_path = fn.substitute(fn.stdpath("data"), "\\", "/", "g") .. "/sqlite3.dll"
                            end
                        end,
                    },
                },
            },
        },
        keys = {
            { "<Leader>g", "<Cmd>Telescope live_grep theme=ivy<CR>", silent = true },
            { "<Leader><Leader>", "<Cmd>Telescope builtin theme=ivy<CR>", silent = true },
            { "<Left>", "<Cmd>lua require'telescope'.extensions.file_browser.file_browser()<CR>" },
            { "<Leader>f", "<Cmd>Telescope frecency theme=ivy<CR>", silent = true },
        },
    },
    {
        "januswel/fencja.vim",
        event = "BufRead"
    },

    -- git
    {
        "tpope/vim-fugitive",
        cmd = "Git",
        keys = {
            { "<Down>", "<Cmd>Git pull<CR>" },
        }
    },
    {
        "kdheepak/lazygit.nvim",
        config = function ()
            g.lazygit_floating_window_winblend = 0
            g.lazygit_floating_window_scaling_factor = 0.9
            g.lazygit_floating_window_border_chars = {'╭','─', '╮', '│', '╯','─', '╰', '│'}
            g.lazygit_floating_window_use_plenary = 0
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<Right>", "<Cmd>cd %:h<CR><Cmd>LazyGit<CR>" }
        }
    },

    -- language support
    {
        'cameron-wags/rainbow_csv.nvim',
        config = true,
        cmd = {
            'RainbowAlign',
            'RainbowDelim',
            'RainbowDelimSimple',
            'RainbowDelimQuoted',
            'RainbowMultiDelim'
        }
    },

    -- lsp/completion
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        cmd = "Mason",
        config = true,
    },
    {
        "neovim/nvim-lspconfig",
        event = {"BufWritePre", "BufReadPre"},
        config = require"config.lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            {
                "williamboman/mason-lspconfig.nvim",
                config = true,
            },
        },
    },
    {
        "hrsh7th/cmp-cmdline",
        event = "CmdlineEnter",
    },
    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = require"config.cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "onsails/lspkind-nvim",
            "saadparwaiz1/cmp_luasnip",
            "FelipeLema/cmp-async-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lua",
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
                "gzip",
                "health",
                "man",
                "matchit",
                "matchparen",
                "netrw",
                "netrwFileHandlers",
                "netrwPlugin",
                "netrwSettings",
                "spellfile",
                "tar",
                "tarPlugin",
                "tohtml",
                "tutor",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
                "rplugin",
                "getscript",
                "getscriptPlugin",
                "logiPat",
                "rrhelper",
                "editorconfig",
            },
        }
    }
}

require("lazy").setup(plugins, lazyopt)

