local wezterm = require 'wezterm'

local ICON_COLOR = { '#ffb2cc', '#a4a4a4' }
local FONT_COLOR = { '#dddddd', '#888888' }
local TAB_COLOR = { '#404040', 'none' }
local BORDER_LEFT = { wezterm.nerdfonts.ple_left_half_circle_thick, ' ' }
local BORDER_RIGHT = { wezterm.nerdfonts.ple_right_half_circle_thick, ' ' }

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local index = tab.is_active and 1 or 2
    local zoomed = tab.active_pane.is_zoomed and '🔎 ' or ' '
    local process = tab.active_pane.foreground_process_name
    local title = 'wezterm'
    if process then
        title = tab.active_pane.foreground_process_name:match("([^/\\]+)$"):gsub("%.[eE][xX][eE]$", "")
    end

    local icons = {
        ["bash"]    = { wezterm.nerdfonts.dev_terminal,      '#3e91da' },
        ["wezterm"] = { wezterm.nerdfonts.dev_terminal,      '#5042d0' },
        ["zsh"]     = { wezterm.nerdfonts.dev_terminal,      '#f15a24' },
        -- ["nu"]      = { wezterm.nerdfonts.dev_terminal,      '#1dd361' },
        ["nu"]      = { '>',      '#1dd361' },
        ["vim"]     = { wezterm.nerdfonts.custom_vim,        '#A6E22E' },
        ["nvim"]    = { wezterm.nerdfonts.custom_neovim,     '#6ebf60' },
        ["python"]  = { wezterm.nerdfonts.dev_python,        '#F92672' },
        ["node"]    = { wezterm.nerdfonts.dev_nodejs_small,  '#A6E22E' },
        ["wslhost"] = { wezterm.nerdfonts.dev_archlinux,     '#1793d1' },
        ["wsl"]     = { wezterm.nerdfonts.dev_archlinux,     '#1793d1' },
    }

    local entry = icons[title] or { wezterm.nerdfonts.dev_terminal, ICON_COLOR[index] }
    local icon, icon_color = entry[1], entry[2]

    return {
        { Foreground = { Color = TAB_COLOR[index] } },
        { Background = { Color = 'none' } },
        { Text = BORDER_LEFT[index] },

        { Foreground = { Color = icon_color } },
        { Background = { Color = TAB_COLOR[index] } },
        { Text = icon .. zoomed },

        { Foreground = { Color = FONT_COLOR[index] } },
        { Background = { Color = TAB_COLOR[index] } },
        { Text = title },

        { Foreground = { Color = TAB_COLOR[index] } },
        { Background = { Color = 'none' } },
        { Text = BORDER_RIGHT[index] },
    }
end)
