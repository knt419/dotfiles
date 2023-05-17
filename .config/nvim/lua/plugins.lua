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
        event = {"BufWritePre", "BufReadPre"}
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
    {
        "rmehri01/onenord.nvim",
        lazy = true,
        config = function ()
            require"onenord".setup {}
        end
    },

    -- editor display
    {
        "MunifTanjim/nui.nvim",
        lazy = true
    },
    {
        "nvim-zh/colorful-winsep.nvim",
        event = "WinNew",
        config = function ()
            require"colorful-winsep".setup {}
        end
    },
    {
        "kevinhwang91/nvim-hlslens",
        event = {"BufNew", "BufRead"},
        config = function ()
            require"scrollbar.handlers.search".setup({
                override_lens = function () end,
            })
        end
    },
    {
        "petertriho/nvim-scrollbar",
        event = {
            "BufWinEnter",
            "CmdwinLeave",
            "TabEnter",
            "TermEnter",
            "TextChanged",
            "VimResized",
            "WinEnter",
            "WinScrolled",
        },
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
        config = function ()
            require"tint".setup {}
        end
    },
    {
        "rcarriga/nvim-notify",
        lazy = true,
        config = function ()
            require"notify".setup {
                render = "compact"
            }
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
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
        'nvimdev/indentmini.nvim',
        event = {"BufWrite", "BufRead"},
        config = function()
            require"indentmini".setup {
                exclude = {"mason", "lazy", "starter"}
            }
            cmd.highlight("default link IndentLine Whitespace")
        end,
    },
    -- {
    --     "willothy/nvim-cokeline",
    --     event = {"BufNew", "BufRead"},
    --     config = function ()
    --         local get_hex = require"cokeline/utils".get_hex

    --         require"cokeline".setup {
    --             default_hl = {
    --                 fg = function(buffer)
    --                 return
    --                     buffer.is_focused
    --                     and get_hex('Normal', 'fg')
    --                     or get_hex('Comment', 'fg')
    --                 end,
    --                 bg = 'NONE',
    --             },

    --             components = {
    --                 {
    --                     text = function(buffer) return (buffer.index ~= 1) and '│' or '' end,
    --                     fg = get_hex('Normal', 'fg')
    --                 },
    --                 {
    --                     text = function(buffer) return '  ' .. buffer.devicon.icon end,
    --                     fg = function(buffer) return buffer.devicon.color end,
    --                 },
    --                 {
    --                     text = function(buffer) return ' ' .. buffer.filename .. '  ' end,
    --                     style = function(buffer) return buffer.is_focused and 'bold' or nil end,
    --                 },
    --                 {
    --                     text = '',
    --                     delete_buffer_on_left_click = true,
    --                 },
    --                 {
    --                     text = '  ',
    --                 },
    --             },
    --         }
    --     end
    -- },
    -- {
    --     "nvimdev/whiskyline.nvim",
    --     event = {"BufNew", "BufRead"},
    --     dependencies = {"nvim-tree/nvim-web-devicons"},
    --     config = function()
    --         require"whiskyline".setup {
    --             bg = '#3B3E48'
    --         }
    --     end
    -- },
    {
        "ojroques/nvim-hardline",
        event = {"BufNew", "BufRead"},
        config = function ()
            require"hardline".setup {
                bufferline = true,
                theme = 'nordic',
            }
        end
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
        event = {"BufNew", "BufRead"},
    },
    {
        "echasnovski/mini.starter",
        event = "VimEnter",
        config = function()
            local starter = require('mini.starter')
            local footer_packages = (function()
                local count = 0
                local startup = 0
                local timer = vim.loop.new_timer()
                timer:start(0, 1000, vim.schedule_wrap(function()
                    local status, lazy = pcall(require, 'lazy')
                    if status then
                        count = lazy.stats().count
                        startup = lazy.stats().startuptime
                    end
                    MiniStarter.refresh()
                    if startup ~= 0 then
                        timer:stop()
                        return
                    end
                end))

                return function ()
                    return 'neovim loaded ' .. count .. ' packages, ' .. string.format('%.2f', startup) .. 'ms to launch 🚀'
                end
            end)()

            starter.setup({
                evaluate_single = true,
                header =
                            " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗\n" ..
                            " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║\n" ..
                            " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║\n" ..
                            " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║\n" ..
                            " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║\n" ..
                            " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝\n" ..
                            "\n"
                ,
                footer = footer_packages,
                items = {
                starter.sections.builtin_actions(),
                starter.sections.recent_files(9, false),
                },
                content_hooks = {
                starter.gen_hook.adding_bullet(),
                starter.gen_hook.indexing('all', { 'Builtin actions' }),
                starter.gen_hook.aligning('center', 'center'),
                },
            })
        end,
        keys = {
            { "<Up>", "<Cmd>lua MiniStarter.open()<CR>" }
        }
    },
    {
        "rickhowe/diffchar.vim",
        event = {"BufNew", "BufRead"},
    },
    {
        "yamatsum/nvim-cursorline",
        event = {"BufNew", "BufRead"},
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = {"BufWritePre", "BufReadPre"},
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
        "echasnovski/mini.surround",
        event = {"BufNew", "BufRead"},
        config = function()
            require"mini.surround".setup{}
        end
    },
    {
        "tpope/vim-commentary",
        event = {"BufWritePre", "BufReadPre"},
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
        event = {"BufNew", "BufRead"},
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
        event = {"BufNew", "BufRead"},
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
    {"equalsraf/neovim-gui-shim"},
    {
        "aymericbeaumet/vim-symlink",
        event = "BufReadPre",
    },
    {
        "tami5/sqlite.lua",
        lazy = true
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
        cmd = "Telescope",
        config = function()
            local telescope = require"telescope"
            telescope.setup {
                defaults = {
                    winblend = 30,
                    cache_picker = {limit_entries = 100},
                    preview = {filesize_limit = 5, treesitter = true},
                    mappings = {i = {["<Esc>"] = require"telescope.actions".close}},
                },
                pickers = {
                    find_files = {
                        theme = "ivy",
                        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    }
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
                }
            }
            telescope.load_extension("fzf")
            telescope.load_extension("file_browser")
            telescope.load_extension("frecency")
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
        event = {"BufWritePre", "BufReadPre"},
        ft = "csv",
        config = function ()
            require"csvtools".setup {}
        end
    },

    -- lsp/completion
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        cmd = "Mason",
        config = function()
            require"mason".setup {}
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        config = function()
            require"mason-lspconfig".setup{
                ensure_installed = { "lua_ls", "sqlls", "bashls", "clangd", "vimls"}
            }
        end
    },
    {
        "neovim/nvim-lspconfig",
        event = {"BufWritePre", "BufReadPre"},
        config = function()
            local lspconfig = require"lspconfig"
            local util = require"lspconfig/util"
            local capabilities = require"cmp_nvim_lsp".default_capabilities()
            local on_attach = function()
                local keymap = vim.keymap
                keymap.set("n", "<Leader>rf", "<Cmd>lua vim.lsp.buf.references()<CR>")
                keymap.set("n", "<Leader>df", "<Cmd>lua vim.lsp.buf.definition()<CR>")
                keymap.set("n", "<Leader>wa", "<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
                keymap.set("n", "<Leader>wr", "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
                keymap.set("n", "<Leader>wl", "<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
                keymap.set("n", "<Leader>h", "<Cmd>lua vim.lsp.buf.hover()<CR>")
                keymap.set("x", "<Leader>f", "<Cmd>lua vim.lsp.buf.formatting()<CR>")
            end
            require"mason-lspconfig".setup_handlers{
                function (server_name)
                    lspconfig[server_name].setup{
                        on_attach = on_attach,
                        capabilities = capabilities,
                    }
                end,
            }

            lspconfig.lua_ls.setup{
                root_dir =  util.find_git_ancestor,
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {'vim'}
                        }
                    }
                }
            }
        end
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        event = "InsertEnter",
    },
    {
        "hrsh7th/cmp-buffer",
        event = "InsertEnter",
    },
    {
        "FelipeLema/cmp-async-path",
        event = "InsertEnter",
    },
    {
        "hrsh7th/cmp-cmdline",
        event = "VeryLazy",
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
        config = function()
            local cmp = require"cmp"
            local lspkind = require"lspkind"
            local luasnip = require"luasnip"

            require"cmp".setup {
                formatting = {
                    format = lspkind.cmp_format(
                        {
                            with_text = true,
                            maxwidth = 50,
                            ellipsis_char = '...'
                        }
                    )
                },
                snippet = {
                    expand = function(args)
                        require'luasnip'.lsp_expand(args.body)
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
                            elseif luasnip.expand_or_jumpable() then
                                luasnip.expand_or_jump()
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
                            elseif luasnip.jumpable(-1) then
                                luasnip.jump(-1)
                            end
                        end,
                        {"i", "s"}
                    )
                },
                sources = cmp.config.sources(
                    {
                        {name = "nvim_lsp"},
                        {name = "nvim_lua"},
                        {name = "luasnip"}
                    },
                    {
                        {name = "buffer"}
                    }
                )
            }
            cmp.setup.cmdline(
                "/",
                {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = {
                        {name = "buffer"}
                    }
                }
            )
            cmp.setup.cmdline(
                ":",
                {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources(
                        {
                            {name = "async_path"}
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
