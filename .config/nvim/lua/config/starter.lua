return function()
    local starter = require('mini.starter')
    local function open_fzf_lua_explorer()
        require("fzf-lua").setup({})
        require("fzf-lua-explorer").setup({
            show_icons = true,
            clipboard_buffer = { enabled = false },
        })
        require("fzf-lua-explorer").explorer({ cwd = vim.fn.getcwd() })
    end
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
            { name = 'Open file', action = 'lua require("fzf-lua-frecency").frecency()', section = '  fzf-lua' },
            { name = 'File browser', action = 'open_fzf_lua_explorer()', section = '  fzf-lua' },
            { name = 'Init.lua', action = 'e $MYVIMRC', section = '  Config' },
            { name = 'Plugin.lua', action = 'e ~/.config/nvim/lua/plugins.lua', section = '  Config' },
            { name = 'Lazy.nvim', action = 'Lazy', section = '  Config' },
            { name = 'Mason', action = 'Mason', section = '  Config' },
            { name = 'Edit new buffer', action = 'enew', section = '  Builtin actions' },
            { name = 'Quit Neovim', action = 'qall', section = '  Builtin actions' },
        },
        content_hooks = {
            starter.gen_hook.adding_bullet(' │ '),
            starter.gen_hook.indexing('all', { '  fzf-lua', '  Config', '  Builtin actions' }),
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
