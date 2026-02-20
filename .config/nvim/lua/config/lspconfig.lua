return function()
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local bufnr = args.buf
        local opts = { buffer = bufnr, noremap = true, silent = true }

        vim.keymap.set('n', 'gf', vim.lsp.buf.format, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
      end,
    })
    vim.lsp.config("lua_ls", {
     settings = {
             Lua = {
                 diagnostics = {
                      globals = { "vim" }
                 }
             }
         }
    })
    vim.lsp.enable(require('mason-lspconfig').get_installed_servers())
end
