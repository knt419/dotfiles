-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28
-- config.window_background_opacity = 0.95
config.window_background_opacity = 0
config.win32_system_backdrop = 'Mica'
config.use_ime = true
config.window_decorations = "RESIZE"
config.show_tabs_in_tab_bar = true
-- config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}

config.window_background_gradient = {
  colors = { "#000000" },
}
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
}
config.keys = {
    { key = "PageDown", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
    { key = "PageUp", mods = "CTRL", action = wezterm.action.ActivateTabRelative(-1) },
    {
    key = 'n', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnCommandInNewTab {
      args = { 'nvim' }
        }
    },
}

-- or, changing the font size and color scheme.
config.font_size = 16
config.font = wezterm.font 'OperatorMono Nerd Font'
config.color_scheme = 'Aquarium Dark'

-- Spawn a fish shell in login mode
config.default_prog = { 'nu' }

-- Finally, return the configuration to wezterm:
return config
