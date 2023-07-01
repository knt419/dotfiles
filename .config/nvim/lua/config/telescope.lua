return function()
    local telescope = require('telescope')
    telescope.setup {
        defaults = {
            winblend = 30,
            cache_picker = {limit_entries = 100},
            preview = {filesize_limit = 5, treesitter = true},
            mappings = {i = {['<Esc>'] = require('telescope.actions').close}},
        },
        pickers = {
            find_files = {
                theme = 'ivy',
                find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
            }
        },
        extensions = {
            file_browser = {
                theme = 'ivy',
                hidden = true
            },
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = 'smart_case'
            },
        }
    }
    telescope.load_extension('fzf')
    telescope.load_extension('file_browser')
    telescope.load_extension('frecency')
end
