-- plugin install
local api = vim.api
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
        event = "BufNew"
    },

    -- colorscheme
    {
        "tyrannicaltoucan/vim-deep-space",
        lazy = true
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        config = function ()
            require"kanagawa".setup{
                commentStyle = { italic = false },
                keywordStyle = { italic = false },
                dimInactive = true
            }
        end
    },
    {
        "marko-cerovac/material.nvim",
        lazy = true,
        config = function()
            g.material_style = "darker"
            require"material".setup {
                contrast = {
                    floating_windows = true,
                    non_current_windows = true
                },
                plugins = {
                    "dashboard",
                    "gitsigns",
                    "indent-blankline",
                    "nvim-cmp",
                    "nvim-web-devicons",
                    "telescope"
                }
            }
        end,
        keys = {
            { "<Leader>m", "<Cmd>lua require'material.functions'.find_style()<CR>", silent = true },
        }
    },
    {
        "sainnhe/edge",
        lazy = true,
        config = function ()
            g.edge_style = 'aura'
            g.edge_disable_italic_comment = 1
            g.edge_transparent_background = 0
            g.edge_dim_inactive_windows = 1
        end
    },
    {
        "alexeyneu/blue-moon",
        lazy = true
    },

    -- editor display
    {
        "MunifTanjim/nui.nvim",
        lazy = true
    },
    {
        "unblevable/quick-scope",
        event = "BufEnter"
    },
    {
        "nvim-zh/colorful-winsep.nvim",
        event = "BufEnter",
        config = function ()
            require"colorful-winsep".setup {}
        end
    },
    {
        "kevinhwang91/nvim-hlslens",
        event = "BufNewFile, BufRead",
        config = function ()
            require"scrollbar.handlers.search".setup({
                override_lens = function () end,
            })
        end
    },
    {
        "petertriho/nvim-scrollbar",
        event = "BufNew",
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
        event = "BufEnter",
        config = function ()
            require"tint".setup {}
        end
    },
    {
        "rcarriga/nvim-notify",
        lazy = true
    },
    {
        "folke/noice.nvim",
        event = "CmdlineEnter",
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true
                    }
                },
                presets = {
                    inc_rename = true
                }
            })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify"
        }
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufEnter",
        config = function()
            require"indent_blankline".setup {
                show_current_context = true,
                show_current_context_start = true,
                buftype_exclude = {"help", "terminal"},
                filetype_exclude = {"startify", "dashboard", "alpha", "mason", "lazy"},
                use_treesitter = true
            }
        end
    },
    {
        "akinsho/bufferline.nvim",
        config = function()
            require"bufferline".setup {
                options = {
                    diagnostics = "nvim_lsp"
                },
                highlights = {
                    buffer_selected = {
                        bold = true
                    }
                }
            }
        end,
        dependencies = "nvim-tree/nvim-web-devicons"
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        config = function ()
            require"nvim-web-devicons".setup {
                color_icons = true}
        end
    },
    {
        "norcalli/nvim-colorizer.lua",
        event = "BufNewFile, BufRead"
    },
    {
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        config = function()
            require("dashboard").setup {
                config = {
                    header = {
                        " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
                        " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
                        " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
                        " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
                        " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
                        " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
                        ""
                    },
                    shortcut = {
                        {
                            desc = ' Update',
                            group = 'column0',
                            action = 'Lazy update',
                            key = 'u'
                        },
                        {
                            desc = ' Files',
                            group = 'column1',
                            action = 'Telescope frecency theme=ivy',
                            key = 'f',
                        },
                        {
                            desc = ' Directory',
                            group = 'column2',
                            action = 'Telescope file_browser theme=ivy',
                            key = 'd',
                        },
                        {
                            desc = ' init.lua',
                            group = 'column3',
                            action = ':e ~/.config/nvim/init.lua',
                            key = 'i'
                        },
                        {
                            desc = ' plugins.lua',
                            group = 'column4',
                            action = ':e ~/.config/nvim/lua/plugins.lua',
                            key = 'p'
                        }
                    },
                    project = { enable = true, limit = 8, action = 'Telescope find_files cwd=' }
                }
            }
        end,
        dependencies = {"nvim-tree/nvim-web-devicons"},
        keys = {
            { "<Leader>d", "<Cmd>Dashboard<CR>", silent = true },
            { "<Up>", "<Cmd>Dashboard<CR>" },
        }
    },
    {
        "nvimdev/whiskyline.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            require"whiskyline".setup {
                bg = '#3B3E48'
            }
        end
    },
    {
        "rickhowe/diffchar.vim",
        event = "BufNewFile, BufRead",
    },
    {
        "yamatsum/nvim-cursorline",
        event = "BufNewFile, BufRead",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufEnter",
        config = function()
            require"nvim-treesitter.configs".setup {
                auto_install = true,
                highlight = {
                    enable = true
                },
                indent = {
                    enable = true
                },
                matchup = {
                    enable = true
                },
                pairs = {
                    enable = true,
                    keymaps = {
                        goto_partner = "<leader>%",
                        delete_balanced = "X"
                    },
                    delete_balanced = {
                        only_on_first_char = false,
                        longest_partner = false
                    }
                }
            }
        end
    },
    -- {"nvim-treesitter/nvim-treesitter-textobjects"},
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
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
        config = function()
            require"nvim-autopairs".setup {}
        end
    },
    {
        "godlygeek/tabular",
        cmd = "Tabularize"
    },
    {
        "lilibyte/tabhula.nvim",
        event = "InsertEnter",
        config = function ()
            require"tabhula".setup{}
        end
    },
    {
        "rhysd/accelerated-jk",
        keys = {
            { "j", "<Plug>(accelerated_jk_gj)" },
            { "k", "<Plug>(accelerated_jk_gk)" }
        }
    },
    {
        "ur4ltz/surround.nvim",
        event = "BufEnter",
        config = function()
            require"surround".setup {mappings_style = "sandwich"}
        end
    },
    {
        "b3nj5m1n/kommentary",
        event = "BufEnter"
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
        event = "BufNewFile, BufRead",
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
        event = "BufNewFile, BufRead",
        config = function()
            g.better_whitespace_filetypes_blacklist = {"diff", "gitcommit", "qf", "help", "markdown", "dashboard"}
        end
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
        lazy = true
    },
    {
        "ahmedkhalf/project.nvim",
        lazy = true,
        config = function ()
            require"project_nvim".setup{}
        end
    },
    {
        "jemag/telescope-diff.nvim",
        keys = {
            { "<Leader>di", function ()
                                require"telescope".extensions.diff.diff_files({ hidden = true})
                            end },
            { "<Leader>dc", function ()
                                require"telescope".extensions.diff.diff_current({ hidden = true})
                            end }
        }
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = true,
        build = "make"
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        lazy = true,
    },
    {
        "nvim-telescope/telescope-frecency.nvim",
        lazy = true,
        dependencies = {"tami5/sqlite.lua"}
    },
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            local telescope = require"telescope"
            telescope.setup {
                defaults = {
                    winblend = 30,
                    cache_picker = {limit_entries = 100},
                    preview = {filesize_limit = 5, treesitter = true},
                    mappings = {i = {["<Esc>"] = require"telescope.actions".close}},
                },
                extensions = {
                    file_browser = {
                        theme = "ivy",
                        hidden = true
                    },
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case"
                    },
                    project = {
                        hidden_files = true
                    }
                }
            }
            telescope.load_extension("fzf")
            telescope.load_extension("file_browser")
            telescope.load_extension("frecency")
            telescope.load_extension("projects")
            telescope.load_extension("diff")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<Leader>f", "<Cmd>Telescope frecency theme=ivy<CR>", silent = true },
            { "<Leader>g", "<Cmd>Telescope live_grep theme=ivy<CR>", silent = true },
            { "<Leader><Leader>", "<Cmd>Telescope builtin theme=ivy<CR>", silent = true },
            { "<Left>", "<Cmd>lua require'telescope'.extensions.file_browser.file_browser()<CR>" },
            { "<Leader>e", "<Cmd>lua require'telescope'.extensions.file_browser.file_browser()<CR>", silent = true }
        }
    },
    {
        "januswel/fencja.vim",
        event = "BufReadPre"
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
            g.lazygit_floating_window_corner_chars = {'╭', '╮', '╰', '╯' }
            g.lazygit_floating_window_use_plenary = 0
        end,
        keys = {
            { "<Right>", "<Cmd>LazyGit<CR>" }
        }
    },
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },

    -- language support
    {
        "Decodetalkers/csv-tools.lua",
        ft = "csv",
        config = function ()
            require"csvtools".setup {}
        end
    },

    -- lsp/completion
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        config = function()
            require"mason".setup {}
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        cmd = "Mason",
        config = function()
            require"mason-lspconfig".setup()
        end
    },
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        config = function()
            local lspconfig = require"lspconfig"
            local util = require"lspconfig/util"
            local capabilities = require"cmp_nvim_lsp".default_capabilities()

            lspconfig.lua_ls.setup{
                root_dir =  util.find_git_ancestor,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {'vim'}
                        }
                    }
                }
            }
            lspconfig.sqlls.setup{ capabilities = capabilities }
            lspconfig.bashls.setup{ capabilities = capabilities }
            lspconfig.clangd.setup{ capabilities = capabilities }
        end,
        keys = {
            { "<Leader>rf", "<Cmd>lua vim.lsp.buf.references()<CR>", silent = true },
            { "<Leader>df", "<Cmd>lua vim.lsp.buf.definition()<CR>", silent = true },
            { "<Leader>h", "<Cmd>lua vim.lsp.buf.hover()<CR>", silent = true },
            { "<Leader>f", "<Cmd>lua vim.lsp.buf.formatting()<CR>", mode = "x", silent = true }
        },
        dependencies = {"hrsh7th/cmp-nvim-lsp"}
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        lazy = true
    },
    {
        "hrsh7th/cmp-buffer",
        event = "InsertEnter",
    },
    {
        "hrsh7th/cmp-path",
        event = "InsertEnter",
    },
    {
        "hrsh7th/cmp-cmdline",
        lazy = true
    },
    {
        "hrsh7th/cmp-vsnip",
        event = "InsertEnter",
    },
    {
        "hrsh7th/vim-vsnip",
        event = "InsertEnter",
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function()
            local cmp = require"cmp"
            local lspkind = require"lspkind"

            local feedkey = function(key, mode)
                api.nvim_feedkeys(api.nvim_replace_termcodes(key, true, true, true), mode, true)
            end
            require"cmp".setup {
                formatting = {
                    format = lspkind.cmp_format(
                        {
                            with_text = false,
                            maxwidth = 50
                        }
                    )
                },
                snippet = {
                    expand = function(args)
                        fn["vsnip#anonymous"](args.body)
                    end
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = {
                    ["<CR>"] = cmp.mapping.confirm({select = true}),
                    ["<Tab>"] = cmp.mapping(
                        function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            elseif fn["vsnip#available"](1) == 1 then
                                feedkey("<Plug>(vsnip-expand-or-jump)", "")
                            else
                                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                            end
                        end,
                        {"i", "s"}
                    ),
                    ["<S-Tab>"] = cmp.mapping(
                        function()
                            if cmp.visible() then
                                cmp.select_prev_item()
                            elseif fn["vsnip#jumpable"](-1) == 1 then
                                feedkey("<Plug>(vsnip-jump-prev)", "")
                            end
                        end,
                        {"i", "s"}
                    )
                },
                sources = cmp.config.sources(
                    {
                        {name = "nvim_lsp"},
                        {name = "nvim_lua"},
                        {name = "vsnip"}
                    },
                    {
                        {name = "buffer"}
                    }
                )
            }
            cmp.setup.cmdline(
                "/",
                {
                    sources = {
                        {name = "buffer"}
                    }
                }
            )
            cmp.setup.cmdline(
                ":",
                {
                    sources = cmp.config.sources(
                        {
                            {name = "path"}
                        },
                        {
                            {name = "cmdline"}
                        }
                    )
                }
            )
        end,
        dependencies = {"onsails/lspkind-nvim"}
    },
    {
        "hrsh7th/cmp-nvim-lua",
        event = "InsertEnter",
    },
    {
        "mhartington/formatter.nvim",
        config = function()
            require"formatter".setup {
                filetype = {
                    lua = {
                        -- luafmt
                        function()
                            return {
                                exe = "luafmt",
                                args = {"--indent-count", 4, "--stdin"},
                                stdin = true
                            }
                        end
                    }
                }
            }
        end,
        keys = {
            { "<Leader>fm", "<Cmd>Format<CR>" }
        }
    },
    {
        "onsails/lspkind-nvim",
        lazy = true
    }
}

local lazyopt = {
    concurrency = 8,
    git = {
        timeout = 300
    }
}

require("lazy").setup(plugins, lazyopt)

-- functions

_G.my_diffenter_function = function()
    cmd [[DisableWhitespace]]
end

_G.my_diffexit_function = function()
    cmd [[EnableWhitespace]]
    cmd [[diffoff]]
end

cmd [[autocmd MyAutoCmd InsertLeave * silent! pclose!]]
cmd [[autocmd MyAutoCmd OptionSet diff if &diff | call v:lua.my_diffenter_function() | endif]]
cmd [[autocmd MyAutoCmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&diff')) == 1 | call v:lua.my_diffexit_function() | endif]]
