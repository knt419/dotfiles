local api = vim.api

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
        -- if env.NVIM == nil then
        --     env.VISUAL = 'nvim --remote'
        -- else
        --     env.VISUAL = 'nvim --server ' .. env.NVIM .. ' --remote'
        -- end
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

