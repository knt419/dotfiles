return function()
    require('nvim-treesitter').setup()
    local ts_install = require('nvim-treesitter.config')
    local ensureInstalled = {
        'lua', 'vim', 'java', 'c', 'bash', 'markdown'
    }
    local alreadyInstalled = ts_install.get_installed()
    local parsersToInstall = vim.iter(ensureInstalled)
        :filter(function(parser)
            return not vim.tbl_contains(alreadyInstalled, parser)
        end)
        :totable()
    require('nvim-treesitter').install(parsersToInstall)
    vim.api.nvim_create_autocmd('FileType', {
        pattern = ensureInstalled,
        callback = function()
            vim.treesitter.start()
            vim.bo.indentexpr = 'v:lua.require"nvim-treesitter".indentexpr()'
            vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo[0][0].foldmethod = 'expr'
        end,
    })
end
