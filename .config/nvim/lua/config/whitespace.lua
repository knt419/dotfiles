return function()
    vim.g.better_whitespace_filetypes_blacklist = {"diff", "gitcommit", "qf", "help", "markdown", "dashboard"}

    vim.api.nvim_create_autocmd("OptionSet", {
        pattern = "diff",
        command = "DisableWhitespace"
    })

    vim.api.nvim_create_autocmd("WinEnter", {
        pattern = "*",
        callback = function()
            if vim.fn.winlayout()[1] == "leaf"
                and vim.fn.tabpagenr("$") == 1
                and vim.wo.diff == true then
                vim.cmd [[EnableWhitespace]]
                vim.wo.diff = false
            end
        end,
    })
end
