return function()
    local starter = require('mini.starter')
    starter.setup({
        autoopen = false,
        evaluate_single = true,
        header = table.concat(
            {
                '                                                                      ▄██████▄        ',
                '                                                                  ▄█▀▀▀▀▀██▀▀▀▀▀█▄    ',
                ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗          ▐█      ▐▌      █▌   ',
                ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║          ▐█▄    ▄██▄    ▄█▌   ',
                ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║  ▄█▄    ▄▄███████▀▀███████▄▄  ',
                ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║   ▀    ████     ▄  ▄     ████ ',
                ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║        ████     █  █     ████ ',
                ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝        ▀███▄            ▄███▀ ',
                '                                                                  ▀▀████████████▀▀    '
            }, '\n')
        ,
        items = {
            starter.sections.recent_files(5, false, false),
            { name = 'Open file', action = 'lua require(\'telescope\').extensions.smart_open.smart_open(require(\'telescope.themes\').get_ivy({ winblend = 10 }))', section = '  Telescope' },
            { name = 'File browser', action = 'lua require(\'telescope\').extensions.file_browser.file_browser()', section = '  Telescope' },
            { name = 'Init.lua', action = 'e $MYVIMRC', section = '  Config' },
            { name = 'Plugin.lua', action = 'e ~/.config/nvim/lua/plugins.lua', section = '  Config' },
            { name = 'Lazy.nvim', action = 'Lazy', section = '  Config' },
            { name = 'Mason', action = 'Mason', section = '  Config' },
            { name = 'Edit new buffer', action = 'enew', section = '  Builtin actions' },
            { name = 'Quit Neovim', action = 'qall', section = '  Builtin actions' },
        },
        content_hooks = {
            starter.gen_hook.adding_bullet(' │ '),
            starter.gen_hook.indexing('all', { '  Telescope', '  Config', '  Builtin actions' }),
            function(content)
                for _, line in ipairs(content) do
                    for _, unit in ipairs(line) do
                        if unit.string == 'Recent files' then
                            unit.string = '  Recent files'
                        end
                    end
                end
                return content
            end,
            starter.gen_hook.aligning('center', 'center'),
        },
    })
    vim.keymap.set('n', '<Leader>s', '<Cmd>lua MiniStarter.open()<CR>')
end
