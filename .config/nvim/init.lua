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
vim.env.LANG = 'en'
vim.scriptencoding = 'utf-8'
vim.loader.enable()

-- option
require('config.option')

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'msg',
    callback = function()
        local ui2 = require('vim._core.ui2')
        local win = ui2.wins and ui2.wins.msg
        if win and vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_set_option_value(
                'winhighlight',
                'NormalFloat:MsgArea',
                { scope = 'local', win = win }
            )
        end
    end,
})

-- load plugins
require('plugins')

-- keymap,autocmd
vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
        require('config.keymap')
        require('config.autocmd')
        vim.cmd.cd('~')
    end
})
