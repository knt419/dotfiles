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

g.sqlite_clib_path = fn.substitute(fn.stdpath("data"), "\\", "/", "g") .. "/sqlite3.dll"

local plugins = {

    -- performance improve
    {
        "nathom/filetype.nvim",
        lazy = false,
    },

    -- colorscheme
    -- {
    --     "tyrannicaltoucan/vim-deep-space",
    -- },
    -- {
    --     "rebelot/kanagawa.nvim",
    --     config = function ()
    --         require"kanagawa".setup{
    --             commentStyle = { italic = false },
    --             keywordStyle = { italic = false },
    --             dimInactive = true
    --         }
    --     end
    -- },
    -- {
    --     "marko-cerovac/material.nvim",
    --     config = function()
    --         g.material_style = "darker"
    --         require"material".setup {
    --             contrast = {
    --                 floating_windows = true,
    --                 non_current_windows = true
    --             },
    --             plugins = {
    --                 "dashboard",
    --                 "gitsigns",
    --                 "indent-blankline",
    --                 "nvim-cmp",
    --                 "nvim-web-devicons",
    --                 "telescope"
    --             }
    --         }
    --     end,
    --     keys = {
    --         { "<Leader>m", "<Cmd>lua require'material.functions'.find_style()<CR>", silent = true },
    --     }
    -- },
    -- {
    --     "sainnhe/edge",
    --     config = function ()
    --         g.edge_style = 'aura'
    --         g.edge_disable_italic_comment = 1
    --         g.edge_transparent_background = 0
    --         g.edge_dim_inactive_windows = 1
    --     end
    -- },
    -- {
    --     "rmehri01/onenord.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function ()
    --         require"onenord".setup {}
    --         cmd.colorscheme"onenord"
    --     end
    -- },
    -- {
    --     "catppuccin/nvim",
    --     -- lazy = false,
    --     name = "catppuccin",
    --     -- priority = 1000,
    --     config = function ()
    --         require"catppuccin".setup {
    --             flavour = "frappe",
    --             no_italic = true,
    --             integrations = {
    --                 nvimtree = false,
    --                 notify = true,
    --             }
    --         }
    --         cmd.colorscheme"catppuccin"
    --     end
    -- },
    -- {
    --     "shaunsingh/nord.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function ()
    --         g.nord_contrast = true
    --         g.nord_italic = false
    --         g.nord_bold = false
    --         require"nord".set {}
    --     end
    -- },
    {
        "wadackel/vim-dogrun",
        lazy = false,
        priority = 1000,
        config = function ()
            cmd.colorscheme"dogrun"
        end
    },

    -- editor display
    {
        "MunifTanjim/nui.nvim",
    },
    {
        "nvim-zh/colorful-winsep.nvim",
        event = "WinNew",
        config = true
    },
    {
        "kevinhwang91/nvim-hlslens",
        event = "CmdlineEnter",
        config = function ()
            require"scrollbar.handlers.search".setup({
                override_lens = function () end,
            })
        end
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
            "rcarriga/nvim-notify"
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
        "nvim-lualine/lualine.nvim",
        event = {"BufNewFile", "BufRead"},
        config = require"config.lualine",
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
            "nvim-lua/plenary.nvim"
        }
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
        "tami5/sqlite.lua",
    },
    {
        "jemag/telescope-diff.nvim",
        keys = {
            { "<Leader>di", function ()
                                require"telescope".load_extension("diff")
                                require"telescope".extensions.diff.diff_files({ hidden = true})
                            end },
            { "<Leader>dc", function ()
                                require"telescope".load_extension("diff")
                                require"telescope".extensions.diff.diff_current({ hidden = true})
                            end }
        }
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
    },
    {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = {"tami5/sqlite.lua"}
    },
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        config = require"config.teles",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<Leader>f", "<Cmd>Telescope frecency theme=ivy<CR>", silent = true },
            { "<Leader>g", "<Cmd>Telescope live_grep theme=ivy<CR>", silent = true },
            { "<Leader><Leader>", "<Cmd>Telescope builtin theme=ivy<CR>", silent = true },
            { "<Left>", "<Cmd>lua require'telescope'.extensions.file_browser.file_browser()<CR>" },
        }
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
    {
        "nvim-lua/plenary.nvim",
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
        "williamboman/mason-lspconfig.nvim",
        config = true,
    },
    {
        "neovim/nvim-lspconfig",
        event = {"BufWritePre", "BufReadPre"},
        config = require"config.lspconfig",
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        event = "InsertEnter",
    },
    {
        "hrsh7th/cmp-buffer",
        event = {"InsertEnter", "BufRead"},
    },
    {
        "FelipeLema/cmp-async-path",
        event = {"InsertEnter", "CmdlineEnter"},
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
        "saadparwaiz1/cmp_luasnip",
        event = "InsertEnter",
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = require"config.cmp",
        dependencies = {"onsails/lspkind-nvim"}
    },
    {
        "hrsh7th/cmp-nvim-lua",
        event = "InsertEnter",
    },
    {
        "onsails/lspkind-nvim",
    }
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
                "netrwPlugin",
                "spellfile",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
                "rplugin",
                "editorconfig",
            },
        }
    }
}

require("lazy").setup(plugins, lazyopt)

