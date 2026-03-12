local wezterm = require 'wezterm'

local SYMBOL_COLOR = { '#ffb2cc', '#a4a4a4' }
local FONT_COLOR = { '#dddddd', '#888888' }
local TAB_COLOR = { '#404040', 'none' }
local BORDER_LEFT = { wezterm.nerdfonts.ple_left_half_circle_thick, ' ' }
local BORDER_RIGHT = { wezterm.nerdfonts.ple_right_half_circle_thick, ' ' }

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
    return "WezTerm"
end)

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local index = tab.is_active and 1 or 2
    local zoomed = tab.active_pane.is_zoomed and '🔎 ' or ' '
    local pane = wezterm.mux.get_pane(tab.active_pane.pane_id)
    local info = pane:get_foreground_process_info()

    local title = "wezterm"

    local priority_processes = { "nvim", "vim", "tmux", "ssh", "pwsh", "powershell", "cmd", "bash", "zsh", "nu" }

    local current_info = info
    while current_info do
        local process_name = current_info.name:match("([^/\\]+)$"):gsub("%.[eE][xX][eE]$", "")

        for _, priority in ipairs(priority_processes) do
            if process_name:lower() == priority then
                title = priority
                break
            else
                title = process_name
            end
        end
        current_info = current_info.parent
    end

    local icons = {
        ["bash"] = wezterm.nerdfonts.dev_terminal .. ' ',
        ["wezterm"] = wezterm.nerdfonts.dev_terminal .. ' ',
        ["zsh"] = wezterm.nerdfonts.dev_terminal .. ' ',
        ["nu"] = wezterm.nerdfonts.dev_terminal .. ' ',
        ["vim"] = wezterm.nerdfonts.custom_vim .. ' ',
        ["nvim"] = wezterm.nerdfonts.custom_neovim .. ' ',
        ["python"] = wezterm.nerdfonts.dev_python .. ' ',
    }

    return {
        { Foreground = { Color = TAB_COLOR[index] } },
        { Background = { Color = 'none' } },
        { Text = BORDER_LEFT[index] },

        { Foreground = { Color = SYMBOL_COLOR[index] } },
        { Background = { Color = TAB_COLOR[index] } },
        { Text = icons[title] or wezterm.nerdfonts.dev_terminal .. zoomed },

        { Foreground = { Color = FONT_COLOR[index] } },
        { Background = { Color = TAB_COLOR[index] } },
        { Text = title },

        { Foreground = { Color = TAB_COLOR[index] } },
        { Background = { Color = 'none' } },
        { Text = BORDER_RIGHT[index] },
    }
end)
