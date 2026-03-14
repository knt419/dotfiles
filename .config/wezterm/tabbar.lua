local wezterm = require 'wezterm'

local ICON_COLOR = { '#ffb2cc', '#a4a4a4' }
local FONT_COLOR = { '#dddddd', '#888888' }
local TAB_COLOR = { '#404040', 'none' }
local BORDER_LEFT = { wezterm.nerdfonts.ple_left_half_circle_thick, ' ' }
local BORDER_RIGHT = { wezterm.nerdfonts.ple_right_half_circle_thick, ' ' }

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local index = tab.is_active and 1 or 2
    local zoomed = tab.active_pane.is_zoomed and '🔎 ' or ' '
    local title = tab.active_pane.foreground_process_name:match("([^/\\]+)$"):gsub("%.[eE][xX][eE]$", "") or 'wezterm'

    local icons = {
        ["bash"] = wezterm.nerdfonts.dev_terminal,
        ["wezterm"] = wezterm.nerdfonts.dev_terminal,
        ["zsh"] = wezterm.nerdfonts.dev_terminal,
        ["nu"] = wezterm.nerdfonts.dev_terminal,
        ["vim"] = wezterm.nerdfonts.custom_vim,
        ["nvim"] = wezterm.nerdfonts.custom_neovim,
        ["python"] = wezterm.nerdfonts.dev_python,
        ["node"] = wezterm.nerdfonts.dev_nodejs_small,
    }

    return {
        { Foreground = { Color = TAB_COLOR[index] } },
        { Background = { Color = 'none' } },
        { Text = BORDER_LEFT[index] },

        { Foreground = { Color = ICON_COLOR[index] } },
        { Background = { Color = TAB_COLOR[index] } },
        { Text = ( icons[title] or wezterm.nerdfonts.dev_terminal ) .. zoomed },

        { Foreground = { Color = FONT_COLOR[index] } },
        { Background = { Color = TAB_COLOR[index] } },
        { Text = title },

        { Foreground = { Color = TAB_COLOR[index] } },
        { Background = { Color = 'none' } },
        { Text = BORDER_RIGHT[index] },
    }
end)
