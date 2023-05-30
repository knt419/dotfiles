local api = vim.api
api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function ()
        vim.wo.number = false
        vim.cmd"startinsert!"
        -- if env.NVIM == nil then
        --     env.VISUAL = "nvim --remote"
        -- else
        --     env.VISUAL = "nvim --server " .. env.NVIM .. " --remote"
        -- end
    end
})
api.nvim_create_autocmd({"CursorMoved", "CursorMovedI", "WinLeave"}, {
    pattern = "*",
    callback = function ()
        if vim.wo.cursorline == true then
            vim.wo.cursorline = false
        end
    end
})
api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
    pattern = "*",
    callback = function () vim.wo.cursorline = true end
})
api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function() vim.highlight.on_yank{higroup="IncSearch", timeout=700} end
})
