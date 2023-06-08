return function()
    local cmp = require"cmp"
    local lspkind = require"lspkind"
    local luasnip = require"luasnip"

    cmp.setup {
        formatting = {
            format = lspkind.cmp_format(
                {
                    with_text = true,
                    maxwidth = 50,
                    ellipsis_char = '...'
                }
            )
        },
        snippet = {
            expand = function(args)
                require'luasnip'.lsp_expand(args.body)
            end
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        mapping = {
            ["<CR>"] = cmp.mapping.confirm({select = true}),
            ["<Tab>"] = cmp.mapping(
                function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                    end
                end,
                {"i", "s"}
            ),
            ["<S-Tab>"] = cmp.mapping(
                function()
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end,
                {"i", "s"}
            )
        },
        sources = cmp.config.sources(
            {
                {name = "nvim_lsp"},
                {name = "nvim_lua"},
                {name = "luasnip"},
                {name = "buffer"}
            }
        ),
        experimental = {
            ghost_text = {
                hl_group = "LspCodeLens",
            },
        },
    }
    cmp.setup.cmdline(
        "/",
        {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                {name = "buffer"}
            }
        }
    )
    cmp.setup.cmdline(
        ":",
        {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
                {
                    {name = "async_path"},
                    {name = "cmdline"}
                }
            )
        }
    )
end
