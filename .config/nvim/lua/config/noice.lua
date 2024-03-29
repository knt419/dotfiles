return function()
    require('noice').setup({
        lsp = {
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
                ['cmp.entry.get_documentation'] = true,
            },
        },
        routes = {
            {
                filter = {
                    event = 'msg_show',
                    find = '%d+L, %d+B',
                },
                view = 'mini',
            },
        },
        presets = {
            inc_rename = true,
        },
    })
end
