return {
    keymap = {
        preset = 'enter',
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    },
    cmdline = {
        enabled = true,
        completion = {
            menu = { auto_show = true },
        },
    },
    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
            window = {
                winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
            },
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
