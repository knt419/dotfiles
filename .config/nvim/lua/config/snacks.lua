return {
    bigfile = { enabled = true },
    dashboard = {
        enabled = true,
        preset = {
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
        },
        sections = {
            { section = 'header' },
            { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
            { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
            { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
            { section = 'startup' },
        },
    },
    explorer = { enabled = true },
    indent = { enabled = true },
    notifier = {
        enabled = true,
        style = 'fancy',
        -- keep = function(notif)
        --     return vim.fn.getcmdpos() > 0 or vim.bo.buftype == 'prompt'
        -- end,
        keep = false,
        -- filter = function(notif)
        --     return not notif.msg:match("^:%s*")
        -- end,
        filter = nil,
    },
    picker = {
        enabled = true,
        ui_select = true,
        sources = {
            files = {
                hidden = true,
                cmd = 'fd',
            },
            grep = {
                hidden = true,
                cmd = 'rg',
                regex = true,
            },
        },
        win = {
            input = {
                keys = {
                    ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
                },
            },
        },
    },
    statuscolumn = {
        enabled = true,
        left = { 'git' },
        right = { 'sign' },
        git = {
            pattens = { 'GitSign', 'MiniDiffSign' },
        }
    },
    styles = {
        notification = {
            -- wo = { wrap = true }         -- Wrap notifications
        }
    }
}
