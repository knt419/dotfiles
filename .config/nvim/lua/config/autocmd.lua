local api = vim.api

api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

api.nvim_create_autocmd('VimResized', {
    callback = function () vim.cmd.wincmd('=') end
})

api.nvim_create_autocmd('BufReadPost', {
    callback = function () vim.api.nvim_set_current_dir(vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand('%:p')), ':h')) end
})

api.nvim_create_autocmd('TermOpen', {
    callback = function ()
        vim.wo.number = false
        vim.cmd('startinsert!')
    end
})

api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI', 'WinLeave'}, {
    callback = function ()
        if vim.wo.cursorline == true then
            vim.wo.cursorline = false
        end
    end
})

api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
    callback = function () vim.wo.cursorline = true end
})

api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank{higroup='IncSearch', timeout=700} end
})
