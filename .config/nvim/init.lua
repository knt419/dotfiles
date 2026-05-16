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

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinNew", "WinEnter", "InsertEnter" }, {
    pattern = "*",
    callback = function()
        local ft = vim.bo.filetype
        -- snacks_picker のすべてのパーツを対象にする
        if ft:match("^snacks_picker_") then
            vim.schedule(function()
                -- 現在のタブページ内のすべてのウィンドウをスキャンして強制適用
                for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                    if vim.api.nvim_win_is_valid(win) then
                        local buf = vim.api.nvim_win_get_buf(win)
                        -- 安全にファイルタイプを取得 (エラーの原因だった箇所を修正)
                        local win_ft = vim.bo[buf].filetype
                        if win_ft and win_ft:match("^snacks_picker_") then
                            vim.api.nvim_win_set_option(win, "winblend", 25)
                        end
                    end
                end
            end)
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

vim.schedule(function()
    local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
    local base_bg = normal_hl and normal_hl.bg or nil

    -- snacks_picker 関連の背景を明示的に Normal と同じにするか、カラースキーム依存の不透明色をリセット
    vim.api.nvim_set_hl(0, "SnacksPicker", { bg = base_bg })
    vim.api.nvim_set_hl(0, "SnacksPickerInput", { bg = base_bg })
    vim.api.nvim_set_hl(0, "SnacksPickerPreview", { bg = base_bg })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = base_bg })
end)
