-- plugin install
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
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

vim.opt.rtp:prepend(lazypath)

g.sqlite_clib_path = vim.fn.substitute(vim.fn.stdpath("data"), "\\", "/", "g") .. "/sqlite3.dll"

plugins = {
    -- performance improve
    {
        "luukvbaal/stabilize.nvim",
        config = function()
            require("stabilize").setup()
        end
    },
    {"nathom/filetype.nvim"},
    {"antoinemadec/FixCursorHold.nvim"},
    -- colorscheme
    {"tyrannicaltoucan/vim-deep-space"},
    {"marko-cerovac/material.nvim"},
    -- editor display
    {"MunifTanjim/nui.nvim"},
    {"rcarriga/nvim-notify"},
    {
        "folke/noice.nvim",
        config = function()
            require("noice").setup({})
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify"
        }
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require "indent_blankline".setup {
                show_current_context = true,
                show_current_context_start = true,
                buftype_exclude = {"help", "terminal"},
                filetype_exclude = {"startify", "dashboard", "alpha"},
                use_treesitter = true
            }
        end
    },
    {
        "akinsho/bufferline.nvim",
        config = function()
            require "bufferline".setup {
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
    {"nvim-tree/nvim-web-devicons"},
    {"norcalli/nvim-colorizer.lua"},
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
                        " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝"
                    }
                }
            }
        end,
        dependencies = {"nvim-tree/nvim-web-devicons"}
    },
    {
        "glepnir/galaxyline.nvim",
        branch = "main",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            local theme = vim.fn.stdpath("data") .. "/lazy/galaxyline.nvim/example/eviline.lua"
            vim.cmd("luafile " .. theme)
        end
    },
    {"rickhowe/diffchar.vim"},
    {"yamatsum/nvim-cursorline"},
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require "nvim-treesitter.configs".setup {
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
    {"nvim-treesitter/nvim-treesitter-textobjects"},
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        }
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require "nvim-autopairs".setup {}
        end
    },
    {"godlygeek/tabular"},
    {
        "abecodes/tabout.nvim",
        config = function()
            require("tabout").setup {
                tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
                backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
                ignore_beginning = false
            }
        end
        --[[ wants = {"nvim-treesitter"}, -- or require if not used so far
      after = {"nvim-autopairs"} ]]
    },
    {"rhysd/accelerated-jk"},
    {
        "ur4ltz/surround.nvim",
        config = function()
            require "surround".setup {mappings_style = "sandwich"}
        end
    },
    {"b3nj5m1n/kommentary"},
    {"kana/vim-smartword"},
    {"kana/vim-niceblock"},
    {"haya14busa/vim-asterisk"},
    {"terryma/vim-expand-region"},
    {"junegunn/vim-easy-align"},
    -- file/directory
    {"tami5/sqlite.lua"},
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
    },
    {"nvim-telescope/telescope-file-browser.nvim"},
    {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = {"tami5/sqlite.lua"}
    },
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            local telescope = require "telescope"
            telescope.setup {
                defaults = {
                    winblend = 30,
                    cache_picker = {limit_entries = 100},
                    preview = {filesize_limit = 5, treesitter = true},
                    mappings = {i = {["<Esc>"] = require "telescope.actions".close}}
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
                    }
                }
            }
            telescope.load_extension("fzf")
            telescope.load_extension("file_browser")
            telescope.load_extension("frecency")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-frecency.nvim"
        }
    },
    {"januswel/fencja.vim"},
    -- git
    {"tpope/vim-fugitive"},
    {
        "TimUntersberger/neogit",
        config = function()
            require "neogit".setup {
                disable_insert_on_commit = false,
                disable_commit_confirmation = true
            }
        end,
        dependencies = {"nvim-lua/plenary.nvim"}
    },
    {"nvim-lua/plenary.nvim"},

    -- language support
    {"mechatroner/rainbow_csv"},
    {"editorconfig/editorconfig-vim"},

    -- lsp/completion
    {
        "williamboman/mason.nvim",
        config = function()
            require "mason".setup {}
        end
    },
    {"neovim/nvim-lspconfig"},
    {"hrsh7th/cmp-nvim-lsp"},
    {"hrsh7th/cmp-buffer"},
    {"hrsh7th/cmp-path"},
    {"hrsh7th/cmp-cmdline"},
    {"hrsh7th/cmp-vsnip"},
    {"hrsh7th/vim-vsnip"},
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require "cmp"
            local lspkind = require "lspkind"

            require "cmp".setup {
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
                        vim.fn["vsnip#anonymous"](args.body)
                    end
                },
                mapping = {
                    ["<CR>"] = cmp.mapping.confirm({select = true}),
                    ["<Tab>"] = cmp.mapping(
                        function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            elseif vim.fn["vsnip#available"](1) == 1 then
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
                            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
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
    {"hrsh7th/cmp-nvim-lua"},
    {
        "mhartington/formatter.nvim",
        config = function()
            require "formatter".setup {
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
        end
    },
    {"onsails/lspkind-nvim"}
}

require("lazy").setup(plugins)

opt.completeopt = "menu,menuone,longest,preview"

-- plugin variables

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

g.material_style = "darker"

g.better_whitespace_filetypes_blacklist = {"diff", "gitcommit", "qf", "help", "markdown"}

g.highlightedyank_highlight_duration = 300

vim.env.VISUAL = "nvr --remote-wait"
vim.env.PATH = vim.env.PATH .. ":" .. vim.env.HOME .. "/go/bin"

g.nefertiti_base_brightness_level = 14
g.sierra_Sunset = 1
g.edge_style = "neon"
g.edge_disable_italic_comment = 1

g.markdown_fenced_languages = {
    "vim",
    "help"
}

-- plugin keymaps

api.nvim_set_keymap("", "*", "<Plug>(asterisk-z*)", {})
api.nvim_set_keymap("", "g*", "<Plug>(asterisk-gz*)", {})
api.nvim_set_keymap("", "#", "<Plug>(asterisk-#)", {})
api.nvim_set_keymap("", "g#", "<Plug>(asterisk-g#)", {})

api.nvim_set_keymap("i", "<C-l>", "<C-r>=lexima#insmode#leave(1, '<C-g>U<Right>')<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
api.nvim_set_keymap("n", "w", "<Plug>(smartword-w)", {})
api.nvim_set_keymap("n", "b", "<Plug>(smartword-b)", {})
api.nvim_set_keymap("n", "e", "<Plug>(smartword-e)", {})
api.nvim_set_keymap("n", "ge", "<Plug>(smartword-ge)", {})
api.nvim_set_keymap("n", "s", "<Plug>(operator-replace)", {})
api.nvim_set_keymap("n", "tt", "<Cmd>FloatermToggle<CR>", {noremap = true, silent = true})

api.nvim_set_keymap("n", "<Up>", "<Cmd>Neogit push<CR>", {noremap = true})
api.nvim_set_keymap("n", "<Down>", "<Cmd>Neogit pull<CR>", {noremap = true})
api.nvim_set_keymap("n", "<Right>", "<Cmd>Neogit<CR>", {noremap = true})
api.nvim_set_keymap(
    "n",
    "<Left>",
    "<Cmd>lua require'telescope'.extensions.file_browser.file_browser()<CR>",
    {noremap = true}
)
api.nvim_set_keymap(
    "n",
    "<Leader>e",
    "<Cmd>lua require'telescope'.extensions.file_browser.file_browser()<CR>",
    {noremap = true, silent = true}
)
api.nvim_set_keymap("n", "<Leader>rf", "<Cmd>lua vim.lsp.buf.references()<CR>", {silent = true})
api.nvim_set_keymap("n", "<Leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", {silent = true})
api.nvim_set_keymap("n", "<Leader>d", "<Cmd>Dashboard<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>df", "<Cmd>lua vim.lsp.buf.definition()<CR>", {silent = true})
api.nvim_set_keymap("n", "<Leader>f", "<Cmd>Telescope frecency<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>g", "<Cmd>Telescope live_grep<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>h", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader><Leader>", "<Cmd>Telescope<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>fm", "<Cmd>Format<CR>", {noremap = true})

api.nvim_set_keymap("x", "v", "<Plug>(expand_region_expand)", {})
api.nvim_set_keymap("x", "<C-v>", "<Plug>(expand_region_shrink)", {})
api.nvim_set_keymap("x", "<Leader>f", "<Cmd>lua vim.lsp.buf.formatting()<CR>", {silent = true})
api.nvim_set_keymap("x", "<CR>", "<Plug>(LiveEasyAlign)", {})

-- functions

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.my_icr_function = function()
    return fn.pumvisible() == 1 and t "<C-y>" or t "<CR>"
end

_G.my_diffenter_function = function()
    cmd [[DisableWhitespace]]
end

_G.my_diffexit_function = function()
    cmd [[EnableWhitespace]]
    cmd [[diffoff]]
end

cmd [[autocmd MyAutoCmd ColorScheme * :highlight Comment gui=none]]
cmd [[autocmd MyAutoCmd InsertEnter * inoremap <silent> <CR> <C-r>=v:lua.my_icr_function()<CR>]]
cmd [[autocmd MyAutoCmd InsertLeave * silent! pclose!]]
cmd [[autocmd MyAutoCmd OptionSet diff if &diff | call v:lua.my_diffenter_function() | endif]]
cmd [[autocmd MyAutoCmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&diff')) == 1 | call v:lua.my_diffexit_function() | endif]]
