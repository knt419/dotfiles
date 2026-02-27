-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28
config.window_background_opacity = 0.95

-- or, changing the font size and color scheme.
config.font_size = 16
config.font = wezterm.font 'OperatorMono Nerd Font'
config.color_scheme = 'Aquarium Dark'

-- Spawn a fish shell in login mode
config.default_prog = { 'nu' }

-- Finally, return the configuration to wezterm:
return config
