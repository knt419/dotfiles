local wezterm = require 'wezterm'

local HEADER = ''

local SYMBOL_COLOR = { '#ffb2cc', '#a4a4a4' }
local FONT_COLOR = { '#dddddd', '#888888' }
local TAB_COLOR = { '#404040', 'none' }
local BORDER_LEFT = { wezterm.nerdfonts.ple_left_half_circle_thick, ' ' }
local BORDER_RIGHT = { wezterm.nerdfonts.ple_right_half_circle_thick, ' ' }

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local index = tab.is_active and 1 or 2

  local zoomed = tab.active_pane.is_zoomed and '🔎 ' or ' '

  return {
    { Foreground = { Color = TAB_COLOR[index] } },
    { Background = { Color = 'none' } },
    { Text = BORDER_LEFT[index] },
    { Foreground = { Color = SYMBOL_COLOR[index] } },
    { Background = { Color = TAB_COLOR[index] } },
    { Text = HEADER .. zoomed },

    { Foreground = { Color = FONT_COLOR[index] } },
    { Background = { Color = TAB_COLOR[index] } },
    { Text = tab.active_pane.title },
    { Foreground = { Color = TAB_COLOR[index] } },
    { Background = { Color = 'none' } },
    { Text = BORDER_RIGHT[index] },
  }
end)
