return function()
    require('nvim-treesitter.configs').setup {
        auto_install = true,
        highlight = {
            enable = true
        },
        indent = {
            enable = true
        },
        matchup = {
            enable = true
        },
        pairs = {
            enable = true,
            keymaps = {
                goto_partner = '<leader>%',
                delete_balanced = 'X'
            },
            delete_balanced = {
                only_on_first_char = false,
                longest_partner = false
            }
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = false,
                node_incremental = false,
                scope_incremental = false,
                node_decremental = false,
            },
        },
    }
end
