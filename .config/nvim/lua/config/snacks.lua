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
    input = { enabled = true },
    indent = { enabled = true },
    notifier = {
        enabled = true,
        style = 'fancy',
    },
    picker = {
        enabled = true,
        ui_select = true,
        layout = {
            backdrop = false, -- 背景の黒いマスクウィンドウを消去する（最重要）
        },
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
