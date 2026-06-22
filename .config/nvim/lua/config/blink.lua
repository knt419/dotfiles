return {
    keymap = {
        preset = 'enter',
        ['<Tab>'] = {
            function(cmp)
                if cmp.is_visible() then
                    cmp.select_next()
                    return true
                end
            end,
            'snippet_forward',
            'fallback',
        },
        ['<S-Tab>'] = {
            function(cmp)
                if cmp.is_visible() then
                    cmp.select_prev()
                    return true
                end
            end,
            'snippet_backward',
            'fallback',
        },
    },
    cmdline = {
        enabled = true,
        completion = {
            list = {
                selection = {
                    preselect = true,
                },
            },
            menu = { auto_show = true },
        },
        keymap = {
            ['<CR>'] = {
                function(cmp)
                    if cmp.is_visible() then
                        local line = vim.fn.getcmdline()
                        local cmd = line:match("^(%S+)") or ""

                        if vim.fn.fullcommand(cmd) == '' then --コマンドが存在しない場合に補完
                            cmp.select_and_accept()
                            return true
                        else
                            return false
                        end
                    end
                end,
                'fallback',
            },
        },
    },
    completion = {
        list = {
            selection = {
                preselect = false,
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
        },
        menu = {
            draw = {
                columns = { { 'kind_icon' }, { 'label', gap = 1 } },
                components = {
                    label = {
                        text = function(ctx)
                            return require('colorful-menu').blink_components_text(ctx)
                        end,
                        highlight = function(ctx)
                            return require('colorful-menu').blink_components_highlight(ctx)
                        end,
                    },
                },
            },
        },
    },
    snippets = {
        preset = 'luasnip',
    },
    sources = {
        default = { 'copilot', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
            copilot = {
                name = 'copilot',
                module = 'blink-copilot',
                score_offset = 100,
                async = true,
            },
        },
    },
    fuzzy = {
        implementation = 'prefer_rust_with_warning',
    },
}
