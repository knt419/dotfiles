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
                goto_partner = "<leader>%",
                delete_balanced = "X"
            },
            delete_balanced = {
                only_on_first_char = false,
                longest_partner = false
            }
        }
    }
end
