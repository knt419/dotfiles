return function()
    local starter = require('mini.starter')
    starter.setup({
        evaluate_single = true,
        header = table.concat (
            {   " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
                " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
                " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
                " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
                " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
                " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
                ""
            }, "\n")
        ,
        items = {
            starter.sections.recent_files(5, false, false),
            { name = "Open file", action = "Telescope frecency theme=ivy", section = "Telescope" },
            { name = "File browser", action = "lua require'telescope'.extensions.file_browser.file_browser()", section = "Telescope" },
            { name = "Init.lua", action = "e $MYVIMRC", section = "Config" },
            { name = "Plugin.lua", action = "e ~/.config/nvim/lua/plugins.lua", section = "Config" },
            { name = "Lazy.nvim", action = "Lazy", section = "Config" },
            { name = "Mason", action = "Mason", section = "Config" },
            starter.sections.builtin_actions(),
        },
        content_hooks = {
            starter.gen_hook.adding_bullet(" │ "),
            starter.gen_hook.indexing('all', { 'Telescope', 'Config', 'Builtin actions' } ),
            starter.gen_hook.aligning('center', 'center'),
        },
    })
    vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
            if vim.bo.filetype == "starter" then
                local stats = require"lazy".stats()
                starter.config.footer = 'neovim loaded ' .. stats.count .. ' packages, ' .. string.format("%.2f",stats.startuptime) .. 'ms to launch 🚀'
                pcall(starter.refresh)
            end
        end,
    })
    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniStarterOpened",
        command = "cd ~"
    })
    local keymap = vim.keymap
    keymap.set("n", "<Up>", "<Cmd>lua MiniStarter.open()<CR>")
end
