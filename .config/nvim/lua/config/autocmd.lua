local api = vim.api

api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    callback = function()
        local save_cursor = vim.fn.getpos('.')
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos('.', save_cursor)
    end,
})

api.nvim_create_autocmd('VimResized', {
    callback = function() vim.cmd.wincmd('=') end
})

api.nvim_create_autocmd('BufReadPost', {
    callback = function() vim.api.nvim_set_current_dir(vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand('%:p')), ':h')) end
})

api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.wo.number = false
        vim.cmd('startinsert!')
    end
})

api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'WinLeave' }, {
    callback = function()
        if vim.wo.cursorline == true then
            vim.wo.cursorline = false
        end
    end
})

api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    callback = function() vim.wo.cursorline = true end
})

api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank { higroup = 'IncSearch', timeout = 700 } end
})


local ui2 = require('vim._core.ui2')
local msgs = require('vim._core.ui2.messages')
local orig_set_pos = msgs.set_pos
msgs.set_pos = function(tgt)
    orig_set_pos(tgt)
    if (tgt == 'msg' or tgt == nil) and vim.api.nvim_win_is_valid(ui2.wins.msg) then
        pcall(api.nvim_win_set_config, ui2.wins.msg, {
            relative = 'editor',
            anchor = 'NE',
            row = 1,
            col = vim.o.columns - 1,
            border = 'rounded',
        })
    end
end
