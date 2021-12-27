-- plugin install
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  Packer_bootstrap = vim.fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
end

g.sqlite_clib_path = vim.fn.substitute(vim.fn.stdpath("data"), "\\", "/", "g") .. "/sqlite3.dll"

require "packer".startup(
  function(use)
    use "wbthomason/packer.nvim"

    -- performance improve
    use "lewis6991/impatient.nvim"
    use {
      "luukvbaal/stabilize.nvim",
      config = function() require("stabilize").setup() end
    }
    use "andymass/vim-matchup"
    use "nathom/filetype.nvim"
    use "antoinemadec/FixCursorHold.nvim"

    -- colorscheme
    -- use "tyrannicaltoucan/vim-deep-space"
    use "marko-cerovac/material.nvim"

    -- editor display
    use "MunifTanjim/nui.nvim"
    use {
      "VonHeikemen/fine-cmdline.nvim",
      requires = "MunifTanjim/nui.nvim"
      }
    use "lukas-reineke/indent-blankline.nvim"
    --[[ use {
      "akinsho/bufferline.nvim",
      requires = "kyazdani42/nvim-web-devicons"
    } ]]
    use "ojroques/nvim-bufbar"
    use "kyazdani42/nvim-web-devicons"
    use "norcalli/nvim-colorizer.lua"
    use "glepnir/dashboard-nvim"
    use {
      "glepnir/galaxyline.nvim",
      branch = "main",
      requires = {"kyazdani42/nvim-web-devicons", opt = true},
      config = function()
        local theme = vim.fn.stdpath("data") .. "/site/pack/packer/start/galaxyline.nvim/example/eviline.lua"
        vim.cmd("luafile " .. theme)
      end
    }
    use "jamestrew/dimmer.nvim"
    use "rickhowe/diffchar.vim"
    use "romainl/vim-qf"
    use "camspiers/animate.vim"
    use "camspiers/lens.vim"
    use "yamatsum/nvim-cursorline"
    use "nvim-treesitter/nvim-treesitter"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "vigoux/treesitter-context.nvim"
    use {
      "lewis6991/gitsigns.nvim",
      requires = {
        "nvim-lua/plenary.nvim"
      }
    }
    use {
      "folke/which-key.nvim",
      config = function()
        require"which-key".setup {}
        end
        }

    -- text/input manipulation
    use "windwp/nvim-autopairs"
    use "godlygeek/tabular"
    use {
      "abecodes/tabout.nvim",
      config = function()
        require("tabout").setup {
          tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
          backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
          ignore_beginning = false,
        }
      end,
      wants = {"nvim-treesitter"}, -- or require if not used so far
      after = {"nvim-autopairs"}
    }
    use "rhysd/accelerated-jk"
    use {
      "blackCauldron7/surround.nvim",
      config = function()
        require "surround".setup {mappings_style = "sandwich"}
      end
    }
    use "b3nj5m1n/kommentary"
    use "tpope/vim-sleuth"
    use "kana/vim-smartword"
    use "kana/vim-niceblock"
    use "haya14busa/vim-asterisk"
    use "terryma/vim-expand-region"
    use {"wincent/ferret", opt = true, cmd = {"Ack"}}
    use "kana/vim-operator-user"
    use "kana/vim-operator-replace"
    use {"tyru/capture.vim", opt = true, cmd = {"Capture"}}
    use "junegunn/vim-easy-align"

    -- file/directory
    use "tami5/sqlite.lua"
    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make"
    }
    use "nvim-telescope/telescope-file-browser.nvim"
    use {
      "nvim-telescope/telescope-frecency.nvim",
      requires = {"tami5/sqlite.lua"}
    }
    use {
      "nvim-telescope/telescope.nvim",
      requires = {"nvim-lua/plenary.nvim"}
    }
    use "januswel/fencja.vim"
    use "voldikss/vim-floaterm"

    -- git
    use "tpope/vim-fugitive"
    use {
      "TimUntersberger/neogit",
      requires = {"nvim-lua/plenary.nvim"}
      }
    use "nvim-lua/plenary.nvim"

    -- language support
    use "mechatroner/rainbow_csv"
    use "editorconfig/editorconfig-vim"

    -- lsp/completion
    use "williamboman/nvim-lsp-installer"
    use "neovim/nvim-lspconfig"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-vsnip"
    use "hrsh7th/vim-vsnip"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lua"
    use "mhartington/formatter.nvim"
    use "onsails/lspkind-nvim"
    opt.completeopt = "menu,menuone,longest,preview"

    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua"
    if Packer_bootstrap then
      require "packer".sync()
    end
  end
)

-- plugin variables

require "dimmer".setup {}

require "bufbar".setup {}

--[[ require "bufferline".setup {
  options = {
    diagnostics = "nvim_lsp"
  },
  highlights = {
    buffer_selected = {
      gui = "bold"
    }
  }
} ]]

require "indent_blankline".setup {
  show_current_context = true,
  show_current_context_start = true
}

require "nvim-treesitter.configs".setup {
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

require "telescope".setup {
  defaults = {
    winblend = 30,
    cache_picker = {limit_entries = 100},
    preview = {filesize_limit = 5, treesitter = true},
    mappings = {i = {["<Esc>"] = require "telescope.actions".close}}
  },
  extensions = {
    file_browser = {
      theme = "ivy"
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case"
    }
  }
}

require "telescope".load_extension("fzf")
require "telescope".load_extension("file_browser")
require "telescope".load_extension("frecency")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require "cmp"
local lspkind = require "lspkind"

cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      with_text = false,
      maxwidth = 50,
    })
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
          --[[ elseif has_words_before() then
          cmp.complete() ]]
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

require "formatter".setup {
  filetype = {
    lua = {
      -- luafmt
      function()
        return {
          exe = "luafmt",
          args = {"--indent-count", 2, "--stdin"},
          stdin = true
        }
      end
    }
  }
}

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has("win32") == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath("data") .. "/lsp_servers/sumneko_lua/extension/server"
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require "lspconfig".sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {"vim"}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true)
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false
      }
    }
  }
}

require "nvim-autopairs".setup {}

require "neogit".setup {
  disable_insert_on_commit = false,
  disable_commit_confirmation = true
}

g.material_style = "darker"

if g.is_windows then
  g.FerretNvim = 0
  g.FerretJob = 0
end

g.dashboard_custom_header = {
  " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
  " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
  " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
  " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
  " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
  " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝"
}

g.dashboard_default_executive = "telescope"

g.dashboard_custom_section = {
  a = {description = {"  Frecent Files      "}, command = "Telescope frecency"},
  b = {description = {"  Find File          "}, command = "Telescope find_files"},
  c = {description = {"  Plugin Settings    "}, command = ":e ~/.config/nvim/lua/plugins.lua"},
  d = {description = {"  Init Settings      "}, command = ":e ~/.config/nvim/init.lua"}
}
g.indent_blankline_buftype_exclude = {"help", "terminal"}
g.indent_blankline_filetype_exclude = {"startify", "dashboard", "alpha"}
g.indent_blankline_use_treesitter = true
g.better_whitespace_filetypes_blacklist = {"diff", "gitcommit", "qf", "help", "markdown"}

g.extradite_showhash = 1
g.extradite_diff_split = "belowright vertical split"

g.FerretExecutable = "rg,ag"
g.FerretExecutableArguments = {
  ag = "-i --vimgrep --hidden",
  rg = "--vimgrep --no-heading --hidden"
}

g.highlightedyank_highlight_duration = 300

g.floaterm_winblend = 40
g.floaterm_position = "center"

g.capture_open_command = ""
g.capture_override_buffer = "newbufwin"

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
api.nvim_set_keymap("n", "<Leader>a", "<Plug>(FerretAck)", {silent = true})
api.nvim_set_keymap("n", "<Leader>d", "<Cmd>Dashboard<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>df", "<Cmd>lua vim.lsp.buf.definition()<CR>", {silent = true})
api.nvim_set_keymap("n", "<Leader>f", "<Cmd>Telescope frecency<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>g", "<Cmd>Telescope live_grep<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>h", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>l", "<Plug>(FerretLack)", {})
api.nvim_set_keymap("n", "<Leader>b", "<Cmd>CocList buffers<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>m", "<Cmd>DashboardFindHistory<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader><Leader>", "<Cmd>Telescope<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>fh", "<Cmd>DashboardFindHistory<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>ff", "<Cmd>DashboardFindFile<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>fa", "<Cmd>DashboardFindWord<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>fb", "<Cmd>DashboardJumpMark<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>cn", "<Cmd>DashboardNewFile<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>fm", "<Cmd>Format<CR>", {noremap = true})
api.nvim_set_keymap("n", ";", "<Cmd>FineCmdline<CR>", {noremap = true, silent = true})

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
cmd [[autocmd MyAutoCmd ColorScheme * :highlight! link NonText vimade_0]]
cmd [[autocmd MyAutoCmd ColorScheme * :highlight! link SpecialKey vimade_0]]
cmd [[autocmd MyAutoCmd InsertEnter * inoremap <silent> <CR> <C-r>=v:lua.my_icr_function()<CR>]]
cmd [[autocmd MyAutoCmd BufEnter * :Sleuth]]
cmd [[autocmd MyAutoCmd InsertLeave * silent! pclose!]]
cmd [[autocmd MyAutoCmd OptionSet diff if &diff | call v:lua.my_diffenter_function() | endif]]
cmd [[autocmd MyAutoCmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&diff')) == 1 | call v:lua.my_diffexit_function() | endif]]
