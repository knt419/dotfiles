return function()
    local lspconfig = require('lspconfig')
    local util = require('lspconfig/util')
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local on_attach = function()
        local keymap = vim.keymap
        keymap.set('n', '<Leader>rf', '<Cmd>lua vim.lsp.buf.references()<CR>')
        keymap.set('n', '<Leader>df', '<Cmd>lua vim.lsp.buf.definition()<CR>')
        keymap.set('n', '<Leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
        keymap.set('n', '<Leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
        keymap.set('n', '<Leader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
        keymap.set('n', '<Leader>h', '<Cmd>lua vim.lsp.buf.hover()<CR>')
        keymap.set('x', '<Leader>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>')
    end
    require('mason-lspconfig').setup_handlers{
        function (server_name)
            lspconfig[server_name].setup{
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end,
    }

    lspconfig.lua_ls.setup{
        root_dir =  util.find_git_ancestor,
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = {'vim'}
                }
            }
        }
    }
end
