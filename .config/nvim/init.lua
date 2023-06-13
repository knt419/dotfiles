--____________________________________________________________________
----------------------------------------------------------------------\
--    _________  _______   ________  ___      ___ ___  ______ ______   \
--   |\   ___  \|\   ___\ |\   __  \|\  \    /  /|\  \|\   __\| __  \   \
--   \ \  \_ \  \ \  \__| \ \  \|\  \ \  \  /  / | \  \ \  \ \  \ \  \   \
--    \ \  \\ \  \ \   __\ \ \  \\\  \ \  \/  / / \ \  \ \  \ \__\ \  \   \
--     \ \  \\ \  \ \  \_|__\ \  \\\  \ \    / /   \ \  \ \  \|__|\ \  \   \
--      \ \__\\ \__\ \_______\ \_______\ \__/ /     \ \__\ \__\    \ \__\   \
--       \|__| \|__|\|_______|\|_______|\|__|/       \|__|\|__|     \|__|    \
--____________________________________________________________________________\
--____________________________________________________________________________|
vim.scriptencoding = "utf-8"
vim.loader.enable()

-- option
require"config.option"

-- load plugins
require"plugins"

-- keymap,autocmd
vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
        require"config.keymap"
        require"config.autocmd"
        if vim.api.nvim_buf_line_count(0) <= 1 then
            local starter = require"mini.starter"
            local stats = require"lazy".stats()
            starter.config.footer = 'neovim loaded ' .. stats.count .. ' packages in ' .. string.format("%.2f",stats.startuptime) .. 'ms 🚀'
            pcall(starter.open)
        end
        vim.cmd.cd"~"
    end
})
