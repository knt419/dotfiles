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
                }, '\n'),
            keys = {
                { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                { icon = " ", key = "y", desc = "Browse File", action = ':Yazi' },
                { icon = " ", key = "n", desc = "New File", action = ":enew" },
                { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
                { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                { icon = "󰗶 ", key = "h", desc = "Check Health", action = ":checkhealth" },
                { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },
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
    input = { enabled = true },
    indent = { enabled = true },
    notifier = {
        enabled = true,
        style = 'fancy',
    },
    picker = {
        enabled = true,
        matcher = {
            frecency = true,
        },
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
            explorer = {
                win = {
                    list = {
                        keys = {
                            ['.'] = 'toggle_hidden',
                        }
                    }
                }
            }
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
        left = { 'fold', 'git' },
        right = { 'sign' },
        folds = {
            open = false,
            git_hl = false,
        },
        git = {
            pattens = 'MiniDiffSign',
        }
    },
    styles = {
        notification = {
            wo = { wrap = true } -- Wrap notifications
        }
    }
}
