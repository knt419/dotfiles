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

-- option
require"config.option"

-- load plugins
vim.loader.enable()
require"plugins"

-- keymap,autocmd
vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
        require"config.keymap"
        require"config.autocmd"
        if vim.bo.filetype == "starter" then
            local starter = require"mini.starter"
            local stats = require"lazy".stats()
            starter.config.footer = 'neovim loaded ' .. stats.count .. ' packages, ' .. string.format("%.2f",stats.startuptime) .. 'ms to launch 🚀'
            pcall(starter.refresh)
        end
        vim.cmd.cd"~"
    end
})
